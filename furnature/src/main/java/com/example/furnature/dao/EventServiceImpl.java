package com.example.furnature.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.mapper.EventMapper;
import com.example.furnature.model.Event;

import jakarta.persistence.PersistenceException;

@Service
public class EventServiceImpl implements EventService{
	@Autowired
	EventMapper eventMapper;

	// 경매 등록
	@Override
	public HashMap<String, Object> addAuction(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			eventMapper.insertAuction(map);
			resultMap.put("auctionNo", map.get("auctionNo"));
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
	
	// 경매 썸네일 등록
	@Override
	public HashMap<String, Object> addAuctionImg(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			System.out.println(map);
			eventMapper.insertAuctionImg(map);
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

	// 경매 상세 이미지 경로 등록
	@Override
	public HashMap<String, Object> editAuctionPath(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			eventMapper.updataAuctionPath(map);
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
	
	
	@Override
	public HashMap<String, Object> searchSampleList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			//List<Sample> event = eventMapper;
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
}
