package com.zh.controller;

import com.zh.pojo.Userbase;
import com.zh.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService service;

    @RequestMapping("/login")
    public String login(String userNo,String password, HttpSession session){

        System.out.println("进入");

        Userbase userbase = service.login(userNo, password);

        if (userbase != null){

            session.setAttribute("user",userbase);

            return "redirect:/user/gotoMain";

        }else {

            session.setAttribute("msg","用户名或密码错误");

            return "redirect:/index.jsp";
        }

    }

    @RequestMapping("/gotoMain")
    public String gotoMain(HttpSession session){

        Object user = session.getAttribute("user");

        session.removeAttribute("msg");

        if (user == null){
            return "redirect:/index.jsp";
        }

        return "main";
    }


    @RequestMapping("/exit")
    public String exit(HttpSession session){

        //销毁session
        session.invalidate();

        return "redirect:/index.jsp";
    }
}
