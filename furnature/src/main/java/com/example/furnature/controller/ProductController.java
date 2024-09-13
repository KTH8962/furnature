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

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ProductController {
	@Autowired
	ProductService productService;
	
	//전담연동
	@RequestMapping("/productDetail/samplesejin.do")
	 public String boardLista(HttpServletRequest request,Model model,@RequestParam HashMap<String, Object> map) throws Exception{
        request.setAttribute("productNo", map.get("productNo"));
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
	
	@RequestMapping(value = "/productDetail/productDetail.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	//@RequestParam
	public String searchProductDetail(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.searchProductDetail(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/product/product.do")
	public String product(Model model) throws Exception{
		return "/product/product";
	}
	
	//상품 리스트
	@RequestMapping(value = "/product/productList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String productlist(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println(map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.productList(map);
		return new Gson().toJson(resultMap);
	}
	//카테고리 리스트
	@RequestMapping(value = "/product/cateList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String catelist(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println(map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.cateList(map);
		return new Gson().toJson(resultMap);
	}
  
}
