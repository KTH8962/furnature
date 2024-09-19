package com.example.furnature.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.mapper.ManageMapper;
import com.example.furnature.model.Manage;


@Service
public class ManageServiceImpl implements ManageService{
	
	@Autowired
	ManageMapper manageMapper;
	
	//상품등록
	@Override
	public HashMap<String, Object> enrollProduct(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			System.out.println("################################"+map);
			manageMapper.enrollProduct(map);
			resultMap.put("productNo",map.get("productNo"));
			resultMap.put("result", "scuccess");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		}catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
}
