package com.zh.mapper;

import com.zh.pojo.Course;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CourseMapper {

    List<Course> findAll();

}
