package net.$51zhiyuan.development.kidbridge.ui.controller;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.service.BookService;
import net.$51zhiyuan.development.kidbridge.service.SearchRecordService;
import net.$51zhiyuan.development.kidbridge.ui.model.Book;
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
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/searchrecord")
public class SearchRecordController {

    private final Logger logger = LogManager.getLogger(SearchRecordController.class);

    @Autowired
    private SearchRecordService searchRecordService;

    @RequestMapping("/list")
    Object list(String page, String fit,String keyword){
        ModelAndView view = new ModelAndView();
        Map map = this.searchRecordService.list(new HashMap(){{
            this.put("keyword",keyword);
            this.put("fit",fit);
            this.put("page",page);
        }});
        view.addObject("searchRecordList",map.get("dataList"));
        view.addObject("page",map.get("page"));
        return view;
    }

}
