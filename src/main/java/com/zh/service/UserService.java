package com.zh.service;

import com.zh.pojo.Userbase;

import java.util.Map;

public interface UserService {

    Userbase login(String userNo, String password);

    Userbase gitUser(Map<String,String> map,String source);

    Userbase qqUser(Map<String,String> map,String source);
}
