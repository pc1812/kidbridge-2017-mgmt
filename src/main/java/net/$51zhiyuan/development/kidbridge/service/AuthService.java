package net.$51zhiyuan.development.kidbridge.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 授权登录
 */
@Service
public class AuthService {

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.auth.";

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    /**
     * 根据用户ID删除对应的授权信息
     * @param userId
     */
    public void delete(Integer userId){
        List<Integer> ids = this.sqlSessionTemplate.selectList(this.namespace + "ids",userId);
        if(ids.size() > 0){
            this.sqlSessionTemplate.update(this.namespace + "delete",ids);
        }
    }
}
