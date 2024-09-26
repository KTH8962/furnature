package com.example.furnature.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.mapper.AdminMapper;
import com.example.furnature.model.Admin;
import com.example.furnature.model.MyPage;

import jakarta.persistence.PersistenceException;

@Service
public class AdminServiceImpl implements AdminService{
	@Autowired
	AdminMapper adminMapper;

	// 유저 리스트 조회
	@Override
	public HashMap<String, Object> searchUserList(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			if(map.get("id") == null) {				
				List<Admin> userList = adminMapper.selectUserList(map);
				Admin userAllList = adminMapper.selectAllUser(map);
				resultMap.put("userList", userList);
				resultMap.put("userAllList", userAllList);
			} else {
				Admin info = adminMapper.selectUser(map);
				resultMap.put("info", info);
			}
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

  // 비밀번호 초기화
	@Override
	public HashMap<String, Object> resetPwd(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			adminMapper.resetPwd(map);
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
	
    //원데이클래스 신청현황 조회(관리자)
	@Override
	public HashMap<String, Object> currentNumber(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
		try {
			List<MyPage> currentNumber = adminMapper.currentNumber(map);
			resultMap.put("currentNumber", currentNumber);
			resultMap.put("result", "success");
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
	public HashMap<String, Object> onedayDelete(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
		try {
			adminMapper.onedayFileDelete(map);
			adminMapper.onedayDelete(map);
			resultMap.put("result", "success");
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
	public HashMap<String, Object> onedayInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
		try {
			Admin onedayInfo = adminMapper.onedayInfo(map);
			resultMap.put("onedayInfo", onedayInfo);
			resultMap.put("result", "success");
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
