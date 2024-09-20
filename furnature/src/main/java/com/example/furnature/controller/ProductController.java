package com.example.furnature.controller;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.furnature.dao.ProductService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ProductController {
	@Autowired
	ProductService productService;
	
	// 상품 구매 페이지
	@RequestMapping("/productDetail/pay.do")
	public String productPay(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("productNo", map.get("productNo"));
		request.setAttribute("totalPrice", map.get("totalPrice"));
		request.setAttribute("selectedSize", map.get("selectedSize"));
		System.out.println("Con@@@@@@@@@@"+map);
		return "/productDetail/pay";
	}

	//상품 상세정보 페이지
	@RequestMapping("/productDetail/productDetail.do")
	 public String searchProductDetail(HttpServletRequest request,Model model,@RequestParam HashMap<String, Object> map) throws Exception{
        request.setAttribute("productNo", map.get("productNo"));
		return "/productDetail/productDetail";
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
	// 상품 상세 정보
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
	// 상품 구매
	@RequestMapping(value = "/productDetail/pay.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	//@RequestParam
	public String productPay(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.searchImgUrl(map);
		return new Gson().toJson(resultMap);
	}
	// 상품 결제
	@RequestMapping(value = "/productDetail/productOrder.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	//@RequestParam
	public String productOrder(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String json = map.get("orderList").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		
		map.put("list", list);
		
		System.out.println("CONTROLLLLLLLLLLLL PAY"+map);
		resultMap = productService.productOrder(map);
		return new Gson().toJson(resultMap);
	}
	//상품 리뷰 리스트
	@RequestMapping(value = "/productDetail/productReview.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	//@RequestParam
	public String productReview(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.productReview(map);
		return new Gson().toJson(resultMap);
	}
  
}
