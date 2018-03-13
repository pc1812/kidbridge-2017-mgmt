package net.$51zhiyuan.development.kidbridge.ui.controller;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.service.BookService;
import net.$51zhiyuan.development.kidbridge.ui.model.Book;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/book")
public class BookController {

    private final Logger logger = LogManager.getLogger(BookController.class);

    @Autowired
    private BookService bookService;

    @RequestMapping("/list")
    Object list(String page, String fit,String keyword,String minimum,String maximum){
        ModelAndView view = new ModelAndView();
        Map map = this.bookService.list(new HashMap(){{
            this.put("keyword",keyword);
            this.put("minimum",minimum);
            this.put("maximum",maximum);
            this.put("fit",fit);
            this.put("page",page);
        }});
        int count = this.bookService.count();
        view.addObject("count",count);
        view.addObject("bookList",map.get("dataList"));
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
            Map map = this.bookService.search((Integer) param.get("page"),param.get("keyword") == null ? "" : param.get("keyword").toString());
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

    @RequestMapping("/detail/{id}")
    Object detail(@PathVariable String id){
        ModelAndView view = new ModelAndView("/book/detail");
        Book book = this.bookService.get(Integer.valueOf(id));
        List bookSegmentList = this.bookService.getSegmentList(Integer.valueOf(id));
        view.addObject("book",book);
        view.addObject("bookSegmentList",bookSegmentList);
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
            this.bookService.add(param);
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
    @RequestMapping(value = "/update/price",method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
    Object update_price(@RequestBody Map param){
        boolean success = false;
        String message = "";
        Object data = new ArrayList();
        Map response = new HashMap();
        try{
            this.bookService.updatePrice((List<Integer>) param.get("ids"),(String) param.get("price"));
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

    @RequestMapping(value = "/edit/{id}",method = RequestMethod.GET)
    Object edit(@PathVariable String id){
        ModelAndView view = new ModelAndView("/book/add");
        Book book = this.bookService.get(Integer.valueOf(id));
        List bookSegmentList = this.bookService.getSegmentList(Integer.valueOf(id));
        view.addObject("book",book);
        view.addObject("bookSegmentList",bookSegmentList);
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
            this.bookService.edit(param);
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
            this.bookService.del((int)param.get("id"));
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
