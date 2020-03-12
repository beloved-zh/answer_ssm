package com.zh.pojo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Question {
    private int questionId;
    private String questionText;
    private String answer_a;
    private String answer_b;
    private String answer_c;
    private String answer_d;
    private String answer;
    private Course course;

}
