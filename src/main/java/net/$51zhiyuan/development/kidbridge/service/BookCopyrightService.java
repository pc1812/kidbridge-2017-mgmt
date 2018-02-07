package net.$51zhiyuan.development.kidbridge.service;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.ui.model.BookCopyright;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;

/**
 * 绘本版权
 */
@Service
public class BookCopyrightService {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.bookCopyright.";

    /**
     * 新增绘本的版权用户
     * @param bookId
     * @param userId
     */
    @Transactional
    public void add(Integer bookId,Integer userId){
        if(bookId == null){
            throw new KidbridgeSimpleException("未知的绘本信息 ~");
        }
        if(userId == null){
            throw new KidbridgeSimpleException("未知的用户信息 ~");
        }
        this.sqlSessionTemplate.insert(this.namespace + "add",new HashMap(){{
            this.put("bookId",bookId);
            this.put("userId",userId);
        }});
    }

    /**
     * 获取绘本的版权用户信息
     * @param bookId
     * @return
     */
    public BookCopyright get(Integer bookId){
        return this.sqlSessionTemplate.selectOne(this.namespace + "get",new HashMap(){{
            this.put("bookId",bookId);
        }});
    }

    /**
     * 修改绘本的版权用户
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
