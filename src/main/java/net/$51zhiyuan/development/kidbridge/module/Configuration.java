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
    public static final String SYSTEM_QINIU_UPLOAD_CALLBACK_MAPPING = "/file/upload/callback";
    public static final String SYSTEM_WECHAT_PAYMENT_CALLBACK_MAPPING = "/payment/wechat/callback";
    public static final String SYSTEM_ALIPAY_PAYMENT_CALLBACK_MAPPING = "/payment/alipay/callback";
    public static final String SYSTEM_PAGINATION_OFFSET = "offset";
    public static final String SYSTEM_PAGINATION_LIMIT = "limit";
    public static final String SYSTEM_SESSION_NAMESPACE = "kidbridge:session";
    public static final String SYSTEM_SESSION_MAPPING_NAMESPACE = "kidbridge:session:mapping";
    public static final String SYSTEM_REPEAT_NAMESPACE = "kidbridge:repeat";
    public static final String SYSTEM_SMS_NAMESPACE = "kidbridge:sms";
    public static final String SYSTEM_AUTHC_NAMESPACE = "kidbridge:authc";
    public static final String SYSTEM_INCREMENT_TRANSACTION_NAMESPACE = "kidbridge:increment:transaction";
    public static final String SYSTEM_MESSAGE_QUEUE_NAMESPACE = "kidbridge:message.queue";
    public static final String[] SYSTEM_SHIRO_LOGIN_URL = new String[]{"/user/login","/user/auth","/user/register"};

    public static final String SESSION_TIMEOUT = "kidbridge.session.timeout";
    public static final String DOMAIN = "kidbridge.domain";
    public static final String EXCEPTION_TIP = "kidbridge.exception_tip";
    public static final String QINIU_BUCKET = "kidbridge.qiniu.bucket";
    public static final String QINIU_ACCESSKEY = "kidbridge.qiniu.accesskey";
    public static final String QINIU_SECRETKEYSPEC = "kidbridge.qiniu.secretkeyspec";
    public static final String QINIU_UPLOAD_TOKEN_QUIET_TIME = "kidbridge.qiniu.uploadTokenQuietTime";
    public static final String QINIU_BUCKET_DOMAIN = "kidbridge.qiniu.bucket.domain";
    public static final String SMS_CN_ACCOUNT_SID = "kidbridge.sms.cn.accountSid";
    public static final String SMS_CN_AUTH_TOKEN = "kidbridge.sms.cn.authToken";
    public static final String SMS_CN_APP_ID = "kidbridge.sms.cn.appId";
    public static final String SMS_CN_TEMPLET_VERIFICATION_CODE = "kidbridge.sms.cn.templet.verificationCode";
    public static final String SMS_US_ACCOUNT_SID = "kidbridge.sms.us.accountSID";
    public static final String SMS_US_AUTH_TOKEN = "kidbridge.sms.us.authToken";
    public static final String SMS_US_NUMBER = "kidbridge.sms.us.number";
    public static final String WECHAT_APP_ID = "kidbridge.wechat.appId";
    public static final String WECHAT_APP_SECRET= "kidbridge.wechat.appSecret";
    public static final String WECHAT_MCH_ID = "kidbridge.wechat.mchId";
    public static final String WECHAT_API_KEY = "kidbridge.wechat.apiKey";
    public static final String ALIPAY_APP_ID = "kidbridge.alipay.appId";
    public static final String ALIPAY_APP_PRIVATE_KEY = "kidbridge.alipay.appPrivateKey";
    public static final String ALIPAY_ALIPAY_PUBLIC_KEY = "kidbridge.alipay.alipayPublicKey";
    public static final String JIGUANG_APP_KEY = "kidbridge.jiguang.appKey";
    public static final String JIGUANG_MASTER_SECRET = "kidbridge.jiguang.masterSecret";
    public static final String BONUS_TO_BALANCE_RATIO = "kidbridge.bonus.balanceRatio";
    public static final String BONUS_INCREASE_BOOK_REPEAT = "kidbridge.bonus.increase.bookRepeat";
    public static final String BONUS_INCREASE_COURSE_REPEAT = "kidbridge.bonus.increase.courseRepeat";

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
