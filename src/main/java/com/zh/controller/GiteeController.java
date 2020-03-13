package com.zh.controller;

import com.zh.pojo.Userbase;
import com.zh.service.UserService;
import com.zh.utils.gitee.GiteeConstant;
import com.zh.utils.github.GitHubConstant;
import com.zh.utils.HttpClientUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("/gitee")
public class GiteeController {

    @Autowired
    private UserService service;


    //重定向到GitHub登录页面
    @RequestMapping("/gotoGiteeLogin")
    public String gotoGithubLogin(){

        return "redirect:"+GiteeConstant.CODE_URL;
    }


    @RequestMapping("/giteeCallback")
    public String githubCallback(String code, String state, Model model, HttpSession session){

        //判断返回的参数是否为空
        if(!StringUtils.isEmpty(code)){
            try {
                //拿到我们的code,去请求token
                //发送一个请求到   将code的参数赋值进去
                String token_url = GiteeConstant.TOKEN_URL.replace("CODE", code);

                //得到的responseStr是一个字符串需要将它解析放到map中
                String responseStr = HttpClientUtils.doPost(token_url);


                // 调用方法从map中获得返回的--》 令牌
                String token = HttpClientUtils.getMapByJson(responseStr).get("access_token");

                //根据token发送请求获取登录人的信息  ，通过令牌去获得用户信息
                String userinfo_url = GiteeConstant.USER_INFO_URL.replace("Token", token);

                responseStr = HttpClientUtils.doGet(userinfo_url);//json

                Map<String, String> responseMap = HttpClientUtils.getMapByJson(responseStr);

                Userbase user = service.gitUser(responseMap,"Gitee");


                session.setAttribute("user",user);

                return "redirect:/user/gotoMain";
            }catch (Exception e){

                session.setAttribute("msg","连接超时,登录失败");

            }

        }
        return "redirect:/";
    }

}
