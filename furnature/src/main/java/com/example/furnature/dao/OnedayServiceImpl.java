package com.example.furnature.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.mapper.OnedayMapper;
import com.example.furnature.model.Oneday;

@Service
public class OnedayServiceImpl implements OnedayService{
	
	@Autowired
	OnedayMapper onedayMapper;

	@Override
	public HashMap<String, Object> onedayList(HashMap<String, Object> map) {
		HashMap<String,Object> resultMap = new HashMap<>();
		List<Oneday> onedayList = onedayMapper.onedayList(map);
		resultMap.put("onedayList", onedayList);
		resultMap.put("result", "success");
		return resultMap;
	}

	@Override
	public HashMap<String, Object> onedayPay(HashMap<String, Object> map) {
		HashMap<String,Object> resultMap = new HashMap<>();
		onedayMapper.onedayPay(map);
		resultMap.put("result", "success");
		System.out.println(resultMap);
		return resultMap;
	}
	
	

	@Override
	public HashMap<String, Object> onedayDetail(HashMap<String, Object> map) {
		HashMap<String,Object> resultMap = new HashMap<>();
		Oneday onedayDetail = onedayMapper.onedayDetail(map);
		System.out.println(onedayDetail);
		resultMap.put("onedayDetail", onedayDetail);
		resultMap.put("result", "success");
		return resultMap;
	}

	@Override
	public HashMap<String, Object> onedayReg(HashMap<String, Object> map) {
		HashMap<String,Object> resultMap = new HashMap<>();
		onedayMapper.onedayReg(map);
		resultMap.put("result", ResMessage.RM_SUCCESS);
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> onedayThumb(HashMap<String, Object> map) {
		HashMap<String,Object> resultMap = new HashMap<>();
		System.out.println("!!!!!"+map);
		onedayMapper.onedayThumb(map);
	
		resultMap.put("result", ResMessage.RM_SUCCESS);
		return resultMap;
	}

	@Override
	public HashMap<String, Object> classNo(HashMap<String, Object> map) {
		HashMap<String,Object> resultMap = new HashMap<>();
		int classNo = onedayMapper.classNo(map);
		resultMap.put("classNo", classNo);
		resultMap.put("result", ResMessage.RM_SUCCESS);
		return resultMap;
	}

	@Override
	public HashMap<String, Object> onedayFile(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}
	

}
