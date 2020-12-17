package com.hobby.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.hobby.domain.NoticeCri;
import com.hobby.domain.NoticeVO;
import com.hobby.domain.UserVO;
import com.hobby.mapper.NoticeMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class NoticeServiceImpl implements NoticeService{
   
   @Setter(onMethod_ = @Autowired) 
   private NoticeMapper mapper;
   
   @Override
   public void registerNotice(NoticeVO notice) {
      log.info("noticeregister##"+notice);
      mapper.insertNotice(notice);
      mapper.insertNotiCon(notice);
   }
   
   
   @Override
   public List<NoticeVO> noticeList(NoticeCri cri) {
      log.info("noticelist with paging ...........");
      return mapper.noticeListWithPaging(cri);
   }


   @Override
   public List<NoticeVO> noticeContent(Long ntNum) {   
      log.info("noticeContent...........");    
      return mapper.noticeContent(ntNum); 
   }
   
   @Override
   public boolean deleteNotice(Long ntNum) { 
      log.info("remove...."+ntNum);
      return mapper.deleteNotice(ntNum) ==1;
   }

   @Override 
   @Transactional 
   public int updateNotice(NoticeVO notice) { 
      int cnt = 0;
      
      cnt += mapper.updateNotice(notice);
      cnt += mapper.updateNotiCon(notice);
      
      if(cnt != 2) {
         
         TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
      }
      return cnt;
   }
   @Override
   public List<NoticeVO> noticeList() {
      // TODO Auto-generated method stub
      return mapper.noticeList();
   }
   
   @Override
   public NoticeVO getNotice(Long ntNum) {
      
      return mapper.getNotice(ntNum);
   }


@Override
public int getTotal() {
	// TODO Auto-generated method stub
	return mapper.getTotalCount();
}
}