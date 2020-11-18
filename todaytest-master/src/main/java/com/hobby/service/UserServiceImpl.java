package com.hobby.service;
import org.springframework.stereotype.Service;

import com.hobby.domain.UserVO;
import com.hobby.mapper.UserMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService {

	private UserMapper mapper;
	

	@Override
	public UserVO get(long usrNum) {
		
		log.info("get :" + usrNum);
				
		return mapper.read(usrNum);
	}

	
		
}
