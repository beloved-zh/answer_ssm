package com.zh.utils;

import com.alibaba.fastjson.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.Map;

public class HttpClientUtils {


    /**
     * 发送post请求
     * @param url  路径
     * @return
     */
    public static String doPost(String url){
        System.out.println("进入doPost");
        //创建http请求,模拟浏览器
        //CloseableHttpClient httpClient = HttpClients.createDefault();
        /**
         * 注意：post请求
         * 直接创建http请求，会有问题。
         * 发送请求会被服务器拒绝访问。
         * 需要设置UA字段
         */
        //我们可以使用一个Builder来设置UA字段，然后再创建HttpClient对象
        HttpClientBuilder builder = HttpClients.custom();
        //对照UA字串的标准格式理解一下每部分的意思
        builder.setUserAgent("Mozilla/5.0(Windows;U;Windows NT 5.1;en-US;rv:0.9.4)");
        CloseableHttpClient httpClient = builder.build();
        //创建HttpPost
        HttpPost post=new HttpPost(url);

        CloseableHttpResponse response=null;
        try {
            //发起post请求
            response =httpClient.execute(post);

            System.out.println(response.getStatusLine().getStatusCode());
            if(response.getStatusLine().getStatusCode()==200){
                // 获取响应的内容
                HttpEntity responseEntity = response.getEntity();

                return EntityUtils.toString(responseEntity);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());

            e.printStackTrace();
        }finally {
            try {
                response.close();
                post.clone();
            } catch (Exception e) {
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
        }
        return null;
    }


    /**
     * 发送get请求，利用java代码发送请求
     * @param url
     * @return
     * @throws Exception
     */
    public static String doGet(String url){

        //CloseableHttpClient httpclient = HttpClients.createDefault();
        //我们可以使用一个Builder来设置UA字段，然后再创建HttpClient对象
        HttpClientBuilder builder = HttpClients.custom();
        //对照UA字串的标准格式理解一下每部分的意思
        builder.setUserAgent("Mozilla/5.0(Windows;U;Windows NT 5.1;en-US;rv:0.9.4)");
        CloseableHttpClient httpClient = builder.build();
        HttpGet httpGet = new HttpGet(url);
        // 发送了一个http请求
        try {
            CloseableHttpResponse response = httpClient.execute(httpGet);
            // 如果响应200成功,解析响应结果
            System.out.println(response.getStatusLine().getStatusCode());
            if(response.getStatusLine().getStatusCode()==200){
                // 获取响应的内容
                HttpEntity responseEntity = response.getEntity();

                return EntityUtils.toString(responseEntity);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 将字符串转换成map
     * @param responseEntity
     * @return
     */
    public static Map<String,String> getMap(String responseEntity) {

        Map<String, String> map = new HashMap<>();
        // 以&来解析字符串
        String[] result = responseEntity.split("\\&");

        for (String str : result) {
            // 以=来解析字符串
            String[] split = str.split("=");
            // 将字符串存入map中
            if (split.length == 1) {
                map.put(split[0], null);
            } else {
                map.put(split[0], split[1]);
            }

        }
        return map;
    }

    /**
     * 通过json获得map
     * @param responseEntity
     * @return
     */
    public static Map<String,String> getMapByJson(String responseEntity) {
        Map<String, String> map = new HashMap<>();
        // 阿里巴巴fastjson  将json转换成map
        JSONObject jsonObject = JSONObject.parseObject(responseEntity);
        for (Map.Entry<String, Object> entry : jsonObject.entrySet()) {
            String key = entry.getKey();
            // 将obj转换成string
            String value = String.valueOf(entry.getValue()) ;
            map.put(key, value);
        }
        return map;
    }
}
