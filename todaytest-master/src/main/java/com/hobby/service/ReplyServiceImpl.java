package com.hobby.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.hobby.domain.ReplyVO;
import com.hobby.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {

	private ReplyMapper mapper;
	
	@Override
	public int register(ReplyVO vo) {
		
		log.info("register......" + vo);
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		
		log.info("get......."+ rno);
		return mapper.read(rno);
	}

	@Override
	public int remove(Long rno) {
		
		log.info("remove...."+ rno);
		return mapper.delete(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		
		log.info("modify....."+ vo);
		return mapper.update(vo);
	}
	
	@Override
	public List<ReplyVO> getList(Long cbBno) {
		
		log.info("getList....." + cbBno);
		return mapper.getList(cbBno);
	}

}
