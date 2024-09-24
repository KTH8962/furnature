package com.example.furnature.dao;

import java.util.HashMap;
import java.util.List;

import javax.xml.stream.events.Comment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.mapper.BoardMapper;
import com.example.furnature.model.Board;

import jakarta.persistence.PersistenceException;

@Service
public class BoardServiceImpl implements BoardService{
	@Autowired
	BoardMapper boardMapper;
	
	// 게시판 목록
	@Override
	public HashMap<String, Object> searchBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			List<Board> list = boardMapper.selectBoardList(map);
			int count = boardMapper.selectBoardListCnt(map);
			resultMap.put("list", list);
			resultMap.put("count", count);
			resultMap.put("result", "scuccess");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (DataAccessException e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_DB_ACCESS_ERROR);
		} catch (PersistenceException e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_MYBATIS_ERROR);
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}

	// 게시판 글쓰기
	@Override
	public HashMap<String, Object> addBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap =
				new HashMap<String, Object>();
		try {
			boardMapper.insertBoard(map); System.out.println(map);
			resultMap.put("result", "success");
			resultMap.put("message", ResMessage.RM_SUBMIT);
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	
	// 게시판 삭제
	@Override
	public HashMap<String, Object> removeBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap =
				new HashMap<String, Object>();
		try {
			boardMapper.deleteBoard(map);
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		
		return resultMap;
	}
	
	// 게시글 상세보기
	@Override
	public HashMap<String, Object> searchBoardInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap =
				new HashMap<String, Object>();
		try {
			Board board = boardMapper.selectBoardInfo(map);
			List<Comment> commentList = boardMapper.selectCommentList(map);
			resultMap.put("comment", commentList);
			resultMap.put("info", board);
			resultMap.put("result", "scuccess");
			resultMap.put("message", "검색되었습니다.");
		} catch (DataAccessException e) {
			System.out.println(map);
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_DB_ACCESS_ERROR);
		} catch (PersistenceException e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_MYBATIS_ERROR);
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	
	// 상세보기중 삭제
	@Override
	public HashMap<String, Object> deleteContents(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap =
				new HashMap<String, Object>();
		try {
			boardMapper.deleteContents(map);
			resultMap.put("message", ResMessage.RM_REMOVE);
		} catch (DataAccessException e) {
			System.out.println(map);
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_DB_ACCESS_ERROR);
		} catch (PersistenceException e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_MYBATIS_ERROR);
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	
	// 댓글 삭제
	@Override
	public HashMap<String, Object> removeComment(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap =
				new HashMap<String, Object>();
		try {
			boardMapper.deleteComments(map);
			resultMap.put("message", ResMessage.RM_REMOVE);
		} catch (DataAccessException e) {
			System.out.println(map);
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_DB_ACCESS_ERROR);
		} catch (PersistenceException e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_MYBATIS_ERROR);
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	
	// 게시글 수정
	@Override
	public HashMap<String, Object> updateContents(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap =
				new HashMap<String, Object>();
		try {
			boardMapper.updateContents(map);
			resultMap.put("message", ResMessage.RM_SUCCESS);
			System.out.println(map);
		} catch (DataAccessException e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_DB_ACCESS_ERROR);
		} catch (PersistenceException e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_MYBATIS_ERROR);
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	
	// 댓글 수정
	@Override
	public HashMap<String, Object> updateComment(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap =
				new HashMap<String, Object>();
		try {
			boardMapper.updateComment(map);
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (DataAccessException e) {
			System.out.println(map);
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_DB_ACCESS_ERROR);
		} catch (PersistenceException e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_MYBATIS_ERROR);
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	
	// 댓글 쓰기
	@Override
	public HashMap<String, Object> addComment(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap =
				new HashMap<String, Object>();
		try {
			boardMapper.insertComment(map);
			resultMap.put("result", "success");
			resultMap.put("message", ResMessage.RM_SUBMIT);
		} catch (DataAccessException e) {
			System.out.println(map);
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_DB_ACCESS_ERROR);
		} catch (PersistenceException e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_MYBATIS_ERROR);
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
}
