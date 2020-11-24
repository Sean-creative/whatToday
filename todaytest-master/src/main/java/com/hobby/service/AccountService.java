package com.hobby.service;
/**
 * 작성자: 김지영
 */
import com.hobby.domain.UserVO;

public interface AccountService {
	public int register(UserVO user);
	
	public String idDuplicateCheck(String us_id);

	public String findUserId(String us_name, String us_phone);

	public String findUserPwd(String us_id);

	public String phoneDuplicateCheck(String us_phone);
	
	public boolean sendPassword(String email, String pwd);
}
