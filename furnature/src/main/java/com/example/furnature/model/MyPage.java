package com.example.furnature.model;

import lombok.Data;

@Data
public class MyPage {
	// 내정보
	private String userId;
	private String userAddr;
	private String userPhone;
	private String userEmail;
	private String userName;
	private String userBirth;
	private String userAuth;
	private String eventRoul;
	private String eventCheck;
	private String mileagePrice;
	
	//원데이클래스
	private String classNo;
	private String joinDate;
	private String count;
	private String className;
	private String price;
	private String numberLimit;
	private String classDate;
	private String startDay;
	private String endDay;
	private String payDay;
	private String payId;
}
