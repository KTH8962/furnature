package com.example.furnature.dao;

import java.util.HashMap;

public interface BoardService {
	// 게시글 조회
	HashMap<String, Object> searchBoardList(HashMap<String, Object> map);
		
	// 게시글 등록
	HashMap<String,Object> addBoard(HashMap<String,Object> map);
	
	// 게시글 삭제
	HashMap<String,Object> removeBoard(HashMap<String,Object> map);
}
