package com.zh.mapper;

import com.zh.pojo.Statistics;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface StatisticsMapper {

    int addStatistics(Statistics statistics);

    /**
     * 分页查询用户记录
     * @param userId  用户id
     */
    List<Statistics> findByUserId(String userId);


    List<Statistics> findStatisticsAll();

    /**
     * 按数量查询
     * @param map  time==today 是今日
     * @return
     */
    List<Map<String,Object>> findRankingAndNumber(Map<String,String> map);

    List<Map<String,Object>> findRankingAndScore(Map<String,String> map);

    List<Map<String,Object>> findRankingAndCorrect(Map<String,String> map);
}
