package net.$51zhiyuan.development.kidbridge.service;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSimpleException;
import net.$51zhiyuan.development.kidbridge.ui.model.Config;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 参数配置
 */
@Service
public class ConfigService {

    public static final String CUSTOMER_SERVICE = "customerservice";

    private final Logger logger = LogManager.getLogger(ConfigService.class);

    private final String namespace = "net.$51zhiyuan.development.kidbridge.dao.config.";

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    /**
     * 获取参数配置信息，目前仅有客服电话
     * @param key
     * @return
     */
    public String get(String key){
        Config config = this.sqlSessionTemplate.selectOne(this.namespace + "get",key);
        if(config == null){
            throw new KidbridgeSimpleException("未知的参数键");
        }
        return config.getValue();
    }

    /**
     * 参数配置信息编辑
     * @param key
     * @param value
     */
    public void update(String key,String value){
        this.sqlSessionTemplate.update(this.namespace + "update",new Config().setKey(key).setValue(value));
    }
}
