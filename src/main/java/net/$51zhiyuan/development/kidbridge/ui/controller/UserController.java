package net.$51zhiyuan.development.kidbridge.ui.controller;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.service.UserService;
import net.$51zhiyuan.development.kidbridge.ui.model.Admin;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    private final Logger logger = LogManager.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private HttpServletRequest httpServletRequest;

    @RequestMapping("/list")
    Object list(String page, String keyword){
        ModelAndView view = new ModelAndView();
        Map map = this.userService.list(new HashMap(){{
            this.put("page",page);
            this.put("keyword",keyword);
        }});
        int count = this.userService.count();
        view.addObject("count",count);
        view.addObject("userList",map.get("dataList"));
        view.addObject("page",map.get("page"));
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/search", produces = MediaType.APPLICATION_JSON_VALUE)
    Object search(@RequestBody Map param){
        boolean success = false;
        String message = "";
        Object data = new ArrayList();
        Map response = new HashMap();
        try{
            Map map = this.userService.search((Integer) param.get("page"), param.get("keyword") == null ? "" : param.get("keyword").toString());
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

    @ResponseBody
    @RequestMapping(value = "/delete", produces = MediaType.APPLICATION_JSON_VALUE)
    Object delete(@RequestBody Map param){
        boolean success = false;
        String message = "";
        List data = new ArrayList();
        Map response = new HashMap();
        try{
            this.userService.delete((int)param.get("id"));
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
    @RequestMapping(value = "/update/bonus", produces = MediaType.APPLICATION_JSON_VALUE)
    Object updateBonus(@RequestBody Map param){
        boolean success = false;
        String message = "";
        List data = new ArrayList();
        Map response = new HashMap();
        try{
            Admin admin = (Admin) httpServletRequest.getSession().getAttribute("admin");
            this.userService.updateBonus(param,admin);
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
    @RequestMapping(value = "/update/balance", produces = MediaType.APPLICATION_JSON_VALUE)
    Object updateBalance(@RequestBody Map param){
        boolean success = false;
        String message = "";
        List data = new ArrayList();
        Map response = new HashMap();
        try{
            Admin admin = (Admin) httpServletRequest.getSession().getAttribute("admin");
            this.userService.updateBalance(param,admin);
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

