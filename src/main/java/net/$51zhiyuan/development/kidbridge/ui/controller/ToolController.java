package net.$51zhiyuan.development.kidbridge.ui.controller;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.service.ToolService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/tool")
public class ToolController {

    private final Logger logger = LogManager.getLogger(ToolController.class);

    @Autowired
    private ToolService toolService;

    @ResponseBody
    @RequestMapping(value = "/wechat/article", produces = MediaType.APPLICATION_JSON_VALUE)
    Object wechat_article(@RequestBody Map param){
        boolean success = false;
        String message = "";
        Map data = new HashMap();
        Map response = new HashMap();
        try{
            String body = this.toolService.getWechatArticle((String) param.get("url"));
            data.put("body",body);
            success = true;
        }catch (KidbridgeSimpleException k){
            message = k.getMessage();
            this.logger.debug(k.getMessage(),k);
        }catch (Exception e){
            message = "系统繁忙，请稍后再试 ~";
            this.logger.error(e.getMessage(),e);
        }
        response.put("success",success);
        response.put("message",message);
        response.put("data",data);
        return response;
    }

}
