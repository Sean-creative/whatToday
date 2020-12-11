package com.hobby.mapper;

import java.util.List;

import com.hobby.domain.NoticeCri;
import com.hobby.domain.NoticeVO;

public interface NoticeMapper {
	
//=======공지사항 등록  =======//	
	//공지사항
	public void insertNotice(NoticeVO notice);
	//공지사항 내용 등록
	public void insertNotiCon(NoticeVO notice);
//=======공지사항 읽기 =======//
	//공지사항 제목들 
	public List<NoticeVO> noticeList();
	//공지사항 내용들 
	public List<NoticeVO> noticeContent(Long ntNum);
		
	// 공지사항 페이징처리
	public List<NoticeVO> noticeListWithPaging(NoticeCri cri);
//=======공지사항 삭제 ==========//
	//공지사항
	public int deleteNotice(Long ntNum);
	//공지사항 내용 삭제
	public int deleteNotiCon(Long ntNum);
//=======공지사항 수정 ==========//	
	// 공지사항 수정 
	public int updateNotice(NoticeVO notice);
	//공지사항 내용 수정 
	public int updateNotiCon(NoticeVO notice);
	
	//read 
	public NoticeVO getNotice(Long ntNum);
}