package net.$51zhiyuan.development.kidbridge.service;


import com.google.gson.Gson;
import com.qiniu.common.QiniuException;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.DefaultPutRet;
import com.qiniu.util.Auth;
import net.$51zhiyuan.development.kidbridge.module.Configuration;
import net.$51zhiyuan.development.kidbridge.module.ZipUtil;
import net.$51zhiyuan.development.kidbridge.ui.model.Book;
import net.$51zhiyuan.development.kidbridge.ui.model.BookSegment;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.springframework.stereotype.Service;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 文件上传
 */
@Service
public class FileService {

    private Auth auth;

    private long uploadTokenQuietTime = -1;

    private final String tempPath = System.getProperty("java.io.tmpdir");

    /**
     * 构建七牛Auth对象
     * @return
     */
    public Auth getAuth(){
        if(this.auth == null){
            this.auth = Auth.create(Configuration.property(Configuration.QINIU_ACCESSKEY),Configuration.property(Configuration.QINIU_SECRETKEYSPEC));
        }
        return this.auth;
    }

    /**
     * 获取上传token
     * @return
     */
    public String getToken() {
        String token = this.getAuth().uploadTokenWithPolicy(this.getDefaultPolicy());
        return token;
    }

    /**
     * 构建上传对象
     * @return
     */
    private Map getDefaultPolicy() {
        Map<String,Object> policy = new HashMap();
        policy.put("scope", Configuration.property(Configuration.QINIU_BUCKET));
        policy.put("deadline", this.getUploadTokenQuietTime());
        return policy;
    }

    /**
     * 上传过期时间设置
     * @return
     */
    public long getUploadTokenQuietTime() {
        if(this.uploadTokenQuietTime == -1){
            this.uploadTokenQuietTime = Long.valueOf(Configuration.property(Configuration.QINIU_UPLOAD_TOKEN_QUIET_TIME));
        }
        return (System.currentTimeMillis() / 1000 + this.uploadTokenQuietTime);
    }

