package net.$51zhiyuan.development.kidbridge.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.ui.model.Course;
import net.$51zhiyuan.development.kidbridge.ui.model.CourseCopyright;
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
 * 课程
 */
@Service
public class CourseService {

    @Autowired
    private CourseDetailService courseDetailService;

    @Autowired
    private CourseCopyrightService courseCopyrightService;

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.course.";

    /**
     * 获取课程列表信息
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
            this.put("dataList",dataList); // 课程列表信息
        }};
    }

    /**
     * 获取单个课程详情
     * @param courseId
     * @return
     */
    public Course get(Integer courseId){
        return this.sqlSessionTemplate.selectOne(this.namespace + "get",courseId);
    }

    /**
     * 删除课程
     * @param courseId
     */
    public void del(Integer courseId){
        this.sqlSessionTemplate.delete(this.namespace + "del",courseId);
    }

    /**
     * 课程新增
     * @param param
     */
    @Transactional
    public void add(Map param){
        if(param.get("icon") == null || ((List)param.get("icon")).size() == 0){
            throw new KidbridgeSimpleException("至少包含一个课程缩略图 ~");
        }
        if(param.get("name") == null || StringUtils.isBlank(param.get("name").toString())){
            throw new KidbridgeSimpleException("未知的课程名称 ~");
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
        if(param.get("teacher") == null || StringUtils.isBlank(param.get("teacher").toString())){
            throw new KidbridgeSimpleException("未知的教师信息 ~");
        }
        if(((Map)param.get("teacher")).get("id") == null || StringUtils.isBlank(((Map)param.get("teacher")).get("id").toString())){
            throw new KidbridgeSimpleException("非法的教师信息 ~");
        }
        if(param.get("limit") == null || StringUtils.isBlank(param.get("limit").toString())){
            throw new KidbridgeSimpleException("未知的可报名人数 ~");
        }
        if(param.get("startTime") == null || StringUtils.isBlank(param.get("startTime").toString())){
            throw new KidbridgeSimpleException("未知的开课时间 ~");
        }
        this.sqlSessionTemplate.insert(this.namespace + "add",param);
        this.courseDetailService.add(Integer.valueOf(param.get("id").toString()), (List) param.get("book"));
        if(!(param.get("copyright") == null || ((Map)param.get("copyright")).get("user") == null || ((Map)((Map)param.get("copyright")).get("user")).get("id") == null || StringUtils.isBlank(((Map)((Map)param.get("copyright")).get("user")).get("id").toString()))){
            this.courseCopyrightService.add(Integer.valueOf(param.get("id").toString()),Integer.valueOf(((Map)((Map)param.get("copyright")).get("user")).get("id").toString()));
        }
    }

    /**
     * 课程数量统计
     * @return
     */
    public Integer count(){
        return this.sqlSessionTemplate.selectOne(this.namespace + "count");
    }


    /**
     * 添加热门课程
     * @param courseId
     */
    public void hot(Integer courseId){
        if(courseId == null){
            throw new KidbridgeSimpleException("未知的课程信息 ~");
        }
        this.sqlSessionTemplate.insert(this.namespace + "hot",courseId);
    }

    /**
     * 取消热门课程
     * @param courseId
     */
    public void hotCancel(Integer courseId){
        if(courseId == null){
            throw new KidbridgeSimpleException("未知的课程信息 ~");
        }
        this.sqlSessionTemplate.update(this.namespace + "hotCancel",courseId);
    }

    /**
     * 课程编辑
     * @param param
     */
    public void edit(Map param){
        if(param.get("icon") == null || ((List)param.get("icon")).size() == 0){
            throw new KidbridgeSimpleException("至少包含一个课程缩略图 ~");
        }
        if(param.get("name") == null || StringUtils.isBlank(param.get("name").toString())){
            throw new KidbridgeSimpleException("未知的课程名称 ~");
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
        if(param.get("teacher") == null || StringUtils.isBlank(param.get("teacher").toString())){
            throw new KidbridgeSimpleException("未知的教师信息 ~");
        }
        if(((Map)param.get("teacher")).get("id") == null || StringUtils.isBlank(((Map)param.get("teacher")).get("id").toString())){
            throw new KidbridgeSimpleException("非法的教师信息 ~");
        }
        if(param.get("limit") == null || StringUtils.isBlank(param.get("limit").toString())){
            throw new KidbridgeSimpleException("未知的可报名人数 ~");
        }
        if(param.get("startTime") == null || StringUtils.isBlank(param.get("startTime").toString())){
            throw new KidbridgeSimpleException("未知的开课时间 ~");
        }
        this.sqlSessionTemplate.update(this.namespace + "edit",param);
        this.courseDetailService.edit(Integer.valueOf(param.get("id").toString()), (List) param.get("book"));
        if(!(param.get("copyright") == null || ((Map)param.get("copyright")).get("user") == null || ((Map)((Map)param.get("copyright")).get("user")).get("id") == null || StringUtils.isBlank(((Map)((Map)param.get("copyright")).get("user")).get("id").toString()))){
            Integer userid = Integer.valueOf(((Map)((Map)param.get("copyright")).get("user")).get("id").toString());
            if(userid.intValue() != -1){
                CourseCopyright courseCopyright = this.courseCopyrightService.get(Integer.valueOf(param.get("id").toString()));
                if(courseCopyright == null){
                    this.courseCopyrightService.add(Integer.valueOf(param.get("id").toString()),Integer.valueOf(((Map)((Map)param.get("copyright")).get("user")).get("id").toString()));
                }else{
                    this.courseCopyrightService.edit(courseCopyright.getId(),Integer.valueOf(((Map)((Map)param.get("copyright")).get("user")).get("id").toString()));

                }
            }
        }
    }
}
