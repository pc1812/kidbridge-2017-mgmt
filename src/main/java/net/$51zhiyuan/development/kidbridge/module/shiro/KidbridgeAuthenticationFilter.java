package net.$51zhiyuan.development.kidbridge.module.shiro;

import net.$51zhiyuan.development.kidbridge.module.Configuration;
import net.$51zhiyuan.development.kidbridge.module.Util;
import net.$51zhiyuan.development.kidbridge.module.json.KidbridgeObjectMapper;
import net.$51zhiyuan.development.kidbridge.ui.model.Message;
import net.$51zhiyuan.development.kidbridge.ui.model.MessageType;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.AccessControlFilter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;

/**
 * Created by hkhl.cn on 2017/7/21.
 */
public class KidbridgeAuthenticationFilter extends AccessControlFilter {

    private final KidbridgeObjectMapper kidbridgeObjectMapper = new KidbridgeObjectMapper();

    @Override
    protected boolean isLoginRequest(ServletRequest request, ServletResponse response) {
        String requestURI = super.getPathWithinApplication(request);
        for(String path : Configuration.SYSTEM_SHIRO_LOGIN_URL){
            if(super.pathMatcher.matches(path,requestURI)){
                return true;
            }
        }
        return false;
    }

    @Override
    protected boolean isAccessAllowed(ServletRequest servletRequest, ServletResponse servletResponse, Object mappedValue) throws IOException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        String uri = request.getRequestURI();
        String sign = request.getHeader(Configuration.SYSTEM_REQUEST_SIGN);
        String token = request.getHeader(Configuration.SYSTEM_REQUEST_TOKEN);
        String timestamp = request.getHeader(Configuration.SYSTEM_REQUEST_TIMESTAMP);
        String version = request.getHeader(Configuration.SYSTEM_REQUEST_VERSION);
        if (StringUtils.isBlank(sign) || StringUtils.isBlank(timestamp) || StringUtils.isBlank(version)) {
            return this.onAccessDeniedHandle(servletRequest,servletResponse,new Message(MessageType.ERROR, "非法的请求参数"));
        }
        String validateSign = Util.sign(new HashMap(){{
            this.put("uri",uri);
            this.put("token",token);
            this.put("timestamp",timestamp);
            this.put("version",version);
        }});
        if (!(sign.toLowerCase().equals(validateSign.toLowerCase()))) {
            return this.onAccessDeniedHandle(servletRequest,servletResponse,new Message(MessageType.ERROR, "非法的参数签名"));
        }

        if(!this.isLoginRequest(servletRequest, servletResponse) && StringUtils.isBlank(token)){
            return this.onAccessDeniedHandle(servletRequest,servletResponse,new Message(MessageType.UNTOKEN,"请求未授权"));
        }
        Subject subject = super.getSubject(servletRequest, servletResponse);

        if(!this.isLoginRequest(servletRequest, servletResponse) && !subject.isAuthenticated()){
            return this.onAccessDeniedHandle(servletRequest,servletResponse,new Message(MessageType.UNAUTH,"请求未授权"));
        }

        return true;
    }

    @Override
    protected boolean onAccessDenied(ServletRequest servletRequest, ServletResponse servletResponse) {

        return false;
    }

    private boolean onAccessDeniedHandle(ServletRequest servletRequest, ServletResponse servletResponse, Message message) throws IOException {
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        Util.printJsonMessage(response,message);
        return false;
    }

}
