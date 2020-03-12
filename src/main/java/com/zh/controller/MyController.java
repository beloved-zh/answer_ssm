package com.zh.controller;

import com.zh.utils.BingUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

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

}
