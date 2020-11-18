package com.hobby.security;
/**
 * 작성자: 김지영
 */
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.hobby.domain.UserVO;
import com.hobby.mapper.AccountMapper;
import com.hobby.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Setter(onMethod_ = @Autowired)
	private AccountMapper mapper;

	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {

		log.warn("Load User By UserName : " + userName);
		
		UserVO user = mapper.read(userName);
		
		log.warn("mapperuser: " + user);
		
		
		
		if(user == null) {
			return null;
		}else {
			CustomUser customUser = new CustomUser(user);
			log.warn("custoemUser: " + customUser);
			return customUser;
		}
		
		
	} 
}