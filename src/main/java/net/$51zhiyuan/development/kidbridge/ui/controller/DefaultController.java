package net.$51zhiyuan.development.kidbridge.ui.controller;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.service.AdminService;
import net.$51zhiyuan.development.kidbridge.ui.model.Admin;
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

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Controller
public class DefaultController {

    private final Logger logger = LogManager.getLogger(DefaultController.class);

    @Autowired
    private AdminService adminService;

    @Autowired
    private HttpServletRequest request;

    @RequestMapping(value = {"/","/index"})
    Object index(){
        return "redirect:/user/list";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    Object login(){
        ModelAndView view = new ModelAndView();
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/login", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    Object del(@RequestBody Map param){
        boolean success = false;
        String message = "";
        Object data = new ArrayList();
        Map response = new HashMap();
        try{
            Admin admin = this.adminService.login((String) param.get("name"),(String)param.get("password"));
            this.request.getSession().setAttribute("admin",admin);
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

    @RequestMapping(value = "/logout")
    Object logout(@RequestBody Map param){
        ModelAndView view = new ModelAndView("redirect:/");
        this.request.getSession().removeAttribute("admin");
        return view;
    }

}
