package com.example.furnature.dao;

import java.util.HashMap;

public interface UserService {
	// 게시글 조회
		HashMap<String, Object> searchUser(HashMap<String, Object> map);
}
