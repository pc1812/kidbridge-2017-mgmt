package net.$51zhiyuan.development.kidbridge.module.shiro;

import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;

public class KidbridgeSecurityManager extends DefaultWebSecurityManager {

    @Override
    protected void stopSession(Subject subject) {
        Session session = subject.getSession();
        super.stopSession(subject);
        KidbridgeSessionManager sessionManager = (KidbridgeSessionManager) super.getSessionManager();
        sessionManager.delete(session);
    }
}
