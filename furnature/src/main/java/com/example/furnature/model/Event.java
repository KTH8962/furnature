package com.example.furnature.model;

import lombok.Data;

@Data
public class Event {
	private int auctionNo;
	private String auctionTitle;
	private int auctionPrice;
	private String userId;
	private String startDay;
	private String endDay;
	private String auctionCdatetime;
	private String auctionUdatetime;
	private String auctionContents;
	private String auctionContentsImgPath;
	private String auctuonImgName;
	private String auctuonImgOrgName;
	private String auctuonImgPath;
	private String auctuonImgSize;
	
	public int getAuctionNo() {
		return auctionNo;
	}
}
