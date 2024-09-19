package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Board;

@Mapper
public interface BoardMapper {
	// 게시글 조회
	List<Board> selectBoardList(HashMap<String, Object> map);
	
	// 게시글 등록
	void insertBoard(HashMap<String, Object> map);

	// 게시글 삭제
	void deleteBoard(HashMap<String, Object> map);
	
	// 게시글 전체보기
	int selectBoardListCnt(HashMap<String, Object> map);
}
