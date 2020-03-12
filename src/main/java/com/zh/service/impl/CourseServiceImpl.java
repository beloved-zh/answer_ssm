package com.zh.service.impl;

import com.zh.mapper.CourseMapper;
import com.zh.pojo.Course;
import com.zh.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CourseServiceImpl implements CourseService {

    @Autowired
    private CourseMapper mapper;

    @Override
    public List<Course> findAll() {
        return mapper.findAll();
    }
}
