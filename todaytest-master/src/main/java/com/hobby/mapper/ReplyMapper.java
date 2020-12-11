package com.hobby.mapper;

import java.util.List;

import com.hobby.domain.ReplyVO;

public interface ReplyMapper {
	
	//댓글 등록
	public int insert(ReplyVO vo);
	
	//댓글 삭제
	public int delete(Long rno);
	
	//댓글 수정
	public int update(ReplyVO reply);
	
	//댓글 목록 
	public List<ReplyVO> getList(Long cbBno);
	
	//댓글 개수
	public int getCount(int cbBno);

}
