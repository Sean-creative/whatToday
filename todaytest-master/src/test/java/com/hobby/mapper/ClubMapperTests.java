package com.hobby.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hobby.domain.ClubVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ClubMapperTests {

	@Setter(onMethod_ = @Autowired)
	private ClubMapper mapper;
	
	@Test
	public void testboardInsertSelectKey() {
		
		ClubVO club = new ClubVO();
		club.setCbNum(34L);
		club.setCbBdWriter("브랜뉴");
		club.setCbBdTitle("정모 후기");
		club.setCbBdDate("20201126");
		club.setCbBdView(1L);
		
		mapper.boardInsertSelectKey(club);
		log.info(club);
		
	}
	
	@Test
	public void testboardUpdate() {
		ClubVO club = new ClubVO();
		club.setCbBno(42L);
		club.setCbBdWriter("브레드");
		club.setCbBdTitle("11월 정모 후기");
		club.setCbBdDate("20201120");
		
		int count = mapper.boardUpdate(club);
		log.info("UPDATE COUNT:" + count);
	}
	
	@Test
	public void testboardDelete() {
		
		log.info("delete count: " + mapper.boardDelete(77L));
	}
}
