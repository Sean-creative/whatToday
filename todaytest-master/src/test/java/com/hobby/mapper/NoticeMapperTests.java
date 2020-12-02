package com.hobby.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import com.hobby.domain.NoticeCri;
import com.hobby.domain.NoticeVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class NoticeMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private FaqMapper mapper;
	
	@Test
	public void testPaging() {
		NoticeCri cri = new NoticeCri();
		
		cri.setPageNum(1);
		cri.setAmount(10);
		
		List<NoticeVO> list = mapper.noticeListWithPaging(cri);
		list.forEach(notice -> log.info(notice.getNtNum()));
	}
	
//	@Test
//	public void testListPaging() throws Exception{
//		
//		log.info(mockMvc.perform(
//				MockMvcRequestBuilders.get("/cs/notice")
//				.param("pageNum","2")
//				.param("amount", "50"))
//				.andReturn().getModelAndView().getModelMap());
//
//	}
}
