package com.hobby.service;

import java.util.List;

import com.hobby.domain.FaqVO;
import com.hobby.domain.InquireVO;
import com.hobby.domain.NoticeVO;

public interface FaqService {
//=======자주묻는질문=========//	
	//faq질문 
	public List<FaqVO> faqList();
	//faq대답 
	public List<FaqVO> faqContent();

//========일대일문의========//	
	//일대일문의 
	public void register2(InquireVO inquire);

	
//========공지사항==========// 
	//공지사항 제목 
	public List<NoticeVO> noticeList();
	//공지사항 내용  
	public List<NoticeVO> noticeContent(Long ntNum);
	
}
