package net.$51zhiyuan.development.kidbridge.module.shiro;

import org.apache.shiro.authc.UsernamePasswordToken;

/**
 * Created by hkhl.cn on 2017/7/31.
 */
public class KidbridgeSimpleLogin extends UsernamePasswordToken {

    public KidbridgeSimpleLogin() {
    }

    public KidbridgeSimpleLogin(String username, String password) {
        super(username, password);
    }

    public KidbridgeSimpleLogin(String username, String password, String host) {
        super(username, password, host);
    }

}
