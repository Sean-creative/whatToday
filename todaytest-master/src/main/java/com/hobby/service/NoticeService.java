package com.hobby.service;

import java.util.List;

import com.hobby.domain.NoticeCri;
import com.hobby.domain.NoticeVO;

public interface NoticeService {
//=======공지사항 넣기 =======//
	public void registerNotice(NoticeVO notice);
//=======공지사항 읽기 =======//
	public List<NoticeVO> noticeList();
	
	public List<NoticeVO> noticeList(NoticeCri cri);
	//공지사항 내용  
	public List<NoticeVO> noticeContent(Long ntNum);
	
	public int getTotal();
//=======공지사항 삭제 =======//
	public boolean deleteNotice(Long ntNum);
//=======공지사항 수정 =======//	
	public int updateNotice(NoticeVO notice);
	
	public NoticeVO getNotice(Long ntNum);

//	=======검색 =========//
	
	
}