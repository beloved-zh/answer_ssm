package com.zh.mapper;

import com.zh.pojo.Userbase;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserMapper {

    Userbase login(@Param("userNo") String userNo,@Param("password") String password);

    Userbase findByID(@Param("userId") String userId);

    int addUser(Userbase userbase);

}
