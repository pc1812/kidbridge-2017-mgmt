package net.$51zhiyuan.development.kidbridge.ui.controller;

import net.$51zhiyuan.development.kidbridge.service.FeedbackService;
import net.$51zhiyuan.development.kidbridge.service.VersionService;
import net.$51zhiyuan.development.kidbridge.ui.model.Version;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/version")
public class VersionController {

    private final Logger logger = LogManager.getLogger(VersionController.class);

    @Autowired
    private VersionService versionService;

    @RequestMapping("/list")
    Object list(String page){
        ModelAndView view = new ModelAndView("/version/list");
        Version version = this.versionService.lastVersion(0);
        view.addObject("version",version);
        return view;
    }
}
