package com.zh.service;

import com.zh.pojo.Question;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface QuestionService {

    List<Question> RandomQuestion(int[] courses,int number);

    List<Question> findByQids(int[] qIds);
}
