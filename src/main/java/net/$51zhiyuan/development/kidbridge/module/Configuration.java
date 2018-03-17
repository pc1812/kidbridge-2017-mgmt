package net.$51zhiyuan.development.kidbridge.module;

import net.$51zhiyuan.development.kidbridge.exception.KidbridgeSystemException;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class Configuration {

    private static final Logger LOGGER = LogManager.getLogger(Configuration.class);

    public static final String SYSTEM_SIGN_SALT = "Picture_B00k";
    public static final String SYSTEM_REQUEST_SIGN = "sign";
    public static final String SYSTEM_REQUEST_TOKEN = "token";
    public static final String SYSTEM_REQUEST_VERSION = "version";
    public static final String SYSTEM_REQUEST_TIMESTAMP = "timestamp";
    public static final String SYSTEM_SESSION_NAMESPACE = "kidbridge:session";
    public static final String SYSTEM_SESSION_MAPPING_NAMESPACE = "kidbridge:session:mapping";
    public static final String[] SYSTEM_SHIRO_LOGIN_URL = new String[]{"/user/login","/user/auth","/user/register"};

    public static final String SESSION_TIMEOUT = "kidbridge.session.timeout";
    public static final String EXCEPTION_TIP = "kidbridge.exception_tip";
    public static final String QINIU_BUCKET = "kidbridge.qiniu.bucket";
    public static final String QINIU_ACCESSKEY = "kidbridge.qiniu.accesskey";
    public static final String QINIU_SECRETKEYSPEC = "kidbridge.qiniu.secretkeyspec";
    public static final String QINIU_UPLOAD_TOKEN_QUIET_TIME = "kidbridge.qiniu.uploadTokenQuietTime";

    private static PropertiesFactoryBean PROPERTIES_FACTORY;

    public static String property(String key) {
        String value = null;
        try{
            if(PROPERTIES_FACTORY == null){
                ClassPathResource properties = new ClassPathResource("config/global.properties");
                if(!properties.exists()){
                    throw new KidbridgeSystemException("configuration [ classpath:config/global.properties ] file cannot be found");
                }
                PROPERTIES_FACTORY = new PropertiesFactoryBean();
                PROPERTIES_FACTORY.setFileEncoding("utf-8");
                PROPERTIES_FACTORY.setLocation(properties);
                PROPERTIES_FACTORY.afterPropertiesSet();
            }
            value = PROPERTIES_FACTORY.getObject().getProperty(key);
        }catch (IOException io){
            LOGGER.error(io.getMessage(),io);
        }
        if(StringUtils.isBlank(value)){
            throw new KidbridgeSystemException("configuration key [ "+key+" ] Non-existent");
        }
        return value;
    }

}
