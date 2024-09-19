package com.example.furnature.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.example.furnature.constants.ResMessage;
import com.example.furnature.mapper.ProductMapper;
import com.example.furnature.model.Product;

import jakarta.persistence.PersistenceException;

@Service
public class ProductServiceImpl implements ProductService{
	@Autowired
	ProductMapper productmapper;
	

	// 상품 이미지 url 모든 리스트
	@Override
	public HashMap<String, Object> searchImgUrl(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			List<Product> urlList = productmapper.selectProductImg(map);
			resultMap.put("urlList", urlList);
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
	//상품 리스트
	@Override
	public HashMap<String, Object> productList(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			List<Product> list = productmapper.productList(map);
			int count = productmapper.productCnt(map);
			System.out.println("@@@@@@@@@@@@@@@@@"+count);
			resultMap.put("productList", list);
			resultMap.put("count", count);
			resultMap.put("result", "success");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}

	
	// 상품 클릭시 상품번호 받아서 번호에 맞는 상품정보 가져오기
	@Override
	public HashMap<String, Object> searchProductDetail(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			Product productDetail = productmapper.selectProductDetail(map);
			resultMap.put("productDetail", productDetail);
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

	//카테고리 리스트
	@Override
	public HashMap<String, Object> cateList(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		try {
			List<Product> list = productmapper.cateList(map);
			resultMap.put("list", list);
			resultMap.put("result", "success");
			resultMap.put("message", ResMessage.RM_SUCCESS);
		}catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", ResMessage.RM_UNKNOWN_ERROR);
		}
		return resultMap;
	}
	@Override
	public HashMap<String, Object> productOrder(HashMap<String, Object> map) {
		HashMap <String, Object> resultMap = new HashMap<>();
		System.out.println("SERVICECCSSSSSSSS"+map);
		try {
			productmapper.productOrder(map);
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
