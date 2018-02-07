package net.$51zhiyuan.development.kidbridge.service;

import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.UploadManager;
import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.module.http.HttpClient;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.UnrecoverableKeyException;
import java.security.cert.CertificateException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 扩展工具业务
 */
@Service
public class ToolService {

    @Autowired
    private FileService fileService;

    public String getWechatArticle(String url) throws CertificateException, UnrecoverableKeyException, NoSuchAlgorithmException, IOException, KeyManagementException, KeyStoreException {
        if(StringUtils.isBlank(url)){
            throw new KidbridgeSimpleException("未知的链接地址 ~");
        }
        String body = "";
        HttpClient httpClient = new HttpClient();
        String resp = httpClient.doGet(url);
        Pattern patternBody = Pattern.compile("<div class=\"rich_media_content \" id=\"js_content\">([\\s\\S]*?)</div>\\r\\n.*?<script nonce=\"\\d+\" type=\"text/javascript\">");
        Matcher matcherBody = patternBody.matcher(resp);
        if (matcherBody.find()) {
            body = matcherBody.group(1);
            Pattern patternImg = Pattern.compile("data-src=\"(.*?)\"");
            Matcher matcherImg = patternImg.matcher(body);
            while (matcherImg.find()) {
                String img = matcherImg.group(1);
                byte[] bytes = httpClient.doGetFile(img);
                com.qiniu.storage.Configuration cfg = new com.qiniu.storage.Configuration(Zone.zone0());
                UploadManager uploadManager = new UploadManager(cfg);
                String token = this.fileService.getToken();
                Response response = uploadManager.put(bytes, null, token);
                if(response.jsonToMap().get("key") == null || StringUtils.isBlank(response.jsonToMap().get("key").toString())){
                    throw new KidbridgeSimpleException("图片转存异常 ~");
                }
                String key = response.jsonToMap().get("key").toString();
                body = body.replace(img,("http://res.kidbridge.org/" + key));
            }
        }
        Pattern wrapPattern = Pattern.compile("\t|\r|\n|\r\n|\\s{2,}");
        Matcher wrapFilter = wrapPattern.matcher(body);
        body = wrapFilter.replaceAll("");
        Pattern urlPattern = Pattern.compile("href=((\".*?\")|('.*?'))");
        Matcher urlMatcher = urlPattern.matcher(body);
        body = urlMatcher.replaceAll("href=\"javascript:;\"");
        return body.replace("data-src","src");
    }
}