    /**
     * 上传导入处理
     * @param bytes
     * @return
     * @throws IOException
     */
    public Book handle(byte[] bytes) throws IOException {
        // 在本地构建一个临时路径，用于解压资源
        File decompressionPath = new File(String.format("%s\\%s\\%s",this.tempPath, "kidbridge",UUID.randomUUID().toString().replace("-","")));
        if(!decompressionPath.exists()){
            decompressionPath.mkdirs();
        }
        // zip资源包解压
        ZipUtil.unzip(bytes,decompressionPath.getPath());
        File bookWordsPath = null; // 文字稿word文档路径
        List<File> bookImage = null; // 段落图片资源列表
        List<File> bookAudio = null; // 段落音频资源列表
        // 遍历解压出来的资源
        for(File file : decompressionPath.listFiles()){
            if(file.getName().indexOf("图片") > -1){ // 处理“图片”文件夹资源
                bookImage = Arrays.asList(file.listFiles());
                // 资源排序
                Collections.sort(bookImage, new Comparator<File>() {
                    @Override
                    public int compare(File o1, File o2) {
                        int int1 = 0;
                        int int2 = 0;
                        Matcher matcher1 = Pattern.compile("(\\d+)\\.\\w+$").matcher(o1.getName());
                        Matcher matcher2 = Pattern.compile("(\\d+)\\.\\w+$").matcher(o2.getName());
                        if(matcher1.find()){
                            int1 = Integer.valueOf(matcher1.group(1));
                        }
                        if(matcher2.find()){
                            int2 = Integer.valueOf(matcher2.group(1));
                        }
                        return int1 > int2 ? 1 : -1;
                    }
                });
            }
            if(file.getName().indexOf("文字") > -1){ // 处理“文字”文件夹资源
                bookWordsPath = file;
            }
            if(file.getName().indexOf("音频") > -1){ // 处理“音频”文件夹资源
                bookAudio = Arrays.asList(file.listFiles());
                // 资源排序
                Collections.sort(bookAudio,new Comparator<File>() {
                    @Override
                    public int compare(File o1, File o2) {
                        int int1 = 0;
                        int int2 = 0;
                        Matcher matcher1 = Pattern.compile("(\\d+)\\.\\w+$").matcher(o1.getName());
                        Matcher matcher2 = Pattern.compile("(\\d+)\\.\\w+$").matcher(o2.getName());
                        if(matcher1.find()){
                            int1 = Integer.valueOf(matcher1.group(1));
                        }
                        if(matcher2.find()){
                            int2 = Integer.valueOf(matcher2.group(1));
                        }
                        return int1 > int2 ? 1 : -1;
                    }
                });
            }
        }

        File bookWordsFile = bookWordsPath.listFiles()[0]; // 文字稿word文档资源，只取第一个文件
        // word文档解析处理
        InputStream inputStream = new FileInputStream(bookWordsFile.getPath());
        XWPFDocument xwpfDocument = new XWPFDocument(inputStream);
        XWPFWordExtractor xwpfWordExtractor = new XWPFWordExtractor(xwpfDocument);
        String bookWordsBody = xwpfWordExtractor.getText(); // 获取word文档纯文本内容
        Book book = new Book();
        Matcher name = Pattern.compile("1，(.*?)\\n").matcher(bookWordsBody); // 正则截取标题
        if(name.find()){
            book.setName(name.group(1));
        }
        Matcher outline = Pattern.compile("\\n故事梗概\n(.*?)\\n").matcher(bookWordsBody); // 正则截取故事梗概
        if(outline.find()){
            book.setOutline(outline.group(1));
        }
        Matcher feeling = Pattern.compile("\\n绘本感悟\n(.*?)\\n").matcher(bookWordsBody); // 正则截取绘本感悟
        if(feeling.find()){
            book.setFeeling(feeling.group(1));
        }
        Matcher tag = Pattern.compile("\\n关键词：(.*?)\\n").matcher(bookWordsBody); // 正则截取关键词
        if(tag.find()){
            // 关键词拆分处理，一整段内容的关键词，只要包含顿号、逗号、空格，都会被拆成数组
            List tagList = null;
            List fTagList = new ArrayList();
            if(tag.group(1).indexOf("、") > -1){
                tagList = Arrays.asList(tag.group(1).split("、"));
            }else if(tag.group(1).indexOf(",") > -1){
                tagList = Arrays.asList(tag.group(1).split(","));
            }else if(tag.group(1).indexOf(" ") > -1){
                tagList = Arrays.asList(tag.group(1).split(" "));
            }else{
                // 如果都没有三个分割字符，只能使用一整段的关键词内容作为关键词
                tagList = new ArrayList();
                tagList.add(tag.group(1));
            }
            for(int i = 0;i<tagList.size();i++){
                String str = tagList.get(i).toString();
                if(!StringUtils.isBlank(str)){
                    // 过滤掉关键词存在的多余空格
                    fTagList.add(str);
                }
            }
            if(fTagList != null && fTagList.size() > 0){
                book.setTag(fTagList);
            }
        }
        Matcher segmentText = Pattern.compile("\\d+，([\\s\\S]*?)\\n\\n").matcher(bookWordsBody);
        List segmentList = new ArrayList();


        for(int i = 0;(segmentText.find());i++){
            BookSegment segment = new BookSegment();
            segment.setText(segmentText.group(1));
            segment.setIcon(this.upload(bookImage.get(i+0)));
            segment.setAudio(this.upload(bookAudio.get(i+1)));
            segmentList.add(segment);
        }
        List icon = new ArrayList();
        icon.add(this.upload(bookImage.get(0)));
        book.setIcon(icon);
        book.setBookSegmentList(segmentList);
        decompressionPath.deleteOnExit();
        return book;
    }

    public Book localUpload(HttpServletRequest request) throws FileUploadException, IOException {
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        if (isMultipart) {
            ServletContext servletContext = request.getServletContext();
            File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(4096);
            factory.setRepository(repository);
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setHeaderEncoding("utf-8");
            List<FileItem> items = upload.parseRequest(request);
            for (FileItem item : items) {
                if (!item.isFormField()) {
                    if (item.getSize() == 0) {
                        continue;
                    }
                    return this.handle(item.get());
                }
            }
        }
        return new Book();
    }

    public String upload(File file) throws QiniuException {
        FileService fileService = new FileService();
        String uploadToken = fileService.getToken();
        com.qiniu.storage.Configuration cfg = new com.qiniu.storage.Configuration(Zone.zone0());
        UploadManager uploadManager = new UploadManager(cfg);
        Response response = uploadManager.put(file.getPath(), null, uploadToken);
        DefaultPutRet putRet = new Gson().fromJson(response.bodyString(), DefaultPutRet.class);
        return putRet.key;
    }
}
