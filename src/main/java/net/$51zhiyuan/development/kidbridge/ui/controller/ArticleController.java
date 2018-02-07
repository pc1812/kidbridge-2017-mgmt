package net.$51zhiyuan.development.kidbridge.ui.controller;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.service.ArticleService;
import net.$51zhiyuan.development.kidbridge.ui.model.Article;
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
@RequestMapping("/article")
public class ArticleController {

    private final Logger logger = LogManager.getLogger(ArticleController.class);

    @Autowired
    private ArticleService articleService;

    @RequestMapping("/list")
    Object list(String page){
        ModelAndView view = new ModelAndView();
        Map map = this.articleService.list(new HashMap(){{
            this.put("page",page);
        }});
        view.addObject("articleList",map.get("dataList"));
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
            this.articleService.add(param);
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

        return view;
    }

    @RequestMapping(value = "/edit/{id}",method = RequestMethod.GET)
    Object edit(@PathVariable String id){
        ModelAndView view = new ModelAndView("/article/add");
        Article article = this.articleService.get(Integer.valueOf(id));
        view.addObject("article",article);
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
            this.articleService.edit(param);
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
            this.articleService.del((int)param.get("id"));
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
