package net.$51zhiyuan.development.kidbridge.service;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.ui.model.Admin;
import org.apache.commons.lang3.StringUtils;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 管理员
 */
@Service
public class AdminService {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.admin.";

    /**
     * 获取管理员信息
     * @param admin
     * @return
     */
    public Admin get(Admin admin){
        return sqlSessionTemplate.selectOne(this.namespace + "get",admin);
    }

    /**
     * 管理员登录
     * @param name
     * @param password
     * @return
     */
    public Admin login(String name,String password){
        if(StringUtils.isBlank(name)){
            throw new KidbridgeSimpleException("未知的用户名称 ~");
        }
        if(StringUtils.isBlank(password)){
            throw new KidbridgeSimpleException("未知的用户密码 ~");
        }
        Admin admin = this.get(new Admin(){
            @Override
            public String getName() {
                return name;
            }
        });
        if(!admin.getPassword().equals(password)){
            throw new KidbridgeSimpleException("用户不存在或密码有误 ~");
        }
        return admin;
    }
}
