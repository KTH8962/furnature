package com.example.furnature.dao;

import java.util.HashMap;

public interface MyPageService {
    // 내정보 조회
    HashMap<String, Object> searchUser(HashMap<String, Object> map);
    
    // 원데이 정보 조회
    HashMap<String, Object> onedayInfo(HashMap<String, Object> map);
    // 경매 입찰 리스트 조회
    HashMap<String, Object> searchBiddingList(HashMap<String, Object> map);
    // 경매 입찰 취소
    HashMap<String, Object> cancelBidding(HashMap<String, Object> map);
}
