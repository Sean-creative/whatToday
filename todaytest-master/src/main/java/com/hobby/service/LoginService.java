package com.hobby.service;
/**
 * 회원가입 / 로그인 / 아이디/비밀번호 찾기 서비스 인터페이스
 * @author jiyeong
 */
import com.hobby.domain.UserVO;

public interface LoginService {
	public int register(UserVO user);
	
	public String idDuplicateCheck(String us_id);

	public String phoneDuplicateCheck(String us_phone);
	
	public String findUserId(String us_name, String us_phone);

	public String findUserPwd(String us_id);

	public boolean sendPassword(String email, String pwd);
}