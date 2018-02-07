package net.$51zhiyuan.development.kidbridge.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.ui.model.Article;
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
 * 文章
 */
@Service
public class ArticleService {

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.article.";

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    /**
     * 单个文章详情
     * @param articleId
     * @return
     */
    public Article get(Integer articleId){
        return (Article) this.sqlSessionTemplate.selectOne(this.namespace + "get", new Article(){
            @Override
            public Integer getId() {
                return articleId;
            }
        });
    }

    /**
     * 获取文章列表
     * @param param
     * @return
     */
    public Map list(Map param){
        int show = 20;
        int currPage = (param.get("page") == null || StringUtils.isBlank(param.get("page").toString())) ? 1 : Integer.parseInt(param.get("page").toString());
        int maxLabel = 9;
        int z = (maxLabel / 2 + 1);
        Page page = PageHelper.startPage(currPage,show);
        List dataList = this.sqlSessionTemplate.selectList(this.namespace + "list");
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
            this.put("page",new HashMap(){{ // 分页参数
                this.put("numberList",pageNumberList);
                this.put("min",1);
                this.put("max",totalPage);
                this.put("current",currPage);
            }});
            this.put("dataList",dataList); // 文章列表信息
        }};
    }

    @Transactional
    public void del(Integer articleId){
        if(articleId == null){
            throw new KidbridgeSimpleException("未知的文章信息 ~");
        }
        this.sqlSessionTemplate.update(this.namespace + "del",articleId);
    }

    @Transactional
    public void add(Map param){
        if(param == null){
            throw new KidbridgeSimpleException("未知的文章信息 ~");
        }
        if(param.get("title") == null || StringUtils.isBlank(param.get("title").toString())){
            throw new KidbridgeSimpleException("未知的文章标题 ~");
        }
        if(param.get("content") == null || StringUtils.isBlank(param.get("content").toString())){
            throw new KidbridgeSimpleException("未知的文章正文 ~");
        }
        this.sqlSessionTemplate.insert(this.namespace + "add", param);
    }

    @Transactional
    public void edit(Map param){
        if(param == null){
            throw new KidbridgeSimpleException("未知的文章信息 ~");
        }
        if(param.get("title") == null || StringUtils.isBlank(param.get("title").toString())){
            throw new KidbridgeSimpleException("未知的文章标题 ~");
        }
        if(param.get("content") == null || StringUtils.isBlank(param.get("content").toString())){
            throw new KidbridgeSimpleException("未知的文章正文 ~");
        }
        this.sqlSessionTemplate.update(this.namespace + "edit",param);
    }
}
