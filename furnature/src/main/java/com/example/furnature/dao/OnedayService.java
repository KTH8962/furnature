package com.example.furnature.dao;

import java.util.HashMap;

public interface OnedayService {
	
	//원데이클래스 목록 출력
	HashMap<String,Object> onedayList(HashMap<String,Object> map);
	
	//원데이클래스 결제
	HashMap<String,Object> onedayPay(HashMap<String,Object> map);
	
	//원데이클래스 개별 상세 정보
	HashMap<String,Object> onedayDetail(HashMap<String,Object> map);
	
	//원데이클래스 등록(관리자)
	HashMap<String,Object> onedayReg(HashMap<String,Object> map);
	
	//원데이클래스 등록시 파일 업로드
	HashMap<String,Object> onedayFile(HashMap<String,Object> map);
	
	//원데이클래스 등록시 클래스번호 시퀀스로 가져오기
	HashMap<String,Object> classNo(HashMap<String,Object> map);
	
	//원데이클래스 인원초과 여부 확인
	HashMap<String,Object> numberLimit(HashMap<String,Object> map);
	
	//원데이클래스 수정(관리자)
	HashMap<String,Object> onedayUpdate(HashMap<String,Object> map);
}	
