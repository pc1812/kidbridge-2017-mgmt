package net.$51zhiyuan.development.kidbridge.test.module;

import com.google.gson.Gson;
import com.qiniu.common.QiniuException;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.DefaultPutRet;
import net.$51zhiyuan.development.kidbridge.service.FileService;
import org.junit.Test;

import java.io.File;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Word {

    private String tempPath = "C:\\Users\\Spring\\Desktop\\temp";

    @Test
    public void z() {

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

    @Test
    public void reg(){
        String str = "啊啊啊啊啊\n是是是是\n故事梗概\n水电费水电费";
        Matcher matcher = Pattern.compile("(\n.*)").matcher(str);
        while (matcher.find()){
            System.out.println(matcher.group(1));
        }
    }

    @Test
    public void t(){
        System.out.println(System.getProperty("java.io.tmpdir"));
    }





}
