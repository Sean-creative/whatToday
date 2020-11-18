package com.hobby.security.domain;
/**
 * 작성자: 김지영
 */
import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;

import com.hobby.domain.UserVO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
public class CustomUser extends User{

	private static final long serialVersionUID = 1L;

	private UserVO user;
	
	public CustomUser(String username, String password, 
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public CustomUser(UserVO vo) {
		super(vo.getUsrId(), vo.getUsrPwd(), vo.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		System.out.println("CustomUser, VO: " + vo);
		this.user = vo;
	}
	
	
}

