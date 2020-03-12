package com.zh.pojo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Userbase {

    private String userId;
    private String userNo;
    private String password;
    private String userName;
    private String userPostbox;
    private String headSculpture;
    private String source;
    private int grade;
}
