package com.hobby.service;
/**
 * 작성자: 김선우
 */
import java.util.List;

import org.springframework.stereotype.Service;

import com.hobby.domain.ThunderVO;
import com.hobby.domain.Criteria;
import com.hobby.mapper.ThunderMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@Service
@AllArgsConstructor
public class ThunderServiceImpl implements ThunderService {

	private ThunderMapper mapper;
	
	@Override
	public List<ThunderVO> getList() {
		log.info("get List ");
		return mapper.getList();		
	}
	

	@Override
	public ThunderVO get(long cbNum) {
		log.info("get ...." + cbNum );
		return mapper.read(cbNum);
	}
	

	@Override
	public void register(ThunderVO clubVO) {
		log.info("register ...." + clubVO );
		mapper.insert(clubVO);
	}
	

	@Override
	public List<ThunderVO> getList(Criteria cri) {
		log.info("get List with criteria: " + cri );
		return mapper.getListWithPaging(cri);
	}
	
	
	@Override
	public boolean modify(ThunderVO club) {
		log.info("modify...." + club);
		return mapper.update(club) == 1;
		
	}
	

	@Override
	public boolean remove(long cbNum) {
		log.info("remove...." + cbNum);
		return mapper.delete(cbNum) == 1;
	}
	

	
	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

		
}
