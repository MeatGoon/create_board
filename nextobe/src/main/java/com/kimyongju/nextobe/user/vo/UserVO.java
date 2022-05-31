package com.kimyongju.nextobe.user.vo;

import lombok.Data;

@Data
public class UserVO {
	private int uno;
	private String userid;
	private String userpwd;
	private String nickname;
	private String username;
	private String gender;
	private String userphone;
	private int userstatus;
	private String regdate;
	
	
	
	/* VAM_USER
	"UNO" NUMBER, 
	"USERID" VARCHAR2(10 BYTE) NOT NULL ENABLE, 
	"USERPWD" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"NICKNAME" VARCHAR2(24 BYTE) NOT NULL ENABLE, 
	"USERNAME" VARCHAR2(9 BYTE) NOT NULL ENABLE, 
	"GENDER" VARCHAR2(3 BYTE), 
	"USERPHONE" VARCHAR2(13 BYTE), 
	"USERSTATUS" NUMBER(2,0), 
	"REGDATE" DATE, 
	 CONSTRAINT "PK_USER" PRIMARY KEY ("UNO") */
}
