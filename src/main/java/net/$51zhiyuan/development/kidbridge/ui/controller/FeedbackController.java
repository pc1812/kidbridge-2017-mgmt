package net.$51zhiyuan.development.kidbridge.ui.controller;

import net.$51zhiyuan.development.kidbridge.service.FeedbackService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/feedback")
public class FeedbackController {

    private final Logger logger = LogManager.getLogger(FeedbackController.class);

    @Autowired
    private FeedbackService feedbackService;

    @RequestMapping("/list")
    Object list(String page){
        ModelAndView view = new ModelAndView("/feedback/list");
        Map map = this.feedbackService.list(new HashMap(){{
            this.put("page",page);
        }});
        view.addObject("feedbackList",map.get("dataList"));
        view.addObject("page",map.get("page"));
        return view;
    }
}
