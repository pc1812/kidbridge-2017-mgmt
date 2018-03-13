package net.$51zhiyuan.development.kidbridge.service;

import com.github.pagehelper.PageRowBounds;
import net.$51zhiyuan.development.kidbridge.ui.model.Course;
import net.$51zhiyuan.development.kidbridge.ui.model.User;
import net.$51zhiyuan.development.kidbridge.ui.model.UserCourse;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 用户课程
 */
@Service
public class UserCourseService {

    private final Logger logger = LogManager.getLogger(UserService.class);

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.userCourse.";

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    /**
     * 判断用户是否解锁了某一课程
     * @param userId
     * @param courseId
     * @return
     */
    public Boolean exist(Integer userId,Integer courseId){
        return (((int)this.sqlSessionTemplate.selectOne(this.namespace + "exist",new UserCourse(){
            @Override
            public User getUser() {
                return new User(){
                    @Override
                    public Integer getId() {
                        return userId;
                    }
                };
            }
            @Override
            public Course getCourse() {
                return new Course(){
                    @Override
                    public Integer getId() {
                        return courseId;
                    }
                };
            }
        })) > 0);
    }

    /**
     * 用户课程解锁新增
     * @param userId
     * @param courseId
     * @return
     */
    public Integer add(Integer userId,Integer courseId){
        return this.sqlSessionTemplate.insert(this.namespace + "add",new UserCourse(){
            @Override
            public User getUser() {
                return new User(){
                    @Override
                    public Integer getId() {
                        return userId;
                    }
                };
            }

            @Override
            public Course getCourse() {
                return new Course(){
                    @Override
                    public Integer getId() {
                        return courseId;
                    }
                };
            }
        });
    }
}
