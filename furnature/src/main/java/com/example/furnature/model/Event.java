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
	private String auctionImgName;
	private String auctionImgOrgName;
	private String auctionImgPath;
	private String auctionImgSize;
	
	public int getAuctionNo() {
		return auctionNo;
	}
}
