package com.example.furnature.controller;


import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.furnature.dao.ProductService;
import com.google.gson.Gson;

@Controller
public class ProductController {
	@Autowired
	ProductService productService;
	
	@RequestMapping("/productDetail/samplesejin.do")
	public String boardLista(Model model) throws Exception{
		return "/productDetail/samplesejin";
	}
	// 상품 이미지 url 모두 출력
		@RequestMapping(value = "/productDetail/samplesejin.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		//@RequestParam
		public String searchImgUrl(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			resultMap = productService.searchImgUrl(map);
			return new Gson().toJson(resultMap);
		}
	
}
