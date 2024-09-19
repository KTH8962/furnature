package com.example.furnature.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.mapper.EventMapper;

import jakarta.persistence.PersistenceException;

@Service
public class EventServiceImpl implements EventService{
	@Autowired
	EventMapper eventMapper;

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
