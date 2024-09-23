package com.example.furnature.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.mapper.OnedayMapper;
import com.example.furnature.model.Oneday;

import jakarta.persistence.PersistenceException;

@Service
public class OnedayServiceImpl implements OnedayService{
	
	@Autowired
	OnedayMapper onedayMapper;

	//원데이클래스 목록 출력
	@Override
	public HashMap<String, Object> onedayList(HashMap<String, Object> map) {
		HashMap<String,Object> resultMap = new HashMap<>();
		try {
			List<Oneday> onedayList = onedayMapper.onedayList(map);
			resultMap.put("onedayList", onedayList);
			resultMap.put("result", "success");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		}
		catch (DataAccessException e) {
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
	
	//원데이클래스 결제
	@Override
	public HashMap<String, Object> onedayPay(HashMap<String, Object> map) {
		HashMap<String,Object> resultMap = new HashMap<>();
		try{
			onedayMapper.onedayPay(map);
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
	
	//원데이클래스 개별 상세 정보
	@Override
	public HashMap<String, Object> onedayDetail(HashMap<String, Object> map) {
		HashMap<String,Object> resultMap = new HashMap<>();
		try {
			Oneday onedayDetail = onedayMapper.onedayDetail(map);
			resultMap.put("onedayDetail", onedayDetail);
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

	//원데이클래스 등록(관리자)
	@Override
	public HashMap<String, Object> onedayReg(HashMap<String, Object> map) {
		HashMap<String,Object> resultMap = new HashMap<>();
		try {
			onedayMapper.onedayReg(map);
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

	//원데이클래스 등록시 클래스번호 시퀀스로 가져오기
	@Override
	public HashMap<String, Object> classNo(HashMap<String, Object> map) {
		HashMap<String,Object> resultMap = new HashMap<>();
		try {
			int classNo = onedayMapper.classNo(map);
			resultMap.put("classNo", classNo);
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

	//원데이클래스 등록시 파일 업로드
	@Override
	public HashMap<String, Object> onedayFile(HashMap<String, Object> map) {
		HashMap<String,Object> resultMap = new HashMap<>();
		try {
			onedayMapper.onedayFile(map);
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
	
	//원데이클래스 인원초과 여부 확인
	@Override
	public HashMap<String, Object> numberLimit(HashMap<String, Object> map) {
		HashMap<String,Object> resultMap = new HashMap<>();
		try {
			Integer numberLimit = onedayMapper.numberLimit(map);
			if(numberLimit == null) {
				numberLimit = 0;
			}
			resultMap.put("numberLimit", numberLimit);
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

	//원데이클래스 수정(관리자)
	@Override
	public HashMap<String, Object> onedayUpdate(HashMap<String, Object> map) {
		HashMap<String,Object> resultMap = new HashMap<>();
		try {
			onedayMapper.onedayUpdate(map);
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
