package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Admin;

@Mapper
public interface AdminMapper {
	// 유저 리스트 조회
	List<Admin> selectUserList(HashMap<String, Object> map);
	// 유저 전체 리스트수 조회
	Admin selectAllUser(HashMap<String, Object> map);
	// 유저 삭제
	void deleteUserList(HashMap<String, Object> map);
	// 유저 정보 수정
	void updateUser(HashMap<String, Object> map);
}
