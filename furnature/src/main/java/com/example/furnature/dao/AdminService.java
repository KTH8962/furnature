package com.example.furnature.dao;

import java.util.HashMap;

public interface AdminService {
	// 유저 리스트 조회
	HashMap<String, Object> searchUserList(HashMap<String, Object> map);
	// 유저 삭제
	HashMap<String, Object> removeUser(HashMap<String, Object> map);
	// 유저 정보 수정
	HashMap<String, Object> editUser(HashMap<String, Object> map);
}
