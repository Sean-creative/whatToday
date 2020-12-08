package com.hobby.service;

import java.util.List;

import com.hobby.domain.ReplyVO;

public interface ReplyService {
	
	//댓글 등록
	public int register(ReplyVO vo);
	
	//댓글 조회
	public ReplyVO get(Long rno);
	
	//댓글 삭제
	public int remove(Long rno);
	
	//댓글 수정
	public int modify(ReplyVO vo);
	
	//댓글 목록
	public List<ReplyVO> getList(Long cbBno);
	
}
