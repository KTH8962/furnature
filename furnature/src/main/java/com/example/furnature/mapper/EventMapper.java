package com.example.furnature.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.furnature.model.Event;

@Mapper
public interface EventMapper {
	// 경매 리스트 불러오기
	List<Event> selectAuctionList();
	
	// 경매 등록
	void insertAuction(HashMap<String, Object> map);
	
	// 썸네일 등록
	void insertAuctionImg(HashMap<String, Object> map);
	
	// 경매 상세 이미지 경로 등록
	void updataAuctionPath(HashMap<String, Object> map);

}
