package com.kimyongju.nextobe.board.vo;

import lombok.Data;

@Data
public class FileVO {
	private int fno;
	private int bno;
	private String org_file_name;
	private String save_file_name;
	private int file_size;
	
	
	/* VAM_FILE
	"FNO" NUMBER, 
	"BNO" NUMBER, 
	"ORG_FILE_NAME" VARCHAR2(260 BYTE), 
	"SAVE_FILE_NAME" VARCHAR2(40 BYTE), 
	"FILE_SIZE" NUMBER(11,0), 
	 CONSTRAINT "PK_FILE_NO" PRIMARY KEY ("FNO") */
	
	// 참고 URL
	// https://to-dy.tistory.com/95?category=700248
}
