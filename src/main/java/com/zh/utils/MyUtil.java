package com.zh.utils;

import com.zh.pojo.Question;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Queue;

@Component
public class MyUtil {

    /**
     *	转义
     *	<   &#60;
     *	<	&#62;
     */
    public List<Question> Switch(List<Question> list){

        for (Question q : list) {
            q.setQuestionText(q.getQuestionText().replaceAll("<", "&#60;"));
            q.setAnswer_a(q.getAnswer_a().replaceAll("<", "&#60;"));
            q.setAnswer_b(q.getAnswer_b().replaceAll("<", "&#60;"));
            q.setAnswer_c(q.getAnswer_c().replaceAll("<", "&#60;"));
            q.setAnswer_d(q.getAnswer_d().replaceAll("<", "&#60;"));

        }

        return list;
    }

}
