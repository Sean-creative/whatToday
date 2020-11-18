package com.hobby.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.hobby.domain.ClubVO;
import com.hobby.domain.Criteria;
import com.hobby.mapper.ClubMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ClubServiceImpl implements ClubService {

	private ClubMapper mapper;
	
	//정기모임 개설 
	@Override
	public void registerClub(ClubVO club) {
		
		log.info("registerClub....."+ club);
		mapper.clubinsertSelectKey(club);
	}

	//정기모임 목록 
	@Override
	public List<ClubVO> getClubList() {
		
		log.info("getList.......");
		return mapper.getClubList();
	}

	//정기모임 상세정보
	@Override
	public ClubVO getClub(Long cbNum) {
		
		log.info("getclub......"+ cbNum);
		return mapper.readclub(cbNum);
	}

	//정기모임 게시판 - 조회
	@Override
	public ClubVO get(Long cbBno) {
		
		log.info("get......"+ cbBno);
		return mapper.read(cbBno);
	}

	//정기모임 게시판 - 목록list (페이징)
	@Override
	public List<ClubVO> getList(Criteria cri) {
		
		log.info("get List with criteria:" + cri);
		return mapper.getListWithPaging(cri);
	}

	//정기모임 게시판 - 목록list
	@Override
	public List<ClubVO> getList(Long cl_number) {
		
		log.info("getList........");
		return mapper.getList(cl_number);
	}
	
	//정기모임 게시판 - 조회수
	@Override
	public int boardViews(Long cbBno) {
		
		log.info("modify......"+ cbBno);
		return mapper.boardViews(cbBno);
	}

}
