package com.example.furnature.dao;

import java.util.HashMap;

public interface EventService {
	// 경매 리스트 불러오기
	HashMap<String, Object> searchAuctionList();
	// 경매 등록
	HashMap<String, Object> addAuction(HashMap<String, Object> map);
	// 경매 썸네일 등록
	HashMap<String, Object> addAuctionImg(HashMap<String, Object> map);
	// 경매 상세 이미지 경로 등록
	HashMap<String, Object> editAuctionPath(HashMap<String, Object> map);
	// 조회
	HashMap<String, Object> searchSampleList(HashMap<String, Object> map);
}
