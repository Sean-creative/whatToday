package com.hobby.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	
	private Long rno;
	private Long cbBno;
	private Long cbNum;
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updateDate;

}
