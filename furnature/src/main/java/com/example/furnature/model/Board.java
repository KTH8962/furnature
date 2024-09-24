package com.example.furnature.model;

import lombok.Data;

@Data
public class Board {
	private String boardNo;
	private String boardTitle;
	private String boardContents;
	private String userId;
	private String userName;
	private String boardCategory;
	private String boardNotice;
	private String cdateTime;
	private String udateTime;
	
	private String userEmail;
	
	private String boardReNo;
	
	private String fCdateTime;
	private String cnt;
	private String maskedUserId;
	
	private String commentNo;
	private String commentContents;
	
}
