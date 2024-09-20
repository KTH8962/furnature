package com.example.furnature.dao;

import java.util.HashMap;

public interface ManageService {
	
	//상품등록
	HashMap<String, Object> enrollProduct(HashMap<String, Object> map);	
	//상품삭제
	HashMap<String, Object> productDelete(HashMap<String, Object> map);	
	//상품수정 상세
	HashMap<String, Object> productUpdateList(HashMap<String, Object> map);	
	//상품수정
	HashMap<String, Object> productUpdate(HashMap<String, Object> map);	
}
