package com.zh.mapper;

import com.zh.pojo.Question;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionMapper {

    List<Question>  RandomQuestion(@Param("courses") int[] courses,@Param("number") int number);

    List<Question> findByQids(@Param("qIds") int[] qIds);
}
