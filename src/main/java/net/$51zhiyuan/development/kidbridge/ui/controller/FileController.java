package net.$51zhiyuan.development.kidbridge.ui.controller;

import net.$51zhiyuan.development.kidbridge.service.FileService;
import net.$51zhiyuan.development.kidbridge.ui.model.Book;
import net.$51zhiyuan.development.kidbridge.ui.model.Message;
import net.$51zhiyuan.development.kidbridge.ui.model.Version;
import org.apache.commons.fileupload.FileUploadException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.xmlpull.v1.XmlPullParserException;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;

@Controller
@RequestMapping("/file")
public class FileController {

    @Autowired
    private FileService fileService;

    @Autowired
    private HttpServletRequest httpServletRequest;

    @ResponseBody
    @RequestMapping(value = "/token", produces = MediaType.APPLICATION_JSON_VALUE)
    Object token(){
        return new HashMap(){{
            this.put("event","SUCCESS");
            this.put("data",new HashMap(){{
                this.put("token",fileService.getToken());
            }});
            this.put("describe","");
        }};
    }

    @ResponseBody
    @RequestMapping(value = "/upload", produces = MediaType.APPLICATION_JSON_VALUE)
    Object upload() throws FileUploadException, IOException {
        Book book = this.fileService.bookUpload(this.httpServletRequest);
        return new HashMap(){{
            this.put("book",book);
        }};
    }

    @ResponseBody
    @RequestMapping(value = "/apkUpload", produces = MediaType.APPLICATION_JSON_VALUE)
    Object apkUpload() throws FileUploadException, IOException, XmlPullParserException {
        Version version = this.fileService.apkUpload(this.httpServletRequest);
        return new Message(version);
    }
}
