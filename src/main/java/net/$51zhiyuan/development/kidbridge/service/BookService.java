package net.$51zhiyuan.development.kidbridge.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.ui.model.Book;
import net.$51zhiyuan.development.kidbridge.ui.model.BookCopyright;
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
 * 绘本
 */
@Service
public class BookService {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Autowired
    private BookCopyrightService bookCopyrightService;

    @Autowired
    private BookSegmentService bookSegmentService;

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.book.";

    /**
     * 绘本列表
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
        // 分页参数处理
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
            this.put("dataList",dataList); // 绘本列表信息
        }};
    }

    /**
     * 获取单个绘本详情
     * @param bookId
     * @return
     */
    public Book get(Integer bookId){
        return this.sqlSessionTemplate.selectOne(this.namespace + "get",new Book(){
            @Override
            public Integer getId() {
                return bookId;
            }
        });
    }

    /**
     * 绘本检索
     * @param page
     * @param keyword
     * @return
     */
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
            this.put("page",new HashMap(){{ // 分页参数
                this.put("numberList",pageNumberList);
                this.put("min",1);
                this.put("max",totalPage);
                this.put("current",currPage);
            }});
            this.put("dataList",dataList); // 检索的绘本信息列表
        }};
    }

    /**
     * 获取绘本的段落列表
     * @param bookId
     * @return
     */
    public List getSegmentList(Integer bookId){
        return this.sqlSessionTemplate.selectList(this.namespace + "getSegment",bookId);
    }

    /**
     * 新增绘本
     * @param param
     */
    @Transactional
    public void add(Map param) {
        if(param.get("icon") == null || ((List)param.get("icon")).size() == 0){
            throw new KidbridgeSimpleException("至少包含一个绘本缩略图 ~");
        }
        if(param.get("name") == null || StringUtils.isBlank(param.get("name").toString())){
            throw new KidbridgeSimpleException("未知的绘本名称 ~");
        }
        if(param.get("tag") == null || ((List)param.get("tag")).size() == 0){
            //throw new KidbridgeSimpleException("至少包含一个绘本标签 ~");
            param.put("tag",new ArrayList());
        }
        if(param.get("price") == null || StringUtils.isBlank(param.get("price").toString())){
            throw new KidbridgeSimpleException("未知的价格信息 ~");
        }
        if(param.get("audio") == null || StringUtils.isBlank(param.get("audio").toString())){
            throw new KidbridgeSimpleException("未知的音频信息 ~");
        }
        try{
            Integer.parseInt(param.get("price").toString());
        }catch (Exception e){
            throw new KidbridgeSimpleException("非法的价格信息 ~");
        }
        if(param.get("active") == null || StringUtils.isBlank(param.get("active").toString())){
            throw new KidbridgeSimpleException("未知的限制跟读时间 ~");
        }
        // 新增绘本数据
        this.sqlSessionTemplate.insert(this.namespace + "add",param);
        // 新增段落数据
        this.bookSegmentService.add(Integer.valueOf(param.get("id").toString()),(List) param.get("segment"));
        if(!(param.get("copyright") == null || ((Map)param.get("copyright")).get("user") == null || ((Map)((Map)param.get("copyright")).get("user")).get("id") == null || StringUtils.isBlank(((Map)((Map)param.get("copyright")).get("user")).get("id").toString()))){
            // 如果该绘本设置了版权用户，添加版权用户数据
            this.bookCopyrightService.add(Integer.valueOf(param.get("id").toString()),Integer.valueOf(((Map)((Map)param.get("copyright")).get("user")).get("id").toString()));
        }
    }

    /**
     * 绘本数量统计
     * @return
     */
    public Integer count(){
        return this.sqlSessionTemplate.selectOne(this.namespace + "count");
    }

    /**
     * 判断某个绘本是否被其它课程引用使用
     * @param bookId
     * @return
     */
    public Boolean existBookInCourse(Integer bookId){
        return ((int)this.sqlSessionTemplate.selectOne(this.namespace + "existBookInCourse",bookId) > 0);
    }

    public void updatePrice(List<Integer> ids, String price){
        if(ids == null || ids.size() == 0){
            throw new KidbridgeSimpleException("未知的绘本信息 ~");
        }
        if(StringUtils.isBlank(price)){
            throw new KidbridgeSimpleException("未知的价格信息 ~");
        }
        try{
            Integer.parseInt(price);
        }catch (Exception e){
            throw new KidbridgeSimpleException("非法的价格信息 ~");
        }
        this.sqlSessionTemplate.update(this.namespace + "updatePrice",new HashMap(){{
            this.put("ids",ids);
            this.put("price",Integer.parseInt(price));
        }});
    }

    /**
     * 编辑绘本信息
     * @param param
     */
    @Transactional
    public void edit(Map param){
        if(param.get("icon") == null || ((List)param.get("icon")).size() == 0){
            throw new KidbridgeSimpleException("至少包含一个绘本缩略图 ~");
        }
        if(param.get("name") == null || StringUtils.isBlank(param.get("name").toString())){
            throw new KidbridgeSimpleException("未知的绘本名称 ~");
        }
        if(param.get("sort") == null || StringUtils.isBlank(param.get("sort").toString())){
            throw new KidbridgeSimpleException("未知的排序信息 ~");
        }
        if(param.get("audio") == null || StringUtils.isBlank(param.get("audio").toString())){
            throw new KidbridgeSimpleException("未知的音频信息 ~");
        }
        try {
            Integer.valueOf(param.get("sort").toString());
        }catch (Exception e){
            throw new KidbridgeSimpleException("非法的排序信息 ~");
        }
        if(param.get("tag") == null || ((List)param.get("tag")).size() == 0){
            //throw new KidbridgeSimpleException("至少包含一个绘本标签 ~");
            param.put("tag",new ArrayList());
        }
        if(param.get("price") == null || StringUtils.isBlank(param.get("price").toString())){
            throw new KidbridgeSimpleException("未知的价格信息 ~");
        }
        try{
            Integer.parseInt(param.get("price").toString());
        }catch (Exception e){
            throw new KidbridgeSimpleException("非法的价格信息 ~");
        }
        if(param.get("active") == null || StringUtils.isBlank(param.get("active").toString())){
            throw new KidbridgeSimpleException("未知的限制跟读时间 ~");
        }
        this.sqlSessionTemplate.update(this.namespace + "edit",param);
        this.bookSegmentService.edit(Integer.valueOf(param.get("id").toString()),(List) param.get("segment"));
        if(!(param.get("copyright") == null || ((Map)param.get("copyright")).get("user") == null || ((Map)((Map)param.get("copyright")).get("user")).get("id") == null || StringUtils.isBlank(((Map)((Map)param.get("copyright")).get("user")).get("id").toString()))){
            // 如果有修改绘本版权所属用户
            Integer userid = Integer.valueOf(((Map)((Map)param.get("copyright")).get("user")).get("id").toString());
            if(userid.intValue() != -1){
                BookCopyright bookCopyright = this.bookCopyrightService.get(Integer.valueOf(param.get("id").toString()));
                if(bookCopyright == null){
                    // 之前这个绘本不存在版权所属用户，直接新增
                    this.bookCopyrightService.add(Integer.valueOf(param.get("id").toString()),Integer.valueOf(((Map)((Map)param.get("copyright")).get("user")).get("id").toString()));
                }else{
                    // 否则在原有数据修改用户
                    this.bookCopyrightService.edit(bookCopyright.getId(),Integer.valueOf(((Map)((Map)param.get("copyright")).get("user")).get("id").toString()));

                }
            }
        }
    }

    /**
     * 删除绘本
     * @param bookId
     */
    @Transactional
    public void del(Integer bookId){
        if(bookId == null){
            throw new KidbridgeSimpleException("未知的绘本信息 ~");
        }
        if(this.existBookInCourse(bookId)){
            // 如果该绘本已被课程使用，则无法删除
            throw new KidbridgeSimpleException("该绘本已被某些课程引用，请先删除相关课程");
        }
        this.sqlSessionTemplate.update(this.namespace + "del",bookId);
    }
}
