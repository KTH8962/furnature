package com.example.furnature.dao;

import java.util.HashMap;

public interface BoardService {
	// 게시글 조회
		HashMap<String, Object> searchBoardList(HashMap<String, Object> map);
}
