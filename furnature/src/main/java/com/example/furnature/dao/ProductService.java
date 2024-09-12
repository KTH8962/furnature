package com.example.furnature.dao;

import java.util.HashMap;

public interface ProductService {
	
	//상품 리스트
	HashMap<String, Object> productList(HashMap<String, Object> map);
	//카테고리 리스트
	HashMap<String, Object> cateList(HashMap<String, Object> map);
}
