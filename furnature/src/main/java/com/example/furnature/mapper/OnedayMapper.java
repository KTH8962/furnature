package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Oneday;

@Mapper
public interface OnedayMapper {
	
	List<Oneday> onedayList(HashMap<String,Object> map);
	
	void onedayPay(HashMap<String,Object> map);
	
	Oneday onedayDetail(HashMap<String,Object> map);
	
	void onedayFile(HashMap<String,Object> map);

}
