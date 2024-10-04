package com.example.furnature.dao;

import java.util.HashMap;

public interface MainService {
	// 상품 리스트 불러오기
	HashMap<String, Object> searchProductList(HashMap<String, Object> map);
	
	// 상품 리스트 불러오기
	HashMap<String, Object> searchOnedayList(HashMap<String, Object> map);
}
