package net.$51zhiyuan.development.kidbridge.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.module.http.HttpClient;
import net.$51zhiyuan.development.kidbridge.ui.model.Admin;
import net.$51zhiyuan.development.kidbridge.ui.model.Bill;
import net.$51zhiyuan.development.kidbridge.ui.model.User;
import org.apache.commons.lang3.StringUtils;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用户
 */
@Service
public class UserService {

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.user.";

    @Autowired
    private BillService billService;

    @Autowired
    private AuthService authService;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    public Map list(Map param){
        int show = 15;
        int currPage = (param.get("page") == null || StringUtils.isBlank(param.get("page").toString())) ? 1 : Integer.parseInt(param.get("page").toString());
        int maxLabel = 9;
        int z = (maxLabel / 2 + 1);
        Page page = PageHelper.startPage(currPage,show);
        List dataList = this.sqlSessionTemplate.selectList(this.namespace + "list",param);
        int totalPage = page.getPages();
        List pageNumberList = new ArrayList(maxLabel);
        for(int i=0;i<(totalPage < maxLabel ? totalPage : maxLabel);i++){
            if(currPage <= z){
                pageNumberList.add(i + 1);
            }else if(currPage > z && currPage <= totalPage - z + 1){
                int c = currPage - z;
                pageNumberList.add(c + 1 + i);
            }else {
                pageNumberList.add(totalPage < maxLabel ? i + 1 : totalPage - maxLabel + i+1);
            }
        }
        return new HashMap(){{
            this.put("page",new HashMap(){{
                this.put("numberList",pageNumberList);
                this.put("min",1);
                this.put("max",totalPage);
                this.put("current",currPage);
            }});
            this.put("dataList",dataList);
        }};
    }

    public Map search(Integer page,String keyword){
        int show = 10;
        int currPage = page;
        int maxLabel = 9;
        int z = (maxLabel / 2 + 1);
        Page startPage = PageHelper.startPage(currPage,show);
        List dataList = this.sqlSessionTemplate.selectList(this.namespace + "search",keyword);
        int totalPage = startPage.getPages();
        List pageNumberList = new ArrayList(maxLabel);
        for(int i=0;i<(totalPage < maxLabel ? totalPage : maxLabel);i++){
            if(currPage <= z){
                pageNumberList.add(i + 1);
            }else if(currPage > z && currPage <= totalPage - z + 1){
                int c = currPage - z;
                pageNumberList.add(c + 1 + i);
            }else {
                pageNumberList.add(totalPage < maxLabel ? i + 1 : totalPage - maxLabel + i+1);
            }
        }
        return new HashMap(){{
            this.put("page",new HashMap(){{
                this.put("numberList",pageNumberList);
                this.put("min",1);
                this.put("max",totalPage);
                this.put("current",currPage);
            }});
            this.put("dataList",dataList);
        }};
    }

    @Transactional(rollbackFor = Exception.class)
    public void updateBonus(Map param,Admin manager){
        if(param == null || param.size() == 0){
            throw new KidbridgeSimpleException("未知的请求参数 ~");
        }
        if(param.get("id") == null || StringUtils.isBlank(param.get("id").toString())){
            throw new KidbridgeSimpleException("未知的用户信息 ~");
        }
        if(param.get("append") == null || StringUtils.isBlank(param.get("append").toString())){
            throw new KidbridgeSimpleException("未知的附加信息 ~");
        }
        String append = param.get("append").toString();
        if(append.indexOf('.') > -1){
            throw new KidbridgeSimpleException("请输入整数附加信息 ~");
        }
        try {
            Double.parseDouble(append);
        }catch (Exception e){
            throw new KidbridgeSimpleException("非法的附加信息 ~");
        }

        this.sqlSessionTemplate.update(this.namespace + "updateBonus",param);
        this.billService.add(new Bill(){
            @Override
            public User getUser() {
                return new User(){
                    @Override
                    public Integer getId() {
                        return Integer.valueOf(param.get("id").toString());
                    }
                };
            }

            @Override
            public BigDecimal getFee() {
                return new BigDecimal(param.get("append").toString());
            }

            @Override
            public Map getOption() {
                return new HashMap(){{
                    this.put("manager",manager.getId());
                }};
            }

            @Override
            public Integer getBillType() {
                return Integer.parseInt(append) <0 ? 10 : 9;
            }

            @Override
            public Integer getFeeType() {
                return 1;
            }
        });
    }

    public Integer count(){
        return this.sqlSessionTemplate.selectOne(this.namespace + "count");
    }

    @Transactional(rollbackFor = Exception.class)
    public void delete(Integer userId) {
        this.authService.delete(userId);
        this.sqlSessionTemplate.delete(this.namespace + "delete",userId);
        HttpClient httpClient = new HttpClient();
        ObjectMapper objectMapper = new ObjectMapper();
        this.tokenService.delSession(userId);
    }

    @Transactional(rollbackFor = Exception.class)
    public void updateBalance(Map param,Admin manager){
        if(param == null || param.size() == 0){
            throw new KidbridgeSimpleException("未知的请求参数 ~");
        }
        if(param.get("id") == null || StringUtils.isBlank(param.get("id").toString())){
            throw new KidbridgeSimpleException("未知的用户信息 ~");
        }
        if(param.get("append") == null || StringUtils.isBlank(param.get("append").toString())){
            throw new KidbridgeSimpleException("未知的附加信息 ~");
        }
        String append = param.get("append").toString();
        try {
            Double.parseDouble(append);
        }catch (Exception e){
            throw new KidbridgeSimpleException("非法的附加信息 ~");
        }
        this.sqlSessionTemplate.update(this.namespace + "updateBalance",param);
        this.billService.add(new Bill(){
            @Override
            public User getUser() {
                return new User(){
                    @Override
                    public Integer getId() {
                        return Integer.valueOf(param.get("id").toString());
                    }
                };
            }

            @Override
            public BigDecimal getFee() {
                return new BigDecimal(param.get("append").toString());
            }

            @Override
            public Map getOption() {
                return new HashMap(){{
                    this.put("manager",manager.getId());
                }};
            }

            @Override
            public Integer getBillType() {
                return Double.parseDouble(append) <0 ? 10 : 9;
            }

            @Override
            public Integer getFeeType() {
                return 0;
            }
        });
    }
}
