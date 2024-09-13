package com.example.furnature.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.MyPage;

@Mapper
public interface MyPageMapper {
	MyPage selectUser(HashMap<String, Object> map);
}
