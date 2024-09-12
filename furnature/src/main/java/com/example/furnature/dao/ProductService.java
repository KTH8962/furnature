package com.example.furnature.dao;

import java.util.HashMap;

public interface ProductService {
	
	// 상품 이미지 url 모든 리스트
	HashMap<String, Object> searchImgUrl(HashMap<String, Object> map);
	
	// 클릭한 상품 상세 정보
	HashMap<String, Object> searchProductDetail(HashMap<String, Object> map);
}
