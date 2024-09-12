package com.example.furnature.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.furnature.dao.SampleService;
import com.google.gson.Gson;

@Controller
public class SampleController {
	@Autowired
	SampleService sampleService;
	
	@RequestMapping("/sample/sample.do")
	public String boardList(Model model) throws Exception{
		return "/sample/sample";
	}
	// 게시글 목록 db
	@RequestMapping(value = "/sample/sample.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	//@RequestParam
	public String searchBoard(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = sampleService.searchSampleList(map);
		return new Gson().toJson(resultMap);
	}
}
