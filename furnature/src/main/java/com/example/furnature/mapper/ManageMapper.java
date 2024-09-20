package com.example.furnature.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Manage;

@Mapper
public interface ManageMapper {
	//상품등록
	void enrollProduct(HashMap<String,Object> map);
	//상품 썸네일,설명 이미지 등록
	void attachProduct(HashMap<String,Object> map);
	
	void productDelete(HashMap<String,Object> map);
	
	void productAttachDelete(HashMap<String,Object> map);
	
	void productUpdate(HashMap<String,Object> map);
	
	Manage productUpdateList(HashMap<String,Object> map);
}



