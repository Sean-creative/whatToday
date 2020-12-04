package com.hobby.domain;

import lombok.Data;

@Data
public class ReplyVO {
	
	private Long rno;
	private Long cbBno;
	private Long cbNum;
	private String reply;
	private String replyer;
	private String replyDate;
	private String updateDate;

}
