package com.zh.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Statistics {

    private int sid;
    private String alltopic;
    private String correctanswer;
    private String erroranswer;
    private int fraction;
    private Userbase userbase;
    private String starttime;
    private String endtime;
    private int answernumber;
    private String subject;
    private String myanswer;
    private String allanswer;

}
