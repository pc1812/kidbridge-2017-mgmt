package net.$51zhiyuan.development.kidbridge.ui.controller;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.service.BookshelfService;
import net.$51zhiyuan.development.kidbridge.ui.model.Bookshelf;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/bookshelf")
public class BookshelfController {

    private final Logger logger = LogManager.getLogger(BookshelfController.class);

    @Autowired
    private BookshelfService bookshelfService;

    @RequestMapping("/list")
    Object list(String page,String fit){
        ModelAndView view = new ModelAndView();
        Map map = this.bookshelfService.list(new HashMap(){{
            this.put("page",page);
            this.put("fit",fit);
        }});
        view.addObject("bookshelfList",map.get("dataList"));
        view.addObject("page",map.get("page"));
        return view;
    }

    @RequestMapping(value = "/add",method = RequestMethod.GET)
    Object add(Model model){
        ModelAndView view = new ModelAndView();
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
            this.bookshelfService.add(param);
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
        ModelAndView view = new ModelAndView("/bookshelf/detail");
        Bookshelf bookshelf = this.bookshelfService.get(Integer.valueOf(id));
        view.addObject("bookshelf",bookshelf);
        return view;
    }

    @RequestMapping(value = "/edit/{id}",method = RequestMethod.GET)
    Object edit(@PathVariable String id){
        ModelAndView view = new ModelAndView("/bookshelf/add");
        Bookshelf bookshelf = this.bookshelfService.get(Integer.valueOf(id));
        view.addObject("bookshelf",bookshelf);
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
            this.bookshelfService.edit(param);
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
            this.bookshelfService.del((int)param.get("id"));
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
            this.bookshelfService.hot((int)param.get("id"));
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
    @RequestMapping(value = "/recommend",produces = MediaType.APPLICATION_JSON_VALUE)
    Object recommend(@RequestBody Map param){
        boolean success = false;
        String message = "";
        Object data = new ArrayList();
        Map response = new HashMap();
        try{
            this.bookshelfService.recommend((int)param.get("id"));
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
    Object hotc_ancel(@RequestBody Map param){
        boolean success = false;
        String message = "";
        Object data = new ArrayList();
        Map response = new HashMap();
        try{
            this.bookshelfService.hotCancel((int)param.get("id"));
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
    @RequestMapping(value = "/recommend/cancel",produces = MediaType.APPLICATION_JSON_VALUE)
    Object recommend_cancel(@RequestBody Map param){
        boolean success = false;
        String message = "";
        Object data = new ArrayList();
        Map response = new HashMap();
        try{
            this.bookshelfService.recommendCancel((int)param.get("id"));
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
