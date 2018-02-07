package net.$51zhiyuan.development.kidbridge.service;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import org.apache.commons.lang3.StringUtils;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 绘本段落
 */
@Service
public class BookSegmentService {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.bookSegment.";

    /**
     * 绘本段落新增
     * @param bookId
     * @param segmentList
     */
    @Transactional
    public void add(Integer bookId,List segmentList){
        if(bookId == null){
            throw new KidbridgeSimpleException("未知的绘本编号 ~");
        }
        if(segmentList == null || segmentList.size() == 0){
            throw new KidbridgeSimpleException("至少包含一个绘本段落章节 ~");
        }
        // 提交的段落参数校验处理
        for(int i = 0;i<segmentList.size();i++){
            Map segment = (Map) segmentList.get(i);
            if(segment.get("icon") == null || StringUtils.isBlank(segment.get("icon").toString())){
                throw new KidbridgeSimpleException("某个段落章节中缺失缩略图: " + segment.get("text"));
            }
            if(segment.get("audio") == null || StringUtils.isBlank(segment.get("audio").toString())){
                throw new KidbridgeSimpleException("某个段落章节中缺失音频: " + segment.get("text"));
            }
        }
        Map param = new HashMap();
        param.put("bookId",bookId);
        param.put("segmentList",segmentList);
        this.sqlSessionTemplate.insert(this.namespace + "add",param);
    }

    /**
     * 绘本段落编辑
     * @param bookId
     * @param segmentList
     */
    @Transactional
    public void edit(Integer bookId,List segmentList){
        // 旧的段落信息不进行直接删除，保留
        this.sqlSessionTemplate.update(this.namespace + "del",bookId);
        // 新增段落数据
        this.add(bookId, segmentList);
    }

}
