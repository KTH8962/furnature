package com.example.furnature.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.mapper.AdminMapper;
import com.example.furnature.model.Admin;

import jakarta.persistence.PersistenceException;

@Service
public class AdminServiceImpl implements AdminService{
	@Autowired
	AdminMapper adminMapper;

	// 유정 리스트 조회
	@Override
	public HashMap<String, Object> searchUserList(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			List<Admin> userList = adminMapper.selectUserList(map);
			Admin userAllList = adminMapper.selectAllUser(map);
			resultMap.put("userList", userList);
			resultMap.put("userAllList", userAllList);
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

	// 유저 삭제
	@Override
	public HashMap<String, Object> removeUser(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			adminMapper.deleteUser(map);
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

	// 유저 정보 수정
	@Override
	public HashMap<String, Object> editUser(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			adminMapper.updateUser(map);
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
