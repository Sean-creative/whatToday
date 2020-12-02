package com.hobby.mapper;

import java.util.List;

import com.hobby.domain.FaqVO;
import com.hobby.domain.InquireVO;
import com.hobby.domain.NoticeCri;
import com.hobby.domain.NoticeVO;

public interface FaqMapper {

	////f////a////q//////
	//faq질문들 
	public List<FaqVO> faqList();
	// faq 대답
	public List<FaqVO> faqContent();
	
	//////문//////의//////
	//문의
	public void insertSelectKey2(InquireVO inquire);
	//문의내용 
	public void insertqs(InquireVO inquire);
	
	////공지사항read ///////
	//공지사항 제목들 
	public List<NoticeVO> noticeList();
	//공지사항 내용들 
	public List<NoticeVO> noticeContent(Long ntNum);
	
	// 공지사항 페이징처리
	public List<NoticeVO> noticeListWithPaging(NoticeCri cri);

}
