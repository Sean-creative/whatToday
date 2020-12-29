package com.hobby.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	
	//댓글 번호
	private Long rno;
	//게시판 번호
	private Long cbBno;
	//모임 번호 
	private Long cbNum;
	//댓글 내용 
	private String reply;
	//댓글 작성자 
	private String replyer;
	//댓글 작성일자 
	private Date replyDate;
	//댓글 변경일자 
	private Date updateDate;
	//댓글 작성자여부 
	private String isReplyer;

}
