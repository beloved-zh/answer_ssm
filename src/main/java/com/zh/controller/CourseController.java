package com.zh.controller;

import com.zh.pojo.Course;
import com.zh.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/course")
public class CourseController {

    @Autowired
    private CourseService service;

    @RequestMapping("/findAll")
    @ResponseBody
    public List<Course> findAll(){

        List<Course> list = service.findAll();

        return list;
    }

}
