package com.zh.service.impl;

import com.zh.mapper.StatisticsMapper;
import com.zh.pojo.Statistics;
import com.zh.service.StatisticsService;
import org.aspectj.apache.bcel.generic.RET;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class StatisticsServiceImpl implements StatisticsService {

    @Autowired
    private StatisticsMapper mapper;

    @Override
    public int addStatistics(Statistics statistics) {
        return mapper.addStatistics(statistics);
    }

    @Override
    public List<Statistics> findByUserId(String userId) {
        return mapper.findByUserId(userId);
    }

    @Override
    public List<Statistics> findStatisticsAll() {
        return mapper.findStatisticsAll();
    }

    @Override
    public List<Map<String,Object>> findRankingAndNumber(Map<String,String> map) {
        return mapper.findRankingAndNumber(map);
    }

    @Override
    public List<Map<String, Object>> findRankingAndScore(Map<String, String> map) {
        return mapper.findRankingAndScore(map);
    }

    @Override
    public List<Map<String, Object>> findRankingAndCorrect(Map<String, String> map) {
        return mapper.findRankingAndCorrect(map);
    }
}
