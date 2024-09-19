package com.example.furnature.dao;

import java.util.HashMap;

public interface MyPageService {
	// 내정보 조회
	HashMap<String, Object> searchUser(HashMap<String, Object> map);
}
