package com.hobby.security;
/**
 * 사용자가 권한이 있는지 확인
 * 로그인 성공 후 특정 URI로 이동하기 위한 클래스
 * @author jiyeong 
 */
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		
		log.warn("Login Success");
		
		List<String> roleNames = new ArrayList<>();
		
		auth.getAuthorities().forEach(authority -> {
			
			roleNames.add(authority.getAuthority());
			
		});
		
	log.warn("ROLE NAMES: "+ roleNames);
	
//  나중에	
//	if(roleNames.contains("ROLE_ADMIN")) {
//		response.sendRedirect("mainAdmin");
//		return;
//	}
	
	// 회원 권한이 있으면(ROLE_MEMBER) 로그인 성공 -> 메인 페이지로  
	if(roleNames.contains("ROLE_MEMBER")) {
		response.sendRedirect("/index/main");
		return;
	}
	
	// 회원이 탈퇴되어 있으면 일단 로그아웃 페이지로 
	if(roleNames.contains("ROLE_MEMBEROUT")) {
		response.sendRedirect("/login/logout");
		return;
	}
	
	}

	
}
