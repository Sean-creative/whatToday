package com.hobby.mapper;
/**
 * 작성자: 김지영
 */
import org.apache.ibatis.annotations.Param;

import com.hobby.domain.UserVO;

public interface AccountMapper {
	
	public void insert(UserVO user);
	
	public void insertUserInfo(UserVO user);
	
	public void insertUserTerms(UserVO user);
	
	public void insertUserHistory(UserVO user);
	
	public void insertAuth();
	
	public UserVO read(String usrId);
	
	public String idDuplicateCheck(String usrId);
	
	public String findId(@Param("usrName")String usrName, @Param("usrPhone")String usrPhone);

	public String findPwd(String usrId);
	
	
	
}