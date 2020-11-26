package com.hobby.security;
/**
 *
 * UserDetailsService 인터페이스를 구현해서 처리하는 클래스
 * (UserDetailsService는 UserDetail를 반환하기 때문에 
 * customUser를 반환하게 하기 위해 만든 클래스)
 * @author jiyeong
 */
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.hobby.domain.UserVO;
import com.hobby.mapper.LoginMapper;
import com.hobby.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Setter(onMethod_ = @Autowired)
	private LoginMapper mapper;

	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {

		log.warn("Load User By UserName : " + userName);
		
		UserVO user = mapper.read(userName);
		
		log.warn("mapperuser: " + user);
		
		if(user == null) {
			// DB에서 아이디로 찾은 유저가 없으면 null을 반환한다.
			return null;
		}else {
			CustomUser customUser = new CustomUser(user);
			log.warn("custoemUser: " + customUser);
			return customUser;
		}
		
		
	} 
}