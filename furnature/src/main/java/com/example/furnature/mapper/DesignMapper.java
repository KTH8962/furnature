package com.example.furnature.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DesignMapper {
	
	// 디자인등록
	void insertDesign(HashMap<String, Object> map);

	// 디자인 첨부등록
	void insertDesignFile(HashMap<String, Object> map);
}
