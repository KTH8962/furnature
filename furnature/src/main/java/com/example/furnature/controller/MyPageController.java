package com.example.furnature.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.furnature.dao.MyPageService;
import com.google.gson.Gson;


@Controller
public class MyPageController {
    @Autowired
    MyPageService myPageService;

 

    @RequestMapping("/myPage/myPage.do")
    public String boardList(Model model) throws Exception{
        return "/myPage/myPage";
    }

    @RequestMapping("/myPage/oneday.do")
    public String onedayInfo(Model model) throws Exception{
        return "/myPage/myPage-oneday";
    }

    @RequestMapping(value = "/myPage/myPage.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String searchBoard(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = new HashMap<String, Object>();
        resultMap = myPageService.searchUser(map);
        return new Gson().toJson(resultMap);
    }

    @RequestMapping(value = "/myPage/oneday-info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String onedayInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = new HashMap<String, Object>();
        resultMap = myPageService.onedayInfo(map);
        return new Gson().toJson(resultMap);
    }



}






