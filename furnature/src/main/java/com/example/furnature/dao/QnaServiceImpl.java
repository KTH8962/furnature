package com.example.furnature.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.furnature.mapper.QnaMapper;
import com.example.furnature.model.Qna;

@Service
public class QnaServiceImpl implements QnaService {

	@Autowired
	QnaMapper qnaMapper;

	//qna리스트
	@Override
	public HashMap<String, Object> QnaList(HashMap<String, Object> map) {
		 HashMap<String, Object> resultMap = new HashMap<>(); 
		 try {
			 System.out.println("qweqweqweqweqweqwe" + map);
			 List<Qna> list = qnaMapper.QnaList(map);
			 int count = qnaMapper.listCount(map);
			 resultMap.put("list", list);
			 resultMap.put("count", count);
			 resultMap.put("message", "success");
		} catch (Exception e) {
			resultMap.put("message", "fail");
		}
		 
		return resultMap;
	}
	
	//qna 상세
	@Override
	public HashMap<String, Object> QnaView(HashMap<String, Object> map) {
		 HashMap<String, Object> resultMap = new HashMap<>(); 
		 try {
			 Qna list = qnaMapper.QnaView(map);
			 List<Qna> commnets = qnaMapper.commentView(map);
			 resultMap.put("list", list);
			 resultMap.put("comments", commnets);
			 resultMap.put("message", "success");
		} catch (Exception e) {
			resultMap.put("message", "fail");
		}
		return resultMap;
	}

	@Override
	public HashMap<String, Object> commentRegist(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>(); 
		 try {
			 System.out.println("##################comment@"+map);
			 qnaMapper.commentRegist(map);
			 resultMap.put("message", "success");
		} catch (Exception e) {
			resultMap.put("message", "fail");
		}
		return resultMap;
	}
	
	//등록
	@Override
	public HashMap<String, Object> qnaRegist(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			qnaMapper.qnaRegist(map);
			resultMap.put("qnaNo",map.get("qnaNo"));
			resultMap.put("message", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("message", "fail");
		}
		
		return resultMap;
	}

	@Override
	public HashMap<String, Object> commentDelete(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			qnaMapper.commentDelete(map);
			resultMap.put("message", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("message", "fail");
		}
		
		return resultMap;
	}

	@Override
	public HashMap<String, Object> commentUpdate(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			qnaMapper.commentUpdate(map);
			resultMap.put("message", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("message", "fail");
		}
		
		return resultMap;
	}

	@Override
	public HashMap<String, Object> qnaUpdate(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			System.out.println("@@@이거거거거거거거거map@@@"+map);
			qnaMapper.qnaUpdate(map);
			resultMap.put("message", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("message", "fail");
		}
		
		return resultMap;
	}
	 
}
