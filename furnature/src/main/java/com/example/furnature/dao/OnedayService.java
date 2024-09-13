package com.example.furnature.dao;

import java.util.HashMap;

public interface OnedayService {

	HashMap<String,Object> onedayList(HashMap<String,Object> map);
	
	HashMap<String,Object> onedayPay(HashMap<String,Object> map);
	
	HashMap<String,Object> onedayDetail(HashMap<String,Object> map);
	
	HashMap<String,Object> onedayReg(HashMap<String,Object> map);
	
	HashMap<String,Object> onedayFile(HashMap<String,Object> map);
	
}	
