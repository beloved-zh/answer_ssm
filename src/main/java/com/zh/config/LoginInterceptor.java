package com.zh.config;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor implements HandlerInterceptor {


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        //获取session
        HttpSession session = request.getSession();

        //获取用户信息
        Object user = session.getAttribute("user");

        //判断有用户信息放行
        if (user != null){
            return true;
        }

        //提示信息
        session.setAttribute("msg","还没有登录哦");
        //其余拦截，跳转首页
        request.getRequestDispatcher("/index.jsp").forward(request,response);
        return false;
    }
}
