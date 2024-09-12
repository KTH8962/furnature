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
}
