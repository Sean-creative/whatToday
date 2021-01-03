package com.hobby.service;

/**
 * 회원가입 / 로그인 / 아이디/비밀번호 찾기 서비스 인터페이스 구현 클래스
 * @author jiyeong
 */
import javax.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hobby.domain.UserVO;
import com.hobby.mapper.LoginMapper;
import com.hobby.mapper.MypageMapper;

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

	@Setter(onMethod_=@Autowired)
	private PasswordEncoder pwencoder;

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
    //메일 본인확인 버전
	public boolean register(UserVO user) {
		// 회원가입에 대한 정보 여러 테이블에 저장됨. 한번에 트랜잭션 처리
		// 테이블에 insert가 잘되면 행(1)을 반환
		// 5개 테이블에 잘 들어갔는 지 확인
		log.info("##Service : register");

		String registerPwd = user.getUsrPwd();
		user.setUsrPwd(pwencoder.encode(registerPwd));
		
		// 메일로 본인 확인 인증 전 회원상태 = 난수
		String authKey = (int) (Math.random()*100000000)+"";
		user.setUsrState(authKey);
		System.out.println("authKey: " + authKey);
		
		int resultCount = 0;

		resultCount += mapper.insert(user);
		resultCount += mapper.insertUserInfo(user);
		resultCount += mapper.insertUserTerms(user);
		resultCount += mapper.insertUserHistory(user);
		resultCount += mapper.insertAuth();

		return resultCount == 5;
	}
	
//	@Transactional
//	@Override
//	public boolean register(UserVO user) {
//		// 회원가입에 대한 정보 여러 테이블에 저장됨. 한번에 트랜잭션 처리
//		// 테이블에 insert가 잘되면 행(1)을 반환
//		// 5개 테이블에 잘 들어갔는 지 확인
//		log.info("##Service : register");
//		
//		String registerPwd = user.getUsrPwd();
//		user.setUsrPwd(pwencoder.encode(registerPwd));
//		
//		user.setUsrState("회원");
//		
//		int resultCount = 0;
//
//		resultCount += mapper.insert(user);
//		resultCount += mapper.insertUserInfo(user);
//		resultCount += mapper.insertUserTerms(user);
//		resultCount += mapper.insertUserHistory(user);
//		resultCount += mapper.insertAuth();
//
//		return resultCount == 5;
//	}

	// 본인확인 메일 전송
	public boolean sendRegisterMail(String email, String authKey) {
		log.info("##Service: registerMail");

		String htmlStr = "<h1>메일인증안내입니다.</h1><br>"
				+ "<h2>안녕하세요</h2>"
				+ "<h2><span style='font-size:25px; background: linear-gradient(to top, rgba(255,175,49,0.7) 50%, transparent 50%);'>오늘뭐하지?</span>를 이용해 주셔서 진심으로 감사드립니다.</h2>"
				+ "<h2>아래 링크를 클릭하여 회원가입을 완료해 주세요.</h2>"
				+ "<h2>감사합니다.</h2>"
				+ "<a href='http://localhost:8088/login/register/confirm?usrId=" + email + "&authKey=" + authKey + "'>로그인하러가기</a>";
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom("whattodayhobby@gmail.com", "오늘뭐하지"); // 보내는사람 생략하거나 하면 정상작동을 안함
			messageHelper.setTo(email); // 받는사람 이메일
			messageHelper.setSubject("메일 인증 안내 입니다."); // 메일제목은 생략이 가능하다
			messageHelper.setText(htmlStr, true);
			
			mailSender.send(message);
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}


	// 본인확인, 회원상태를 회원으로 변경하기
	public boolean registerConfirm(String usrId, String authKey) {
		UserVO user = mapper.read(usrId);
		System.out.println("상태: " + user.getUsrState() );
		if(user.getUsrState().equals(authKey)) {
			user.setUsrState("회원");
			mapper.updateUsrState(user);
			return true;
		}else if(user.getUsrState().equals("회원")) {
			// 다시 링크를 누를 수 있으니 상태가 회원이면  로그인창으로 가게하기
			return true;
		}
		return false;
	}
	
	@Transactional
	@Override
	public boolean snsRegister(UserVO user) {
		log.info("##Service : snsRegister");

		String registerPwd = user.getUsrPwd();
		user.setUsrPwd(pwencoder.encode(registerPwd));

		int resultCount = 0;

		resultCount += mapper.insert(user);
		resultCount += mapper.insertUserInfo(user);
		resultCount += mapper.insertAuth();

		return resultCount == 3;
	}

	@Override
	public String findUserId(String usrName, String usrPhone) {
		log.info("##Service : findUserId");
		return mapper.findId(usrName, usrPhone);
	}

	@Override
	public String findUserPwd(String usrId) {
		log.info("##Service: findUserPwd");
		
		String usrPwd = mapper.findPwd(usrId);
		if(usrPwd==null) {
			return null;
		}else {
			// 암호화된 비밀번호로 DB업데이트
			usrPwd = usrPwd.substring(10,20); 
			mapper.updateUserPwd(usrId, pwencoder.encode(usrPwd));
			
			// 암호화된 비밀번호 사용자의 메일로 전송
			return usrPwd;
		}
	}
	
	@Override
	public boolean sendPassword(String email, String pwd) {
		log.info("##Service: sendPassword");
		boolean result = true;
		
		String htmlStr = "<h1>비밀번호 재설정 메일 안내입니다.</h1><br>"
				+ "<h3>안녕하세요</h3>"
				+ "<h3>오늘뭐하지를 이용해 주셔서 진심으로 감사드립니다.</h3>"
				+ "<h3>요청하신 임시 비밀번호는 다음과 같습니다.</h3>"
				+ "<h3>임시 비밀번호: " + pwd + "</h3>"
				+ "<h3>임시 비밀번호를 사용해서 로그인하신후 비밀번호를 변경하셔야 정상적으로 로그인이 가능합니다.</h3>"
				+ "<a href='http://localhost:8088/mypage/password?'>비밀번호 변경하러 가기</a>";
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom("whattodayhobby@gmail.com", "오늘뭐하지"); // 보내는사람 생략하거나 하면 정상작동을 안함
			messageHelper.setTo(email); // 받는사람 이메일
			messageHelper.setSubject("비밀번호를 확인하세요"); // 메일제목은 생략이 가능하다
			messageHelper.setText(htmlStr, true); // 메일 내용

			mailSender.send(message);
		}catch (Exception e) {
			e.printStackTrace();
			result = false;
		}
		return result;
	}



}
