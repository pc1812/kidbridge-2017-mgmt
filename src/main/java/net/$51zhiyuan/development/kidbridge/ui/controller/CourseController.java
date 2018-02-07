package net.$51zhiyuan.development.kidbridge.ui.controller;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.service.CourseService;
import net.$51zhiyuan.development.kidbridge.ui.model.Course;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/course")
public class CourseController {

    private final Logger logger = LogManager.getLogger(CourseController.class);

    @Autowired
    private CourseService courseService;

    @RequestMapping("/list")
    Object list(String page,String fit,String keyword){
        ModelAndView view = new ModelAndView();
        Map map = this.courseService.list(new HashMap(){{
            this.put("page",page);
            this.put("fit",fit);
            this.put("keyword",keyword);
        }});
        int count = this.courseService.count();
        view.addObject("count",count);
        view.addObject("courseList",map.get("dataList"));
        view.addObject("page",map.get("page"));
        return view;
    }

    @RequestMapping("/add")
    Object add(){
        ModelAndView view = new ModelAndView();

        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/add", method = RequestMethod.POST ,produces = MediaType.APPLICATION_JSON_VALUE)
    Object add(@RequestBody Map param){
        boolean success = false;
        String message = "";
        Object data = new ArrayList();
        Map response = new HashMap();
        try{
            this.courseService.add(param);
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

    @RequestMapping("/detail/{id}")
    Object detail(@PathVariable String id){
        ModelAndView view = new ModelAndView("/course/detail");
        Course course = this.courseService.get(Integer.valueOf(id));
        view.addObject("course",course);
        return view;
    }

    @RequestMapping(value = "/edit/{id}",method = RequestMethod.GET)
    Object edit(@PathVariable String id){
        ModelAndView view = new ModelAndView("/course/add");
        Course course = this.courseService.get(Integer.valueOf(id));
        view.addObject("course",course);
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/edit",method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
    Object edit(@RequestBody Map param){
        boolean success = false;
        String message = "";
        Object data = new ArrayList();
        Map response = new HashMap();
        try{
            this.courseService.edit(param);
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
            this.courseService.del((int)param.get("id"));
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
    @RequestMapping(value = "/hot",produces = MediaType.APPLICATION_JSON_VALUE)
    Object hot(@RequestBody Map param){
        boolean success = false;
        String message = "";
        Object data = new ArrayList();
        Map response = new HashMap();
        try{
            this.courseService.hot((int)param.get("id"));
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
    @RequestMapping(value = "/hot/cancel",produces = MediaType.APPLICATION_JSON_VALUE)
    Object hot_cancel(@RequestBody Map param){
        boolean success = false;
        String message = "";
        Object data = new ArrayList();
        Map response = new HashMap();
        try{
            this.courseService.hotCancel((int)param.get("id"));
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
