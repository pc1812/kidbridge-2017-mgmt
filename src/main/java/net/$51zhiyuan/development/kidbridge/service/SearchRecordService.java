package net.$51zhiyuan.development.kidbridge.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageRowBounds;
import net.$51zhiyuan.development.kidbridge.ui.model.Article;
import net.$51zhiyuan.development.kidbridge.ui.model.SearchRecord;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
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
public class SearchRecordService {

    private final Logger logger = LogManager.getLogger(SearchRecordService.class);

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.searchRecord.";

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    /**
     * 记录用户搜索的关键词
     * @param searchRecord
     */
    @Deprecated
    @Transactional(rollbackFor = Exception.class)
    public void add(SearchRecord searchRecord){
        this.sqlSessionTemplate.insert(this.namespace + "add",searchRecord);
    }

    public Map list(Map param){
        int show = 20;
        int currPage = (param.get("page") == null || StringUtils.isBlank(param.get("page").toString())) ? 1 : Integer.parseInt(param.get("page").toString());
        int maxLabel = 9;
        int z = (maxLabel / 2 + 1);
        Page page = PageHelper.startPage(currPage,show);
        List dataList = this.sqlSessionTemplate.selectList(this.namespace + "list");
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
            this.put("dataList",dataList); // 搜索记录列表信息
        }};
    }

}
