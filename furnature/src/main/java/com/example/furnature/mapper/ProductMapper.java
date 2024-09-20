package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Product;

@Mapper
public interface ProductMapper {
	
	// 상품 이미지 url 모든 리스트
	List<Product> selectProductImg(HashMap<String, Object> map);
	
	// 클릭한 상품 디테일 정보
	Product selectProductDetail(HashMap<String, Object> map);

	//상품 리스트
	List<Product> productList(HashMap<String, Object> map);
	
	//상품 카운트
	int productCnt(HashMap<String,Object> map);
	
	//카테고리 리스트
	List<Product> cateList(HashMap<String, Object> map);
	
	//상품 결제
	void productOrder(HashMap<String, Object> map);
	
	//리뷰 목록
	List<Product> productReview(HashMap<String, Object> map);

}
