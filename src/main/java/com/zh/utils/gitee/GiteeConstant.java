package com.zh.utils.gitee;


import org.springframework.stereotype.Component;

/**
 * GitHub登录常量类
 */
@Component
public class GiteeConstant {

    // 这里填写在GitHub上注册应用时候获得 CLIENT ID
    public static final String  CLIENT_ID="*****";
    //这里填写在GitHub上注册应用时候获得 CLIENT_SECRET
    public static final String CLIENT_SECRET="*****";
    // 回调路径
    public static final String CALLBACK = "*****";

    //获取code的url
    public static final String CODE_URL = "https://gitee.com/oauth/authorize?client_id="+CLIENT_ID+"&response_type=code&redirect_uri="+CALLBACK+"";
    //获取token的url
    public static final String TOKEN_URL = "https://gitee.com/oauth/token?grant_type=authorization_code&code=CODE&client_id="+CLIENT_ID +"&redirect_uri="+CALLBACK+"&client_secret=" +CLIENT_SECRET+"";
    //获取用户信息的url
    public static final String USER_INFO_URL = "https://gitee.com/api/v5/user?access_token=Token";

}
