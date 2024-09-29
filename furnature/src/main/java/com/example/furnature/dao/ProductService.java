package com.example.furnature.dao;

import java.util.HashMap;

public interface ProductService {
	
	// 상품 이미지 url 모든 리스트
	HashMap<String, Object> searchImgUrl(HashMap<String, Object> map);	
	// 상품 클릭시 상품번호 받아서 번호에 맞는 상품정보 가져오기
	HashMap<String, Object> searchProductDetail(HashMap<String, Object> map);
	//상품 리스트
	HashMap<String, Object> productList(HashMap<String, Object> map);
	//카테고리 리스트
	HashMap<String, Object> cateList(HashMap<String, Object> map);
	
	//상품 결제
	HashMap<String, Object> productOrder(HashMap<String, Object> map);
	
	//상품 리뷰
	HashMap<String, Object> productReview(HashMap<String, Object> map);
	
	//상품 리뷰 작성
	HashMap<String, Object> insertReview(HashMap<String, Object> map);
	
	//리뷰 삭제
	HashMap<String, Object> deleteReview(HashMap<String, Object> map);
	//리뷰 수정
	HashMap<String, Object> updateReview(HashMap<String, Object> map);
	//리뷰 수정전 내용 불러오기
	HashMap<String, Object> reviewInfo(HashMap<String, Object> map);
	//장바구니 담기
	HashMap<String, Object> insertCart(HashMap<String, Object> map);
}
