package com.zh.service;

import com.zh.pojo.Statistics;

import java.util.List;
import java.util.Map;

public interface StatisticsService {

    int addStatistics(Statistics statistics);

    List<Statistics> findByUserId(String userId);

    List<Statistics> findStatisticsAll();

    List<Map<String,Object>> findRankingAndNumber(Map<String,String> map);

    List<Map<String,Object>> findRankingAndScore(Map<String,String> map);

    List<Map<String,Object>> findRankingAndCorrect(Map<String,String> map);
}
