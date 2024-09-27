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
 
    // 마이페이지
    @RequestMapping("/myPage/myPage.do")
    public String myPage(Model model) throws Exception{
        return "/myPage/myPage";
    }

    //원데이클래스 신청내역 조회 페이지
    @RequestMapping("/myPage/oneday.do")
    public String onedayInfo(Model model) throws Exception{
        return "/myPage/myPage-oneday";
    }
    
    // 경매 입찰 리스트 조회 페이지
    @RequestMapping("/myPage/bidding.do")
    public String bidding(Model model) throws Exception{
        return "/myPage/myPage-bidding";
    }
    
    // 배송 조회 페이지
    @RequestMapping("/myPage/delivery.do")
    public String delivery(Model model) throws Exception{
    	return "/myPage/myPage-delivery";
    }
    
    // 마일리지 리스트 조회 페이지
    @RequestMapping("/myPage/mileage.do")
    public String mileage(Model model) throws Exception{
    	return "/myPage/myPage-mileage";
    }

    // 마일리지 리스트 조회 페이지
    @RequestMapping("/myPage/cart.do")
    public String cart(Model model) throws Exception{
    	return "/myPage/myPage-cart";
    }
    
    // 마이페이지 리스트 db
    @RequestMapping(value = "/myPage/myPage.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String searchUser(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap = myPageService.searchUser(map);
    	return new Gson().toJson(resultMap);
    }
    
    // 마이페이지 정보 수정 db
    @RequestMapping(value = "/myPage/myPage-edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String editUser(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	System.out.println(map);
    	resultMap = myPageService.editUser(map);
    	return new Gson().toJson(resultMap);
    }

    // 경매 입찰 리스트 조회 db
    @RequestMapping(value = "/myPage/bidding-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String searchBidding(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap = myPageService.searchBiddingList(map);
    	return new Gson().toJson(resultMap);
    }
    
    // 경매 입찰 취소 db
    @RequestMapping(value = "/myPage/bidding-cancel.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String cancelBidding(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap = myPageService.cancelBidding(map);
    	return new Gson().toJson(resultMap);
    }
    
    // 배송 조회
    @RequestMapping(value = "/myPage/mypage-delivery.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String mypageDelivery(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap = myPageService.selectDelivery(map);
    	return new Gson().toJson(resultMap);
    }
    
    // 원데이클래스 수강신청 내역 조회(회원)
    @RequestMapping(value = "/myPage/oneday-info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String onedayInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = new HashMap<String, Object>();
        resultMap = myPageService.onedayInfo(map);
        return new Gson().toJson(resultMap);
    }


}






