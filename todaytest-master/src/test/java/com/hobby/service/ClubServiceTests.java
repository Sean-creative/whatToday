package com.hobby.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ClubServiceTests {

	@Setter(onMethod_ = {@Autowired})
	private ThunderService service;
	
//	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
			
//	@Test
	public void testGetList() {
		service.getList().forEach(club -> log.info(club));
				
	}
	
//	@Test
	public void testGet() {                    
		log.info(service.get(1L));
	}
	
//	
//	@Test
//	public void testRegister() {
//		ClubVO clubVO = ClubVO.builder(4)
//				.cl_name("축구왕99")
//				.cl_subclass("축구")
//				.build();
//					
//		
//		service.register(clubVO);
//		log.info("생성된 게시물의 번호: " + clubVO.getCl_number());
//	}
////	
	
//	
//
//	
////	@Test
//	public void testDelete() {
//		log.info("REMOVE RESULT : " + service.remove(2L));
//	}
//	
////	@Test
//	public void testUpdate() {
//		BoardVO board = service.get(1L);
//		
//		if(board == null) {
//			return;
//		}
//		
//		board.setTitle("제목 수정합니다.");
//		log.info("MODIFY RESULTL: " + service.modify(board));
//	}
	
	
	
}
