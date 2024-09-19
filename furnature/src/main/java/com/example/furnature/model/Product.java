package com.example.furnature.model;

import lombok.Data;

@Data
public class Product {
	
	
	//상품
	private String productNo;	 	//상품넘버
	private String productName;		//상품이름
	private String productWidth;	//가로
	private String productLength;	//세로
	private String productHeight;	//높이
	private String productPrice;	//상품가격
	private String productCnt;		//상품수량
	private String productColor;	//상품색상
	private String productSize1;	//사이즈1
	private String productSize2;	//사이즈2
	private String productSize3;	//사이즈3
	private String productCate1;	//상품 카테고리1
	private String productCate2;	//상품 카테고리2
	private String productCustom;	//상품 커스텀유무
	private String productDelivery; //배달
	private String productCdateTime;//생성일
	private String productUdateTime;//수정일
	
	//카테고리
	private String cateNo; 			//카테고리넘버
	private String cateName;		//카테고리이름 
	
	//상품 이미지 테이블
	private String prodcutThumbnail; //상품 썸네일 이미지 URL
	private String productDetail1; //상품 상세이미지1 URL
	private String productDetail2; //상품 상세이미지2 URL
	private String productDetail3; //상품 상세이미지3 URL
	private String productDetail4; //상품 상세이미지4 URL
	
	//주문
	private String orderNo;
	private String orderPrice;
}
