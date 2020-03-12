package com.zh.service.impl;

import com.zh.mapper.UserMapper;
import com.zh.pojo.Userbase;
import com.zh.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper mapper;

    @Override
    public Userbase login(String userNo, String password) {
        return mapper.login(userNo,password);
    }

    @Override
    public Userbase githubUser(Map<String, String> map) {

        Userbase user = mapper.findByID(map.get("id"));

        if (user == null) {
            Userbase userbase = new Userbase(map.get("id"), map.get("login"), null, map.get("login"), map.get("email"), map.get("avatar_url"), "Github", 1);

            mapper.addGithubUser(userbase);

            user = mapper.findByID(map.get("id"));
        }
        return user;
    }
}
