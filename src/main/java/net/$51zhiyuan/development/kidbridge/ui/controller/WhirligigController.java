package net.$51zhiyuan.development.kidbridge.ui.controller;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.service.WhirligigService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/whirligig")
public class WhirligigController {

    private final Logger logger = LogManager.getLogger(FeedbackController.class);

    @Autowired
    private WhirligigService whirligigService;

    @RequestMapping("/list")
    Object list(String page){
        ModelAndView view = new ModelAndView("/whirligig/list");
        Map map = this.whirligigService.list(new HashMap(){{
            this.put("page",page);
        }});
        view.addObject("whirligigList",map.get("dataList"));
        view.addObject("page",map.get("page"));
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/get",produces = MediaType.APPLICATION_JSON_VALUE)
    Object get(@RequestBody Map param){
        boolean success = false;
        String message = "";
        Object data = new ArrayList();
        Map response = new HashMap();
        try{
            data = this.whirligigService.get((int) param.get("id"));
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

    @ResponseBody
    @RequestMapping(value = "/add", method = RequestMethod.POST ,produces = MediaType.APPLICATION_JSON_VALUE)
    Object add(@RequestBody Map param){
        boolean success = false;
        String message = "";
        Object data = new ArrayList();
        Map response = new HashMap();
        try{
            this.whirligigService.add(param);
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

    @ResponseBody
    @RequestMapping(value = "/del",produces = MediaType.APPLICATION_JSON_VALUE)
    Object del(@RequestBody Map param){
        boolean success = false;
        String message = "";
        Object data = new ArrayList();
        Map response = new HashMap();
        try{
            this.whirligigService.del((int)param.get("id"));
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

    @ResponseBody
    @RequestMapping(value = "/edit",method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
    Object edit(@RequestBody Map param){
        boolean success = false;
        String message = "";
        Object data = new ArrayList();
        Map response = new HashMap();
        try{
            this.whirligigService.edit(param);
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
