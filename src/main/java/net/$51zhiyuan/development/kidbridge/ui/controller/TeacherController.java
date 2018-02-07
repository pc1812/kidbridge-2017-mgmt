package net.$51zhiyuan.development.kidbridge.ui.controller;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.service.TeacherService;
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
@RequestMapping("/teacher")
public class TeacherController {

    private final Logger logger = LogManager.getLogger(TeacherController.class);

    @Autowired
    private TeacherService teacherService;

    @ResponseBody
    @RequestMapping(value = "/search", produces = MediaType.APPLICATION_JSON_VALUE)
    Object search(@RequestBody Map param){
        boolean success = false;
        String message = "";
        Object data = new ArrayList();
        Map response = new HashMap();
        try{
            Map map = this.teacherService.search((Integer) param.get("page"),param.get("keyword") == null ? "" : param.get("keyword").toString());
            data = map;
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

    @RequestMapping("/list")
    Object list(String page){
        ModelAndView view = new ModelAndView();
        Map map = this.teacherService.list(new HashMap(){{
            this.put("page",page);
        }});
        view.addObject("teacherList",map.get("dataList"));
        view.addObject("page",map.get("page"));
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/add",method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
    Object add(@RequestBody Map param){
        boolean success = false;
        String message = "";
        Object data = new ArrayList();
        Map response = new HashMap();
        try{
            this.teacherService.add(param);
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
            this.teacherService.edit(param);
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

