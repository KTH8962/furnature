package com.example.furnature.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ManageMapper {
	void enrollProduct(HashMap<String,Object> map);
}
