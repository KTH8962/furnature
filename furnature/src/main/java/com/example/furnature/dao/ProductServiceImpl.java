package com.example.furnature.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.mapper.ProductMapper;
import com.example.furnature.model.Product;

@Service
public class ProductServiceImpl implements ProductService{
	@Autowired
	ProductMapper productmapper;
	
	//상품 리스트
	@Override
	public HashMap<String, Object> productList(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			List<Product> list = productmapper.productList(map);
			resultMap.put("productList", list);
			resultMap.put("result", "scuccess");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		}catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}

	//카테고리 리스트
	@Override
	public HashMap<String, Object> cateList(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			List<Product> list = productmapper.cateList(map);
			resultMap.put("list", list);
			resultMap.put("result", "scuccess");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		}catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	
	
}
