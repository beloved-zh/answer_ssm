package com.zh.controller;

import com.zh.pojo.Question;
import com.zh.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.sound.midi.Soundbank;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/question")
public class QuestionController {

    @Autowired
    private QuestionService service;

    @RequestMapping("findByQids")
    @ResponseBody
    public List<Question> findByQids(int[] qids){

        System.out.println("qids"+Arrays.toString(qids));

        List<Question> list = service.findByQids(qids);

        return list;
    }

    @RequestMapping("/randomQuestion")
    @ResponseBody
    public List<Question> RandomQuestion(int[] courses, int number){
        System.out.println("======================================================");
        System.out.println("cour"+ Arrays.toString(courses) +"num"+number);
        List<Question> questions = service.RandomQuestion(courses, number);

        System.out.println("======================================================");

        System.out.println(questions);

        return questions;
    }

}
