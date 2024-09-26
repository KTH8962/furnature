package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Admin;
import com.example.furnature.model.MyPage;

@Mapper
public interface AdminMapper {
	// 유저 리스트 조회
	List<Admin> selectUserList(HashMap<String, Object> map);
	// 유저 전체 리스트수 조회
	Admin selectAllUser(HashMap<String, Object> map);
	// 유저 삭제
	void deleteUser(HashMap<String, Object> map);
	// 유저 정보 수정
	void updateUser(HashMap<String, Object> map);
	//원데이클래스 신청인수 등 현황 조회
	List<MyPage> currentNumber(HashMap<String, Object> map);
	//원데이클래스 삭제
	void onedayDelete(HashMap<String, Object> map);
	//원데이클래스 파일삭제
	void onedayFileDelete(HashMap<String, Object> map);
	//원데이클래스 개별조회
	Admin onedayInfo(HashMap<String, Object> map);
}
