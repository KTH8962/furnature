package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.MyPage;

@Mapper
public interface MyPageMapper {
	// 마이페이지 조회
	MyPage selectUser(HashMap<String, Object> map);
	
	List<MyPage> onedayInfo(HashMap<String, Object> map);
	
	// 경매 입찰 리스트 조회
	List<MyPage> selectBiddingList(HashMap<String, Object> map);	
	
	// 경매 입찰 취소
	int deleteBidding(HashMap<String, Object> map);
	
	// 경매 최고가 조회
	MyPage selectMaxPrice(HashMap<String, Object> map);
	
	// 경매 시작가 조회
	MyPage selectPrice(HashMap<String, Object> map);
	
	// 현재 입찰가 변경하기
	void updateAuctionPrice(HashMap<String, Object> map);
	
	//배송조회
	List<MyPage> selectDelivery(HashMap<String, Object> map);
}
