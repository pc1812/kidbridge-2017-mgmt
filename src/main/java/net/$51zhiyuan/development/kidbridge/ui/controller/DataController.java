package net.$51zhiyuan.development.kidbridge.ui.controller;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.service.ArticleService;
import net.$51zhiyuan.development.kidbridge.service.BillService;
import net.$51zhiyuan.development.kidbridge.service.UserBookRepeatService;
import net.$51zhiyuan.development.kidbridge.service.UserCourseRepeatService;
import net.$51zhiyuan.development.kidbridge.ui.model.Article;
import net.$51zhiyuan.development.kidbridge.ui.model.UserBook;
import net.$51zhiyuan.development.kidbridge.ui.model.UserBookRepeat;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/data")
public class DataController {

    private final Logger logger = LogManager.getLogger(DataController.class);

    @Autowired
    private UserBookRepeatService userBookRepeatService;

    @Autowired
    private UserCourseRepeatService userCourseRepeatService;

    @Autowired
    private BillService billService;

    @RequestMapping("/book/sign/detail/list")
    Object book_sign_detail_list(String page, String beginDate, String endDate) {
        ModelAndView view = new ModelAndView("/data/book");
        Map map = this.userBookRepeatService.detailList(new HashMap(){{
            this.put("page",page);
            this.put("beginDate",beginDate);
            this.put("endDate",endDate);
        }});
        view.addObject("detailList",map.get("dataList"));
        view.addObject("page",map.get("page"));
        return view;
    }

    @ResponseBody
    @RequestMapping("/book/sign/detail/export")
    Object book_sign_detail_export(String page, String beginDate, String endDate) throws IOException {
        byte[] bytes = this.userBookRepeatService.detailExport(new HashMap(){{
            this.put("beginDate",beginDate);
            this.put("endDate",endDate);
        }});
        MultiValueMap headers = new HttpHeaders();
        headers.set("Content-Type","application/octet-stream");
        headers.set("Content-Disposition",String.format("attachment; filename=%s.xlsx", URLEncoder.encode("绘本跟读明细","utf-8")));
        return new ResponseEntity(bytes,headers, HttpStatus.OK);
    }


    @RequestMapping("/course/sign/detail/list")
    Object course_sign_detail_list(String page, String beginDate, String endDate) {
        ModelAndView view = new ModelAndView("/data/course");
        Map map = this.userCourseRepeatService.detailList(new HashMap(){{
            this.put("page",page);
            this.put("beginDate",beginDate);
            this.put("endDate",endDate);
        }});
        view.addObject("detailList",map.get("dataList"));
        view.addObject("page",map.get("page"));
        return view;
    }

    @ResponseBody
    @RequestMapping("/course/sign/detail/export")
    Object course_sign_detail_export(String page, String beginDate, String endDate) throws IOException {
        byte[] bytes = this.userCourseRepeatService.detailExport(new HashMap(){{
            this.put("beginDate",beginDate);
            this.put("endDate",endDate);
        }});
        MultiValueMap headers = new HttpHeaders();
        headers.set("Content-Type","application/octet-stream");
        headers.set("Content-Disposition",String.format("attachment; filename=%s.xlsx", URLEncoder.encode("课程跟读明细","utf-8")));
        return new ResponseEntity(bytes,headers, HttpStatus.OK);
    }

    @RequestMapping("/user/bill/detail/list")
    Object user_bill_detail_list(String page, String beginDate, String endDate){
        ModelAndView view = new ModelAndView("/data/bill");
        Map map = this.billService.detailList(new HashMap(){{
            this.put("page",page);
            this.put("beginDate",beginDate);
            this.put("endDate",endDate);
        }});
        view.addObject("detailList",map.get("dataList"));
        view.addObject("page",map.get("page"));
        return view;
    }

    @ResponseBody
    @RequestMapping("/user/bill/detail/export")
    Object user_bill_detail_export(String page, String beginDate, String endDate) throws IOException {
        byte[] bytes = this.billService.detailExport(new HashMap(){{
            this.put("beginDate",beginDate);
            this.put("endDate",endDate);
        }});
        MultiValueMap headers = new HttpHeaders();
        headers.set("Content-Type","application/octet-stream");
        headers.set("Content-Disposition",String.format("attachment; filename=%s.xlsx", URLEncoder.encode("用户余额明细","utf-8")));
        return new ResponseEntity(bytes,headers, HttpStatus.OK);
    }

}
