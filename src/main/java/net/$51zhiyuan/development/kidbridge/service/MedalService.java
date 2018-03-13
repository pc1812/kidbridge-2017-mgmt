package net.$51zhiyuan.development.kidbridge.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageRowBounds;
import net.$51zhiyuan.development.kidbridge.ui.model.Medal;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 勋章
 */
@Service
public class MedalService {

    private final Logger logger = LogManager.getLogger(MedalService.class);

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.medal.";

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    /**
     * 通过id获取勋章
     * @param id
     * @return
     */
    public Medal get(Integer id){
        return this.sqlSessionTemplate.selectOne(this.namespace + "get",id);
    }

    /**
     * 新增勋章
     * @param param
     */
    public void add(Map param){
        this.sqlSessionTemplate.insert(this.namespace + "add",param);
    }

    public void delete(Integer id){
        this.edit(new HashMap(){{
            this.put("id",id);
            this.put("delFlag",true);
        }});
    }

    /**
     * 勋章编辑
     * @param param
     */
    public void edit(Map param){
        this.sqlSessionTemplate.insert(this.namespace + "edit",param);
    }

    /**
     * 获取勋章列表
     * @return
     */
    public Map list(Map param){
        int show = 20;
        int currPage = (param.get("page") == null || StringUtils.isBlank(param.get("page").toString())) ? 1 : Integer.parseInt(param.get("page").toString());
        int maxLabel = 9;
        int z = (maxLabel / 2 + 1);
        Page page = PageHelper.startPage(currPage,show);
        List dataList = this.sqlSessionTemplate.selectList(this.namespace + "list",new Medal());
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
            this.put("dataList",dataList); // 绘本列表信息
        }};


    }

}
