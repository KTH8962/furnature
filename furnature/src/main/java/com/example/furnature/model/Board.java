package com.example.furnature.model;

import lombok.Data;

@Data
public class Board {
	private String qnaNo;
	private String qnaTitle;
	private String qnaContents;
	private String userId;
	private String userName;
	private String qnaCategpsy;
	private String isNotice;
	private String qnaCdateTime;
	private String qnaUdateTime;
	private String qnaYn;
	private String qnaFavorite;
}
