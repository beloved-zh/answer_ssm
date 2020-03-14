package com.zh.controller;

import com.sun.mail.util.MailSSLSocketFactory;
import com.zh.utils.BingUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;
import java.util.Properties;

@Controller
public class MyController {

    @Autowired
    private BingUtil bingUtil;

    @RequestMapping("/getImage")
    @ResponseBody
    public Map getImage(){

        Map<String, String> image = bingUtil.getImage();

        return image;
    }

    @RequestMapping("/getImages")
    @ResponseBody
    public List<Map> getImages(){

        List<Map> images = bingUtil.getImages();

        return images;
    }

    @RequestMapping("/gotoPortfolio")
    public String gotoPortfolio(){

        return "portfolio";
    }

    @RequestMapping("/Feedback")
    @ResponseBody
    public String Feedback(String html) throws GeneralSecurityException, MessagingException {

        System.out.println(html);
        Properties prop = new Properties();
        prop.setProperty("mail.host","smtp.qq.com");//设置qq邮件服务器
        prop.setProperty("mail.transport.protocol","smtp");//邮件发送协议
        prop.setProperty("mail.smtp.auth","true");//需要验证用户名和密码

        //关于QQ邮箱，还要设置SSL加密，加上以下代码即可。其他邮箱不用
        MailSSLSocketFactory sf = new MailSSLSocketFactory();
        sf.setTrustAllHosts(true);
        prop.put("mail.smtp.ssl.enable","true");
        prop.put("mail.smtp.ssl.socketFactoty",sf);

        //使用JavaMail发送邮件的5个步骤

        //1.创建定义整个应用程序所需要的环境信息的Session对象

        //QQ才有，其他邮箱不需要
        Session session = Session.getDefaultInstance(prop, new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                //发件人邮件用户名，授权码
                return new PasswordAuthentication("1425279634@qq.com","*****");
            }
        });

        //开启Session的debug模式，可以查看程序发送Email的运行状态
        session.setDebug(true);

        //2.通过Session得到transport对象
        Transport ts = session.getTransport();

        //3.使用邮箱的用户名和授权码连接上邮件服务器
        ts.connect("smtp.qq.com","1425279634@qq.com","*****");

        //4.创建邮件

        //注意：需要传递session
        MimeMessage message = new MimeMessage(session);

        //指明发送邮件的人
        message.setFrom(new InternetAddress("1425279634@qq.com"));

        //指明收件人
        message.setRecipient(Message.RecipientType.TO,new InternetAddress("1425279634@qq.com"));

        //邮件的标题
        message.setSubject("测试程序注册验证码");

        //邮件文本内容
        message.setContent(html,"text/html;charset=UTF-8");

        //5.发送邮件
        ts.sendMessage(message,message.getAllRecipients());

        //6.关闭连接
        ts.close();

        return "感谢您的反馈，我们会即时做出处理";
    }

}
