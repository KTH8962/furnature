package com.example.furnature.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.mapper.DesignMapper;

@Service
public class DesignServiceImpl implements DesignService{
	
	@Autowired
	DesignMapper designMapper;
	
	//디자인등록
	@Override
	public HashMap<String, Object> insertDesign(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap =
				new HashMap<String, Object>();
		try {
			System.out.println("##################### mmmaaaaapppp "+map);
			designMapper.insertDesign(map);
			resultMap.put("designNo",map.get("designNo"));
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		
		return resultMap;
	}
}
