package com.example.furnature.dao;

import java.util.HashMap;

public interface AdminService {
	// 유저 리스트 조회
	HashMap<String, Object> searchUserList(HashMap<String, Object> map);
	// 유저 삭제
	HashMap<String, Object> removeUser(HashMap<String, Object> map);
	// 유저 정보 수정
	HashMap<String, Object> editUser(HashMap<String, Object> map);
  // 비밀번호 초기화
	HashMap<String, Object> resetPwd(HashMap<String, Object> map);
  //원데이클래스 신청인수 등 현황 조회
  HashMap<String, Object> currentNumber(HashMap<String, Object> map);
  //원데이클래스 삭제
  HashMap<String, Object> onedayDelete(HashMap<String, Object> map);
  //원데이클래스 개별조회
  HashMap<String, Object> onedayInfo(HashMap<String, Object> map);
}
