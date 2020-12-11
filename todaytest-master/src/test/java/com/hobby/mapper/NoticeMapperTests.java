package com.hobby.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hobby.domain.NoticeVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
//@WebAppConfiguration
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class NoticeMapperTests {
//	@Setter(onMethod_=@Autowired)
//	private NoticeMapper mapper;
//	
//	//@Test
//	public void testRead() {
//		NoticeVO notice = mapper.getNotice(10L);
//		
//		log.info(notice);
//	}
//	
//	
//	@Test 
//	public void testDelete() {
//		log.info("deleteNotice count" + mapper.deleteNotice(69L));
//		//log.info("deleteNotiCon count" + mapper.deleteNotiCon(13L));
//	}
//	
//	@Test
//	public void testUpdate() {
//		NoticeVO notice = new NoticeVO();
//		notice.setNtNum(70L);
//		notice.setNtTitle("수정");
//		notice.setNtContent("수정내용 ");
//		notice.setNtDate("2020-10-09");
//		
//		int count = mapper.updateNotice(notice);
//		int count2 = mapper.updateNotiCon(notice);
//	}
	
//	@Setter(onMethod_ = {@Autowired}) 
//	private WebApplicationContext ctx;
//	
//	private MockMvc mockMvc;
//	
//	@Before
//	public void setup() {
//		this.mockMvc =MockMvcBuilders.webAppContextSetup(ctx).build();
//	}
	
//	@Test
//	public void testPaging() {
//		NoticeCri cri = new NoticeCri();
//		
//		cri.setPageNum(1);
//		cri.setAmount(10);
//		
//		List<NoticeVO> list = mapper.noticeListWithPaging(cri);
//		list.forEach(notice -> log.info(notice.getNtNum()));
//	}
	 
//	@Test  
//	public void testInsert() {     
//		NoticeVO notice = new NoticeVO();  
//		notice.setNtNum(13L); 
//		notice.setNtUsrClassification(0L);  
//		notice.setNtTitle("새로글");   
//		notice.setNtContent("새로작성하는 내용");  
//		notice.setNtDate("2012-10-09"); 
//		
//		mapper.insertNotice(notice);
//		mapper.insertNotiCon(notice);
//		
//		log.info(notice);
//	}
	
//	@Test
//	public void testRegister() {
//		NoticeVO notice = new NoticeVO();  
//		notice.setNtNum(13L); 
//		notice.setNtUsrClassification(0L);  
//		notice.setNtTitle("새로d글");   
//		notice.setNtContent("새로작성하d는 내용");  
//		notice.setNtDate("2012-10-09"); 
//		
//		service.registerNotice(notice);
//		
//		log.info(notice);
//	}
	
//	@Test
//	public void testRegister() throws Exception{
//		
//		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/admin/register")
//				
//				.param("ntNum", "30L")
//				//.param("ntUsrClassification", "30L")
//				.param("ntTitle", "네목 ")
//				.param("ntContent","bbbbbb!")
//				).andReturn().getModelAndView().getViewName();
//		log.info("###########"+resultPage);
//	}
}
