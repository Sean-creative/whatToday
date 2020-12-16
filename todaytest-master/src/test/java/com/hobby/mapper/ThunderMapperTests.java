package com.hobby.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hobby.domain.Criteria;
import com.hobby.domain.ThunderDetailVO;
import com.hobby.domain.ThunderVO;
import com.hobby.domain.UserVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ThunderMapperTests {

	@Setter(onMethod_ = @Autowired)
	private ThunderMapper mapper;
		
		
	@Test
	public void testgetListWithPaging() {
		Criteria cri = new Criteria();
		cri.setPageNum(1);
		cri.setAmount(5);
		
		cri.setUserLatitude(37.537623499999995);
		cri.setUserLongitude(127.1580072);
//		cri.setOrderBy("cbnum desc");
//		cri.setOrderBy("cbView desc");
//		cri.setOrderBy("cbappperiod desc");
		cri.setOrderBy("distance");
		
		mapper.getListWithPaging(cri).forEach(club -> log.info(club));		
	}
			
	
//	@Test
	public void testRead() {		
		//존재하는 게시물 번호로 테스트
		long cbNum = 4;
		ThunderVO clubVO = mapper.read(cbNum);
		
		log.info("clubVO : \n\n\n" +clubVO);
				
	}
	
	@Test
	public void testInsertJoin() {
		
		
		UserVO loginUser = new UserVO();
		loginUser.setUsrNum((long)40);
		loginUser.setUsrName("김선우");
				
				
				
		ThunderVO clubVO = ThunderVO.builder()				
				.cbNum((long)163)
				.cbType("번개모임")												
				.cbName("조인 테스트")								
				.build();
		
		
					
//		mapper.insertJoin(clubVO, loginUser);
		log.info(clubVO);
		log.info(loginUser);
	}
	
	
//	@Test
	public void testInsert() {
		
		ThunderDetailVO thunderDetailVO = 
				ThunderDetailVO.builder()				
				.cbDate("2020-11-09/19:30")
				.cbAppPeriod("2020-11-09/19:00")
				.cbPlace("종각역")
				.cbSupplies("농구화")				
				.build();
				
		ThunderVO club = ThunderVO.builder()				
				.cbIntro("안녕하세요!!")
				.cbName("농구왕99")
				.cbCategory("운동/스포츠")
				.cbMbnum((long)20)
				.cbSubcat("농구")
				.cbHashtag("#농농농농")
				.cbCity("서울특별시")
				.cbDistrict("종로구")				
				.thunderDetailVO(thunderDetailVO)
				.build();
					
		mapper.insert(club);
		log.info(club);
	}
	
	
//	@Test
	public void testDelete() {
		log.info("DELETE COUNT : " + mapper.delete(32L));
	}
	
	
	
//	@Test
	public void testUpdate() {
		ThunderDetailVO thunderDetailVO = 
				ThunderDetailVO.builder()				
				.cbDate("2020-11-09/19:30")
				.cbAppPeriod("2020-11-09/19:00")
				.cbPlace("종각역88")
				.cbSupplies("농구화")				
				.build();
				
		ThunderVO club = ThunderVO.builder()				
				.cbIntro("안녕하세요!!")
				.cbName("농구왕88")
				.cbCategory("운동/스포츠")
				.cbMbnum((long)31)
				.cbSubcat("농구")
				.cbHashtag("#농농농농")
				.cbCity("서울특별시")
				.cbDistrict("종로구")
				.cbNum((long)31)
				.thunderDetailVO(thunderDetailVO)
				.build();
	
		log.info("club : " + club);
		
		int count = mapper.update(club);
		log.info("UPDATE COUNT : " + count);		
	}


	
	
}
