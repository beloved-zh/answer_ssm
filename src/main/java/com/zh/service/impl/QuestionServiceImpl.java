package com.zh.service.impl;

import com.zh.mapper.QuestionMapper;
import com.zh.pojo.Question;
import com.zh.service.QuestionService;
import com.zh.utils.MyUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class QuestionServiceImpl implements QuestionService {

    @Autowired
    private QuestionMapper mapper;
    @Autowired
    private MyUtil util;

    @Override
    public List<Question> RandomQuestion(int[] courses, int number) {
        List<Question> list = mapper.RandomQuestion(courses, number);
        list = util.Switch(list);
        return list;
    }

    @Override
    public List<Question> findByQids(int[] qIds) {
        List<Question> list = mapper.findByQids(qIds);
        list = util.Switch(list);
        return list;
    }
}
