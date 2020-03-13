package com.zh.controller;

import com.zh.pojo.Userbase;
import com.zh.service.UserService;
import com.zh.utils.HttpClientUtils;
import com.zh.utils.qq.QQConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("/qq")
public class QQController {

    @Autowired
    private UserService service;


    //重定向到GitHub登录页面
    @RequestMapping("/gotoQQLogin")
    public String gotoGithubLogin(){

        return "redirect:"+ QQConstant.CODE_URL;
    }


    @RequestMapping("/qqCallback")
    public String githubCallback(String code, String state, Model model, HttpSession session){

        //判断返回的参数是否为空
        if(!StringUtils.isEmpty(code)&&!StringUtils.isEmpty(state)) {
            try {
                //拿到我们的code,去请求token
                //发送一个请求到   将code的参数赋值进去
                String token_url = QQConstant.TOKEN_URL.replace("CODE", code);

                //得到的responseStr是一个字符串需要将它解析放到map中
                String responseStr = HttpClientUtils.doGet(token_url);

                // 调用方法从map中获得返回的--》 令牌
                String token = HttpClientUtils.getMap(responseStr).get("access_token");

                //根据token发送请求获取OpendID
                String opendID_url = QQConstant.OPENDID_URL.replace("TOKEN", token);

                responseStr = HttpClientUtils.doGet(opendID_url);

                String openid = HttpClientUtils.getOpenID(responseStr);

                //获取用户信息
                String user_info_url = QQConstant.USER_INFO_URL.replace("TOKEN", token);
                user_info_url = user_info_url.replace("OPENID",openid);

                responseStr = HttpClientUtils.doGet(user_info_url);

                Map<String, String> map = HttpClientUtils.getMapByJson(responseStr);
                map.put("openid",openid);

                Userbase user = service.qqUser(map,"QQ");

                session.setAttribute("user",user);

                return "redirect:/user/gotoMain";
            }catch (Exception e){
                session.setAttribute("msg","连接超时,登录失败");
            }
        }
        return "redirect:/index.jsp";
    }

}
