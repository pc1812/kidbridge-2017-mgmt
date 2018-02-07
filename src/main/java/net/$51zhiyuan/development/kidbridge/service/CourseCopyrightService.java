package net.$51zhiyuan.development.kidbridge.service;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.ui.model.CourseCopyright;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;

/**
 * 课程版权
 */
@Service
public class CourseCopyrightService {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.courseCopyright.";

    /**
     * 新增课程版权所属用户
     * @param courseId
     * @param userId
     */
    @Transactional
    public void add(Integer courseId,Integer userId){
        if(courseId == null){
            throw new KidbridgeSimpleException("未知的课程信息 ~");
        }
        if(userId == null){
            throw new KidbridgeSimpleException("未知的用户信息 ~");
        }
        this.sqlSessionTemplate.insert(this.namespace + "add",new HashMap(){{
            this.put("courseId",courseId);
            this.put("userId",userId);
        }});
    }

    public CourseCopyright get(Integer courseId){
        return this.sqlSessionTemplate.selectOne(this.namespace + "get",new HashMap(){{
            this.put("courseId",courseId);
        }});
    }

    /**
     * 编辑课程版权所属用户
     * @param id
     * @param userId
     */
    @Transactional
    public void edit(Integer id,Integer userId){
        if(id == null){
            throw new KidbridgeSimpleException("未知的版权信息 ~");
        }
        if(userId == null){
            throw new KidbridgeSimpleException("未知的用户信息 ~");
        }
        this.sqlSessionTemplate.insert(this.namespace + "edit",new HashMap(){{
            this.put("id",id);
            this.put("userId",userId);
        }});
    }
}
