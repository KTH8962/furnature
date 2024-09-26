package com.example.furnature.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.mapper.MyPageMapper;
import com.example.furnature.model.MyPage;

import jakarta.persistence.PersistenceException;

@Service
public class MyPageServiceImpl implements MyPageService {
    @Autowired
    MyPageMapper myPageMapper;

    // 내정보 조회
    @Override
    public HashMap<String, Object> searchUser(HashMap<String, Object> map) {
        HashMap<String, Object> resultMap = new HashMap<>();
        try {
            MyPage user = myPageMapper.selectUser(map);
            resultMap.put("info", user);
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
    
    // 내정보 수정
	@Override
	public HashMap<String, Object> editUser(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
        try {
            myPageMapper.updateUser(map);
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

    // 경매 입찰 리스트 조회
	@Override
	public HashMap<String, Object> searchBiddingList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
        try {
            List<MyPage> biddingList = myPageMapper.selectBiddingList(map);
            resultMap.put("biddingList", biddingList);
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

	// 경매 입찰 취소
	@Override
	public HashMap<String, Object> cancelBidding(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
        try {
        	int cancel = myPageMapper.deleteBidding(map);
            if(cancel > 0) {
            	MyPage maxPrice = myPageMapper.selectMaxPrice(map);
            	String biddingPrice;
            	if(maxPrice != null) {
            		biddingPrice = maxPrice.getAuctionBiddingPrice();
            	} else {
            		MyPage startPrice = myPageMapper.selectPrice(map);
            		System.out.println(startPrice);
            		biddingPrice = startPrice.getAuctionPrice();
            		System.out.println(biddingPrice);
            	}
            	map.put("biddingPrice", biddingPrice);
            	myPageMapper.updateAuctionPrice(map);
            }
            resultMap.put("result", "success");
            resultMap.put("message", "입찰취소를 " + ResMessage.RM_SUCCESS);
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
	//배송조회
	@Override
	public HashMap<String, Object> selectDelivery(HashMap<String, Object> map) {
		 HashMap<String, Object> resultMap = new HashMap<>();
	        try {
	        	List<MyPage> list = myPageMapper.selectDelivery(map);
	            resultMap.put("list", list);
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
	public HashMap<String, Object> searchMileageList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
        try {
        	List<MyPage> mileageList = myPageMapper.selectMileageList(map);
            resultMap.put("mileageList", mileageList);
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
	
	//관리자 배송조회
	@Override
	public HashMap<String, Object> adminDelivery(HashMap<String, Object> map) {
		 HashMap<String, Object> resultMap = new HashMap<>();
	        try {
	        	List<MyPage> list = myPageMapper.adminDelivery(map);
	        	int count = myPageMapper.adminDeliveryCount(map);
	        	resultMap.put("count",count);
	            resultMap.put("list", list);
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

	//원데이클래스 신청내역 조회(회원)
    @Override
    public HashMap<String, Object> onedayInfo(HashMap<String, Object> map) {
        HashMap<String, Object> resultMap = new HashMap<>();
        try {
            List<MyPage> onedayInfo = myPageMapper.onedayInfo(map);
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

