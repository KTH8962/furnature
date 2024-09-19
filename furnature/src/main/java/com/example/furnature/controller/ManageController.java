package com.example.furnature.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.furnature.dao.ManageService;
import com.google.gson.Gson;

@Controller
public class ManageController {
	
	 @Autowired 
	 ManageService manageService;

	//상품등록
	@RequestMapping("/manage/management.do")
	public String product(Model model) throws Exception{
		return "/manage/management";
	}

	
	//상품등록
	@RequestMapping(value = "/manage/manageProduct.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String manageProduct(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = manageService.enrollProduct(map);
		return new Gson().toJson(resultMap);
	}
}
