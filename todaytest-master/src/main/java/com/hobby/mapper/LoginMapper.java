package com.hobby.mapper;
/**
 * 작성자: 김지영
 */
import org.apache.ibatis.annotations.Param;

import com.hobby.domain.UserVO;

public interface LoginMapper {
	
	public int insert(UserVO user);
	
	public int insertUserInfo(UserVO user);
	
	public int insertUserTerms(UserVO user);
	
	public int insertUserHistory(UserVO user);
	
	public int insertAuth();
	
	public UserVO read(String usrId);
	
	public String idDuplicateCheck(String usrId);
	
	public String findId(@Param("usrName")String usrName, @Param("usrPhone")String usrPhone);

	public String findPwd(String usrId);

	public String phoneDuplicateCheck(String us_phone);
	
	
	
}