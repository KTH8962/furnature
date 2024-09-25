package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import javax.xml.stream.events.Comment;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Board;

@Mapper
public interface BoardMapper {
	// 게시글 조회
	List<Board> selectBoardList(HashMap<String, Object> map);
	
	// 댓글 조회
	List<Comment> selectCommentList(HashMap<String, Object> map);
	
	// 게시글 등록
	void insertBoard(HashMap<String, Object> map);

	// 게시글 삭제
	void deleteBoard(HashMap<String, Object> map);
	
	// 게시글 수정
	void updateContents(HashMap<String, Object> map);
	
	// 댓글 수정
	void updateComment(HashMap<String, Object> map);
	
	// 게시글 전체보기
	
	int selectBoardListCnt(HashMap<String, Object> map);
	
	// 게시글 상세보기
	Board selectBoardInfo(HashMap<String, Object> map);
	
	void deleteContents(HashMap<String, Object> map);
	
	// 댓글 등록
	void insertComment(HashMap<String, Object> map);

	// 댓글 삭제
	void deleteComments(HashMap<String, Object> map);
	
}
