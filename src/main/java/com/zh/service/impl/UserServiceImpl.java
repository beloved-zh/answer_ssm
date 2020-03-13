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
    public Userbase gitUser(Map<String, String> map,String source) {

        Userbase user = mapper.findByID(source+map.get("id"));

        if (user == null) {
            Userbase userbase = new Userbase(source+map.get("id"), map.get("login"), null, map.get("login"), map.get("email"), map.get("avatar_url"), source, 1);

            mapper.addUser(userbase);

            user = mapper.findByID(source+map.get("id"));
        }
        return user;
    }

    @Override
    public Userbase qqUser(Map<String, String> map,String source) {

        Userbase user = mapper.findByID(map.get("openid"));

        if (user == null) {
            Userbase userbase = new Userbase(map.get("openid"), map.get("nickname"), null, map.get("nickname"), null, map.get("figureurl_qq_1"), source, 1);

            mapper.addUser(userbase);

            user = mapper.findByID(map.get("openid"));
        }
        return user;
    }
}
