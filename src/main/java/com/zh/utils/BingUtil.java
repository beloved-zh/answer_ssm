package com.zh.utils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.dom4j.*;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.*;

@Component
public class BingUtil {

    /**
     * 每日一图
     * @return
     */
    public Map<String,String> getImage(){

        //必应每日一图接口
        String bing = "https://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1";

        //得到的json数据，用String保存
        String json = "";

        try {
            URL  url = new URL(bing);
            URLConnection conn = url.openConnection();
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(),"utf-8"));//转码。
            String line = null;
            while ((line = reader.readLine()) != null)
                json += (line + " ");
            reader.close();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        //将字符串转换为json
        JSONObject jsonObject = JSONObject.parseObject(json);

        //获取图片的数据
        JSONArray images = jsonObject.getJSONArray("images");

        //图片数据是一个数组，长度为1
        String s = images.get(0).toString();

        //将数据转换为json
        JSONObject jsonObject1 = JSONObject.parseObject(s);

        String url = jsonObject1.get("url").toString();
        url = "https://www.bing.com" + url;
        String copyright = jsonObject1.get("copyright").toString();

        Map<String,String> map = new HashMap<>();
        map.put("url",url);
        map.put("copyright",copyright);

        return map;
    }


    /**
     * 历史图片
     * @return
     */
    public List<Map> getImages(){
        //必应每日一图历史接口
        String bing = "https://cn.bing.com/HPImageArchive.aspx?idx=0&n=10";

        //得到的XML数据，用String保存
        String xmlStr = "";

        URL url = null;
        try {
            url = new URL(bing);
            URLConnection conn = url.openConnection();
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(),"utf-8"));//转码。
            String line = null;
            while ((line = reader.readLine()) != null)
                xmlStr += (line + " ");
            reader.close();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        //System.out.println(xmlStr);
        //保存所有的图片
        List<Map> images = new ArrayList<>();

        // 1.将字符串转为XML
        Document document = null;
        try {
            document = DocumentHelper.parseText(xmlStr);
            //2.获取根节点
            Element rootElement = document.getRootElement();
            Iterator iterator = rootElement.elementIterator();
            while (iterator.hasNext()){
                Element stu = (Element) iterator.next();
                List<Attribute> attributes = stu.attributes();
                //System.out.println("======获取属性值======");
                for (Attribute attribute : attributes) {
                    System.out.println(attribute.getValue());
                }
                //System.out.println("======遍历子节点======");
                Iterator iterator1 = stu.elementIterator();
                //保存单个图片
                Map<String,String> image = new HashMap<>();
                while (iterator1.hasNext()){

                    Element stuChild = (Element) iterator1.next();
                    String name = stuChild.getName();
                    String value = stuChild.getStringValue();
                    if (name.equals("url")){
                        image.put("url","https://www.bing.com"+value);
                    }
                    if (name.equals("copyright")){
                        image.put("copyright",value);
                    }
                    //System.out.println("节点名："+stuChild.getName()+"---节点值："+stuChild.getStringValue());

                }
                if (image.size() > 0){
                    images.add(image);
                }
            }
        } catch (DocumentException e) {
            e.printStackTrace();
        }

        return images;
    }

}
