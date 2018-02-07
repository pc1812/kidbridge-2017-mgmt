package net.$51zhiyuan.development.kidbridge.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import org.apache.commons.lang3.StringUtils;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 教师
 */
@Service
public class TeacherService {

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.teacher.";

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

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

    public Map list(Map param){
        int show = 20;
        int currPage = (param.get("page") == null || StringUtils.isBlank(param.get("page").toString())) ? 1 : Integer.parseInt(param.get("page").toString());
        int maxLabel = 9;
        int z = (maxLabel / 2 + 1);
        Page page = PageHelper.startPage(currPage,show);
        List dataList = this.sqlSessionTemplate.selectList(this.namespace + "list");
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

    @Transactional
    public void add(Map param){
        if(param.get("user") == null || StringUtils.isBlank(param.get("user").toString())){
            throw new KidbridgeSimpleException("未知的用户信息 ~");
        }
        if(((Map)param.get("user")).get("id") == null || StringUtils.isBlank(((Map)param.get("user")).get("id").toString())){
            throw new KidbridgeSimpleException("未知的用户编号 ~");
        }
        if(param.get("realname") == null || StringUtils.isBlank(param.get("realname").toString())){
            throw new KidbridgeSimpleException("未知的教师姓名 ~");
        }
        this.sqlSessionTemplate.insert(this.namespace + "add",param);
    }

    @Transactional
    public void edit(Map param){
        if(param.get("id") == null || StringUtils.isBlank(param.get("id").toString())){
            throw new KidbridgeSimpleException("未知的教师信息 ~");
        }
        if(param.get("realname") == null || StringUtils.isBlank(param.get("realname").toString())){
            throw new KidbridgeSimpleException("未知的教师姓名 ~");
        }
        this.sqlSessionTemplate.update(this.namespace + "edit",param);
    }
}
