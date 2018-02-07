package net.$51zhiyuan.development.kidbridge.service;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 课程详情
 */
@Service
public class CourseDetailService {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.courseDetail.";

    /**
     * 新增课程下的绘本信息
     * @param courseId
     * @param bookList
     */
    @Transactional
    public void add(Integer courseId,List bookList){
        if(courseId == null){
            throw new KidbridgeSimpleException("未知的绘本编号 ~");
        }
        if(bookList == null || bookList.size() == 0){
            throw new KidbridgeSimpleException("至少包含一个绘本信息 ~");
        }
        Map param = new HashMap();
        param.put("courseId",courseId);
        param.put("bookList",bookList);
        this.sqlSessionTemplate.insert(this.namespace + "add",param);
    }

    /**
     * 编辑课程下的绘本信息
     * @param courseId
     * @param bookList
     */
    @Transactional
    public void edit(Integer courseId,List bookList){
        this.sqlSessionTemplate.update(this.namespace + "del",courseId);
        this.add(courseId, bookList);
    }
}
