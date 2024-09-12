package com.example.furnature.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.mapper.UserMapper;
import com.example.furnature.model.User;

import jakarta.persistence.PersistenceException;
import jakarta.servlet.http.HttpSession;

@Service
public class UserServiceImpl implements UserService{
	@Autowired
	UserMapper userMapper;
	
	@Autowired
	HttpSession session;

	// 로그인 처리
	@Override
	public HashMap<String, Object> searchUser(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			User user = userMapper.selectId(map);
			if(user == null) {
				resultMap.put("result", "fail");
				resultMap.put("message", "없는 아이디 입니다.\n아이디를 확인해 주세요.");
			} else {
				user = userMapper.selectUser(map);
				if(user == null) {
					resultMap.put("result", "fail");
					resultMap.put("message", "비밀번호를 확인해 주세요.");
				} else {
					session.setAttribute("sessionId", user.getUserId());
					session.setAttribute("sessionAuth", user.getUserAuth());
					resultMap.put("result", "success");
					resultMap.put("message", ResMessage.RM_SUCCESS);
				}
				
			}
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
	public HashMap<String, Object> searchIdCheck(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			User user = userMapper.selectId(map);
			if(user == null) {
				resultMap.put("result", "success");
				resultMap.put("message", "사용 가능한 아이디 입니다.");
			} else {
				resultMap.put("result", "fail");
				resultMap.put("message", "이미 사용중인 아이디 입니다.");				
			}
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
	public HashMap<String, Object> addId(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			int id = userMapper.insertId(map);
			if(id == 0) {
				resultMap.put("result", "fail");
				resultMap.put("message", "가입에 실패하였습니다. 다시시도해주세요.");
			} else {
				resultMap.put("result", "success");
				resultMap.put("message", "가입이 완료되었습니다.");
			}
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
	public HashMap<String, Object> logout() {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			session.invalidate();
			resultMap.put("result", "success");
			resultMap.put("message", "로그아웃 되었습니다.");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
}