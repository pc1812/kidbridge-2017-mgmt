package net.$51zhiyuan.development.kidbridge.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.ui.model.Bookshelf;
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
 * 书单
 */
@Service
public class BookshelfService {

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.bookshelf.";

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Autowired
    private BookshelfDetailService bookshelfDetailService;

    /**
     * 获取书单列表
     * @param param
     * @return
     */
    public Map list(Map param){
        int show = 20;
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
            this.put("page",new HashMap(){{ // 分页信息
                this.put("numberList",pageNumberList);
                this.put("min",1);
                this.put("max",totalPage);
                this.put("current",currPage);
            }});
            this.put("dataList",dataList); // 书单列表信息
        }};
    }

    /**
     * 获取单个书单详情
     * @param bookshelfId
     * @return
     */
    public Bookshelf get(Integer bookshelfId){
        return this.sqlSessionTemplate.selectOne(this.namespace + "get",bookshelfId);
    }

    /**
     * 新添加一个书单
     * @param param
     */
    @Transactional
    public void add(Map param){
        if(param.get("icon") == null || StringUtils.isBlank(param.get("icon").toString())){
            throw new KidbridgeSimpleException("未知的书单图标 ~");
        }
        if(param.get("name") == null || StringUtils.isBlank(param.get("name").toString())){
            throw new KidbridgeSimpleException("未知的书单名称 ~");
        }
        if(param.get("tag") == null || ((List)param.get("tag")).size() == 0){
            //throw new KidbridgeSimpleException("至少包含一个书单标签 ~");
            param.put("tag",new ArrayList());
        }
        if(param.get("cover") == null || StringUtils.isBlank(param.get("cover").toString())){
            throw new KidbridgeSimpleException("未知的封面信息 ~");
        }
        if(((Map)param.get("cover")).get("icon") == null || StringUtils.isBlank(((Map)param.get("cover")).get("icon").toString())){
            throw new KidbridgeSimpleException("未知的封面图标 ~");
        }
        if(((Map)param.get("cover")).get("link") == null || StringUtils.isBlank(((Map)param.get("cover")).get("link").toString())){
            throw new KidbridgeSimpleException("未知的封面链接 ~");
        }
        // 插入书单信息
        this.sqlSessionTemplate.insert(this.namespace + "add",param);
        // 插入书单下的绘本信息
        this.bookshelfDetailService.add(Integer.valueOf(param.get("id").toString()),(List) param.get("book"));
    }

    /**
     * 书单信息编辑
     * @param param
     */
    @Transactional
    public void edit(Map param){
        if(param.get("icon") == null || StringUtils.isBlank(param.get("icon").toString())){
            throw new KidbridgeSimpleException("未知的书单图标 ~");
        }
        if(param.get("name") == null || StringUtils.isBlank(param.get("name").toString())){
            throw new KidbridgeSimpleException("未知的书单名称 ~");
        }
        if(param.get("tag") == null || ((List)param.get("tag")).size() == 0){
            //throw new KidbridgeSimpleException("至少包含一个书单标签 ~");
            param.put("tag",new ArrayList());
        }
        if(param.get("cover") == null || StringUtils.isBlank(param.get("cover").toString())){
            throw new KidbridgeSimpleException("未知的封面信息 ~");
        }
        if(((Map)param.get("cover")).get("icon") == null || StringUtils.isBlank(((Map)param.get("cover")).get("icon").toString())){
            throw new KidbridgeSimpleException("未知的封面图标 ~");
        }
        if(((Map)param.get("cover")).get("link") == null || StringUtils.isBlank(((Map)param.get("cover")).get("link").toString())){
            throw new KidbridgeSimpleException("未知的封面链接 ~");
        }
        // 修改书单信息
        this.sqlSessionTemplate.update(this.namespace + "edit",param);
        // 修改书单下的绘本信息
        this.bookshelfDetailService.edit(Integer.valueOf(param.get("id").toString()),(List) param.get("book"));
    }

    /**
     * 书单编辑
     * @param bookshelfId
     */
    @Transactional
    public void del(Integer bookshelfId){
        if(bookshelfId == null){
            throw new KidbridgeSimpleException("未知的书单信息 ~");
        }
        this.sqlSessionTemplate.update(this.namespace + "del",bookshelfId);
    }

    /**
     * 设置热门书单
     * @param bookshelfId
     */
    @Transactional
    public void hot(Integer bookshelfId){
        if(bookshelfId == null){
            throw new KidbridgeSimpleException("未知的书单信息 ~");
        }
        this.sqlSessionTemplate.insert(this.namespace + "hot",bookshelfId);
    }

    /**
     * 设置今日打卡书单
     * @param bookshelfId
     */
    @Transactional
    public void recommend(Integer bookshelfId){
        if(bookshelfId == null){
            throw new KidbridgeSimpleException("未知的书单信息 ~");
        }
        this.sqlSessionTemplate.insert(this.namespace + "recommend",bookshelfId);
    }

    /**
     * 取消热门书单
     * @param bookshelfId
     */
    @Transactional
    public void hotCancel(Integer bookshelfId){
        if(bookshelfId == null){
            throw new KidbridgeSimpleException("未知的书单信息 ~");
        }
        this.sqlSessionTemplate.update(this.namespace + "hotCancel",bookshelfId);
    }

    /**
     * 取消今日打卡书单
     * @param bookshelfId
     */
    @Transactional
    public void recommendCancel(Integer bookshelfId){
        if(bookshelfId == null){
            throw new KidbridgeSimpleException("未知的书单信息 ~");
        }
        this.sqlSessionTemplate.update(this.namespace + "recommendCancel",bookshelfId);
    }


}
