package net.$51zhiyuan.development.kidbridge.service;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

/**
 * 书单详情
 */
@Service
public class BookshelfDetailService {

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.bookshelfDetail.";

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    /**
     * 某个书单下的绘本新增
     * @param bookshelfId
     * @param bookList
     */
    @Transactional
    public void add(Integer bookshelfId, List bookList){
        if(bookshelfId == null){
            throw new KidbridgeSimpleException("未知的书单信息 ~");
        }
        if(bookList == null || bookList.size() == 0){
            throw new KidbridgeSimpleException("未知的绘本信息 ~");
        }
        this.sqlSessionTemplate.insert(this.namespace + "add",new HashMap(){{
            this.put("bookshelfId",bookshelfId);
            this.put("bookList",bookList);
        }});
    }

    /**
     * 编辑书单下的绘本信息
     * @param bookshelfId
     * @param bookList
     */
    @Transactional
    public void edit(Integer bookshelfId, List bookList){
        this.sqlSessionTemplate.update(this.namespace + "del",bookshelfId);
        this.add(bookshelfId, bookList);
    }
}
