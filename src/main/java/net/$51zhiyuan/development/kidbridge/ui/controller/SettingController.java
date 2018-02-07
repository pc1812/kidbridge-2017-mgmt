package net.$51zhiyuan.development.kidbridge.ui.controller;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.service.ConfigService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/setting")
public class SettingController {

    private final Logger logger = LogManager.getLogger(SettingController.class);

    @Autowired
    private ConfigService configService;

    @RequestMapping("/list")
    Object list(String page){
        ModelAndView view = new ModelAndView();
        view.addObject(ConfigService.CUSTOMER_SERVICE,this.configService.get(ConfigService.CUSTOMER_SERVICE));
        return view;
    }

    @ResponseBody
    @RequestMapping("/update")
    Object update(@RequestBody Map param){
        boolean success = false;
        String message = "";
        Object data = new ArrayList();
        Map response = new HashMap();
        try{
            List<Map<String,String>> settingList = (List) param.get("setting");
            for(Map<String,String> setting : settingList ){
                this.configService.update(setting.get("key"),setting.get("value"));
            }
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
