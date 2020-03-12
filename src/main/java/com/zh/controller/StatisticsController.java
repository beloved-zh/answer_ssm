package com.zh.controller;

import com.zh.pojo.Statistics;
import com.zh.service.StatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/statistics")
public class StatisticsController {

    @Autowired
    private StatisticsService service;

    /**
     * 添加答题记录
     * @param statistics
     * @return
     */
    @RequestMapping("/addStatistics")
    @ResponseBody
    public String addStatistics(Statistics statistics){

        System.out.println("进入addStatistics====================");

        System.out.println(statistics);

        int i = service.addStatistics(statistics);

        return null;
    }


    //RestFul 风格
    @RequestMapping("/gotoRecord/{uid}")
    public String gotoRecord(@PathVariable String uid, Model model){

        System.out.println("进入gotoRecord"+uid);

        List<Statistics> list = service.findByUserId(uid);

        model.addAttribute("userStatistics",list);

        return "record";
    }

    @RequestMapping("/findStatisticsAll")
    public String findStatisticsAll(Model model){

        List<Statistics> list = service.findStatisticsAll();

        model.addAttribute("userStatistics",list);

        return "record";
    }

    @RequestMapping("/Ranking")
    @ResponseBody
    public List<Map<String, Object>> Ranking(String type,String time){
        List<Map<String, Object>> list;

        Map<String,String> map = new HashMap<>();
        map.put("time",time);

        if (type.equals("Number")){
           list = service.findRankingAndNumber(map);

            return list;
        }else if (type.equals("Score")){
            list = service.findRankingAndScore(map);

            return list;
        }else if (type.equals("Correct")){
            list = service.findRankingAndCorrect(map);

            return list;
        }

        return null;
    }

}
