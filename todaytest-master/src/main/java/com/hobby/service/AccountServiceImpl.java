package com.hobby.service;
/**
 * 작성자: 김지영
 */
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hobby.domain.UserVO;
import com.hobby.mapper.AccountMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AccountServiceImpl implements AccountService{

	@Setter(onMethod_ = @Autowired)
	private AccountMapper mapper;

	@Override
	public void register(UserVO user) {
		log.info("##Service : register");
		mapper.insert(user);
		mapper.insertUserInfo(user);
		mapper.insertUserTerms(user);
		mapper.insertUserHistory(user);
		mapper.insertAuth();
	}

	@Override
	public String idDuplicateCheck(String usrId) {
		log.info("##Service : id_check");
		return mapper.idDuplicateCheck(usrId);
	}

	@Override
	public String findUserId(String usrName, String usrPhone) {
		log.info("##Service : findUserId");
		return mapper.findId(usrName, usrPhone);
	}


	@Override
	public String findUserPwd(String usrId) {
		log.info("##Service: findUserPwd");
		return mapper.findPwd(usrId);
	}

}
