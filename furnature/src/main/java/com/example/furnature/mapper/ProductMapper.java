package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Product;

@Mapper
public interface ProductMapper {
	//상품 리스트
	List<Product> productList(HashMap<String, Object> map);
	//카테고리 리스트
	List<Product> cateList(HashMap<String, Object> map);
	
}
