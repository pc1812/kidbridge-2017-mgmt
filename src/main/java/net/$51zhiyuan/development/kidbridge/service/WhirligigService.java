package net.$51zhiyuan.development.kidbridge.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.ui.model.Whirligig;
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
 * 轮播图
 */
@Service
public class WhirligigService {


    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.whirligig.";

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    public Map list(Map param){
        int show = 5;
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

    public Whirligig get(Integer id){
        return this.sqlSessionTemplate.selectOne(this.namespace + "get",id);
    }

    public void add(Map param){
        if(param.get("icon") == null || StringUtils.isBlank(param.get("icon").toString())){
            throw new KidbridgeSimpleException("未知的轮播缩略图 ~");
        }
        if(param.get("link") == null || StringUtils.isBlank(param.get("link").toString())){
            throw new KidbridgeSimpleException("未知的跳转链接 ~");
        }
        this.sqlSessionTemplate.insert(this.namespace + "add",param);
    }

    public void edit(Map param){
        if(param.get("id") == null || StringUtils.isBlank(param.get("id").toString())){
            throw new KidbridgeSimpleException("未知的首页轮播信息 ~");
        }
        if(param.get("icon") == null || StringUtils.isBlank(param.get("icon").toString())){
            throw new KidbridgeSimpleException("未知的缩略图 ~");
        }
        if(param.get("link") == null || StringUtils.isBlank(param.get("link").toString())){
            throw new KidbridgeSimpleException("未知的缩略图 ~");
        }
        this.sqlSessionTemplate.insert(this.namespace + "edit",param);
    }

    @Transactional
    public void del(Integer whirligigId){
        if(whirligigId == null){
            throw new KidbridgeSimpleException("未知的首页轮播信息 ~");
        }
        this.sqlSessionTemplate.update(this.namespace + "del",whirligigId);
    }
}
