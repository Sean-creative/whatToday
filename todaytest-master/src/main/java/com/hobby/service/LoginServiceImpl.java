package com.hobby.service;
import javax.mail.internet.MimeMessage;

/**
 * 회원가입 / 로그인 / 아이디/비밀번호 찾기 서비스 인터페이스 구현 클래스
 * @author jiyeong
 */
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hobby.domain.UserVO;
import com.hobby.mapper.LoginMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class LoginServiceImpl implements LoginService{

	@Setter(onMethod_ = @Autowired)
	private LoginMapper mapper;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Override
	public String idDuplicateCheck(String usrId) {
		log.info("##Service : id_check");
		return mapper.idDuplicateCheck(usrId);
	}
	
	@Override
	public String phoneDuplicateCheck(String us_phone) {
		log.info("##Service: phoneDuplicateCheck");
		return mapper.phoneDuplicateCheck(us_phone);
	}

	@Transactional
	@Override
	public int register(UserVO user) {
		// 회원가입에 대한 정보 여러 테이블에 저장됨. 한번에 트랜잭션 처리
		// 테이블에 insert가 잘되면 행(1)을 반환
		// 5개 테이블에 잘 들어갔는 지 확인 // 질문: 트랜잭션처리 했는데 또 확인 해야 하나?
		// mapper.inser(user);
		int resultCount = 0;
		log.info("##Service : register");
		
		resultCount += mapper.insert(user);
		resultCount += mapper.insertUserInfo(user);
		resultCount += mapper.insertUserTerms(user);
		resultCount += mapper.insertUserHistory(user);
		resultCount += mapper.insertAuth();

		return resultCount;
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

	@Override
	public boolean sendPassword(String email, String pwd) {
		  log.info("##Service: sendPassword");
		  boolean result = true;
	    	try {
	    		MimeMessage message = mailSender.createMimeMessage();
	    		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

	    		messageHelper.setFrom("whattodayhobby@gmail.com", "오늘뭐하지"); // 보내는사람 생략하거나 하면 정상작동을 안함
	    		messageHelper.setTo(email); // 받는사람 이메일
	    		messageHelper.setSubject("비밀번호를 확인하세요"); // 메일제목은 생략이 가능하다
	    		messageHelper.setText(pwd); // 메일 내용

	    		mailSender.send(message);
	    	}catch (Exception e) {
	            e.printStackTrace();
	            result = false;
	        }
	    	return result;
	}
	
	

}
