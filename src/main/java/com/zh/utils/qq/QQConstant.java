package com.zh.utils.qq;


import org.springframework.stereotype.Component;

/**
 * GitHub登录常量类
 */
@Component
public class QQConstant {

    // 这里填写在qq上注册应用时候获得 APP_ID
    public static final String  APP_ID="*****";
    //这里填写在qq上注册应用时候获得 APP_KEY
    public static final String APP_KEY="*****";
    // 回调路径
    public static final String CALLBACK = "*****";

    //获取code的url
    public static final String CODE_URL = "https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id="+APP_ID+"&redirect_uri="+CALLBACK+"&state=state";
    //获取token的url
    public static final String TOKEN_URL = "https://graph.qq.com/oauth2.0/token?grant_type=authorization_code&client_id="+APP_ID+"&client_secret="+APP_KEY+"&redirect_uri="+CALLBACK+"&code=CODE";
    //获取OpendID
    public static final String OPENDID_URL = "https://graph.qq.com/oauth2.0/me?access_token=TOKEN";
    //获取用户信息的url
    public static final String USER_INFO_URL = "https://graph.qq.com/user/get_user_info?access_token=TOKEN&oauth_consumer_key="+APP_ID+"&openid=OPENID";

}
