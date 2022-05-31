package com.kimyongju.nextobe.board.vo;

import lombok.Data;

@Data
public class BoardVO {
	private int rn;
	private int bno;
	private String title;
	private String content;
	private String writer;
	private String regdate;
	private String update;
	
	
	
	/* VAM_BOARD
	"BNO" NUMBER, 
	"TITLE" VARCHAR2(150 BYTE) NOT NULL ENABLE, 
	"CONTENT" VARCHAR2(2000 BYTE) NOT NULL ENABLE, 
	"WRITER" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	"REGDATE" DATE DEFAULT sysdate, 
	"UPDATEDATE" DATE DEFAULT sysdate, 
	 CONSTRAINT "PK_BOARD" PRIMARY KEY ("BNO") */
}
