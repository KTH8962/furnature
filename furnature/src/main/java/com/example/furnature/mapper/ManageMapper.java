package com.example.furnature.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ManageMapper {
	//상품등록
	void enrollProduct(HashMap<String,Object> map);
	//상품 썸네일,설명 이미지 등록
	void attachProduct(HashMap<String,Object> map);
}



