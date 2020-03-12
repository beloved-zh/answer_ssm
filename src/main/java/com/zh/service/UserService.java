package com.zh.service;

import com.zh.pojo.Userbase;

import java.util.Map;

public interface UserService {

    Userbase login(String userNo, String password);

    Userbase githubUser(Map<String,String> map);
}
