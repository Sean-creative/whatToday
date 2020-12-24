package com.hobby.controller;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.hobby.domain.UserVO;
import com.hobby.security.domain.CustomUser;
import com.hobby.service.LoginService;
import com.hobby.sns.GoogleLogin;
import com.hobby.sns.KakaoLoginApi;
import com.hobby.sns.NaverLogin;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * 회원가입 / 로그인 / 아이디/비밀번호 찾기 페이지 관리
 * @author jiyeong
 */

@Controller
@Log4j
@RequestMapping("/login/*")
@AllArgsConstructor
public class LoginController {

	private LoginService service;

	//1 . 로그인 화면 요청
	@GetMapping("/login")
	public void login() {
		log.info("##/login");
	}

	// 2. 회원가입 화면 요청
	@GetMapping("/register")
	public void register() {
		log.info("##/register");

	}

	// 3-0-1. 아이디 중복  검사
	@ResponseBody
	@RequestMapping(value = "/idDuplicateCheck", produces="text/plain")
	public String id_check(@RequestBody String inputValue) {
		String id = service.idDuplicateCheck(inputValue);
		// 입력한 아이디와 같은게 있으면 해당 아이디를 반환한다.
		return id == null ? null : id;
	}

	// 3-0-2. 핸드폰 번호 중복  검사
	@ResponseBody
	@RequestMapping(value = "/phoneDuplicateCheck", produces="text/plain")
	public String phone_check(@RequestBody String inputValue) {
		String phone = service.phoneDuplicateCheck(inputValue);
		// 입력한 핸드폰 번호와 같은게 있으면 해당 핸드폰 번호를 반환한다.
		return phone == null ? null : phone;
	}


		// 3. 회원가입 처리 - 메일 본인확인 버전
		@PostMapping("/registerAction")
		public String registerAction(UserVO user, RedirectAttributes rtts) {
			log.info("##/registerAction: " + user);
			// DB에 회원정보가 정상적으로 입력되었는가
			// 회원가입 정보 - 5개 테이블에 입력 됨   
			// 회원가입이 성공되면 로그인 페이지로 넘어간다.
			if(service.register(user)) {
				// 본인확인 메일 전송
				if(service.sendRegisterMail(user.getUsrId(), user.getUsrState())){
					// alert로 회원가입 성공 여부 알림
					rtts.addFlashAttribute("registerSuccessMsg", user.getUsrName()+"님, 메일로 본인확인하여 회원가입을 완료해주세요.");
					
					return "redirect:/login/login";
					// 회원가입이 안되면 다시 회원가입 페이지로 이동
				}
				return "redirect:/login/login";
			}else {
				rtts.addFlashAttribute("registerFailMsg", "회원정보를 다시 입력해주세요.");
				return "redirect:/login/register";
			}
		}
		
		@GetMapping("/register/confirm")
		public String registerConfirm(@RequestParam("usrId") String usrId, @RequestParam("authKey") String authKey) {
			log.info("usrId: " + usrId);
			log.info("authKey: " + authKey );
			if(service.registerConfirm(usrId, authKey)) {
				return "redirect:/login/login";
				
			}
			return "redirect:/login/register";
		}

//	// 3. 회원가입 처리 - test용 - 메일 확인 없이 그냥 회원가입되도록 / serviceImpl도 추적처기
//	@PostMapping("/registerAction")
//	public String registerAction(UserVO user, RedirectAttributes rtts) {
//		log.info("##/registerAction: " + user);
//		// DB에 회원정보가 정상적으로 입력되었는가
//		// 회원가입 정보 - 5개 테이블에 입력 됨   
//		// 회원가입이 성공되면 로그인 페이지로 넘어간다.
//		if(service.register(user)) {
//			return "redirect:/login/login";
//		}else {
//			rtts.addFlashAttribute("registerFailMsg", "회원정보를 다시 입력해주세요.");
//			return "redirect:/login/register";
//		}
//	}
//

	//	@GetMapping("/loginSuccess")
	//	public void loginSuccess(Authentication auth, Model model) {
	//		log.info("##/loginSuccess");
	//		CustomUser customUser = (CustomUser) auth.getPrincipal();
	//		String usrName = customUser.getUser().getUsrName();
	//		model.addAttribute("usrName", usrName);
	//	}

	// 4. 아이디/비밀 번호 찾기 화면 요청
	@GetMapping("/find")
	public void find() {
		log.info("##/find");
	}

	// 4-1. 아이디 찾기
	@ResponseBody
	@RequestMapping(value = "/find_id", produces="text/plain")
	public String find_id(@RequestBody Map<String, String> map) {
		log.info("##/find_id");

		String inputName = map.get("name");
		String inputPhone = map.get("phone");

		String id = service.findUserId(inputName, inputPhone);

		// 사용자가 입력한 이름과 핸드폰번호로 사용자의 아이디를 찾는데 
		// 사용자의 아이디가 있으면 사용자의 아이디를 반환한다.
		// 1차 리뷰 : 리턴을 빈문자열로 
		log.info("##/find ID:  " + id);
		return id == null ? null : id;
	}

	// 4-2. 비밀번호 찾기
	@ResponseBody
	@RequestMapping(value = "/find_pwd", produces="text/plain")
	public String find_pwd(@RequestBody String inputEmail) {

		log.info("##/find_pwd");

		String result = "";
		String pwd = service.findUserPwd(inputEmail);
		log.info("##/find pwd:  " + pwd);

		// 사용자가 입력한 이메일(아이디)로 사용자의 비밀번호를 찾는다.		
		// 1. 비밀번호가 있으면
		if(pwd!=null) {
			//1-1. 비밀번호를 입력한 사용자 이메일로 보낸다.
			if(service.sendPassword(inputEmail, pwd)){
				// 1차리뷰: result enum 처리 어떤가???
				result = "1";
			}// 1-2. 메일 보내기에 실패하면 "-1"를 반환한다.
			else {
				result = "-1";
			}
		}
		// 2. 비밀번호가 없으면 "0"을 반환한다.
		else {
			return "0";
		}
		return result;
	}

	// 5. 카카오 로그인
	@RequestMapping(value ="/kakaoLogin", produces = "application/json" , method = RequestMethod.GET)
	public String KakaoLogin(@RequestParam("code") String code, RedirectAttributes rtts, HttpSession session,
			HttpServletResponse response, Model model) throws Exception{

		JsonNode accessToken;

		// JsonNode트리형태로 토큰받아온다
		JsonNode jsonToken = KakaoLoginApi.getKakaoAccessToken(code);
		accessToken = jsonToken.get("access_token");

		JsonNode userInfo = KakaoLoginApi.getKakaoUserInfo(accessToken);
		System.out.println("###userInfo: " + userInfo);

		JsonNode properties = userInfo.path("properties");
		JsonNode kakao_account = userInfo.path("kakao_account");

		// 카카오 이메일을 사이트 아이디랑 비밀번호로 
		String kakaoEmail = kakao_account.path("email").asText();
		String usrName = properties.path("nickname").asText();

		//        String usrPwd = userInfo.path("id").asText();
		//        String profile_image = properties.path("profile_image").asText();

		//        System.out.println("id : " + usrId);
		//        System.out.println("name : " + usrPwd);
		//        System.out.println("email : " + usrName);

		// 5-1. 이메일이 DB없으면 회원가입 (카카오에서 제공하는 회원가입 창 그대로 사용 / sns회원가입 -> 따로 사용자 정보 입력X)
		if (service.idDuplicateCheck(kakaoEmail) == null) {

			UserVO user = new UserVO();
			user.setUsrId(kakaoEmail);
			user.setUsrPwd(kakaoEmail);
			user.setUsrName(usrName);
			user.setUsrPhone("");
			user.setUsrGender("");
			user.setUsrBirth("");
			user.setUsrType("카카오 회원가입");
			user.setUsrState("회원");

			if(service.snsRegister(user)) {
				// alert로 회원가입 성공 여부 알림
				rtts.addFlashAttribute("registerSuccessMsg", user.getUsrName()+"님 반갑습니다.");
				return "redirect:/login/login";
				// 회원가입이 안되면 다시 회원가입 페이지로 이동
			}else {
				rtts.addFlashAttribute("registerFailMsg", "회원정보를 다시 입력해주세요.");
				return "redirect:/login/register";
			}
		}

		// 5-2. 이메일이 DB에 있으면 사이트 회원이므로 로그인 입력창 회원정보 넘겨주기.
		model.addAttribute("username", kakaoEmail);
		model.addAttribute("password", kakaoEmail);

		return "/login/login";
	}

	//    @RequestMapping(value = "/kakaoLogout", produces = "application/json")
	//    public String kakaoLogout(HttpSession session) {
	//        //kakao restapi 객체 선언
	//        //노드에 로그아웃한 결과값음 담아줌 매개변수는 세션에 잇는 token을 가져와 문자열로 변환
	//        JsonNode node = KakaoLoginApi.logout(session.getAttribute("token").toString());
	//        //결과 값 출력
	//        System.out.println("로그인 후 반환되는 아이디 : " + node.get("id"));
	//        return "redirect:/login/login";
	//    }

	// 6. 네이버 로그인
	@RequestMapping(value = "/login/naverLogin")
	public String naverLogin(Model model, HttpSession session) {
		log.info("##/login/naverLogin");

		/* 네이버아이디로 인증 URL을 생성하기 위하여 NaverLoginDTO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = NaverLogin.getAuthorizationUrl(session);
		System.out.println("네이버:" + naverAuthUrl);

		/* 생성한 인증 URL로 로그인 요청 */
		return "redirect: " + naverAuthUrl;
	}


	// 6-1. 네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/login/naverCallback")
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session, RedirectAttributes rtts)
			throws IOException, ParseException, InterruptedException, ExecutionException {
		log.info("##/login/naverCallback");
		OAuth2AccessToken oauthToken;
		oauthToken = NaverLogin.getAccessToken(session, code, state);
		//로그인 사용자 정보를 읽어온다.
		String apiResult = NaverLogin.getUserProfile(oauthToken);
		//        System.out.println("사용자 정보: " + apiResult);
		//{"resultcode":"00","message":"success","response":{"id":"62403566","email":"dnwntjs1531@naver.com","name":"\uae40\uc9c0\uc601"}}

		// 사용자 정보를 String으로만 받을 수 있어서 변환 후 원하는 정보만 가져오기
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);

		JSONObject jsonObj = (JSONObject) obj;
		JSONObject response = (JSONObject)jsonObj.get("response");

		// 네이버 이메일을 사이트 아이디, 비밀번호로 
		String naverEmail = (String) response.get("email");
		String usrName = (String) response.get("name");


		// 6-1-1. 이메일이 DB에 없으면 자동 회원가입
		if(service.idDuplicateCheck(naverEmail) == null) {
			UserVO user = new UserVO();
			user.setUsrId(naverEmail);
			user.setUsrPwd(naverEmail);
			user.setUsrName(usrName);
			user.setUsrPhone("");
			user.setUsrGender("");
			user.setUsrBirth(""); 
			user.setUsrType("네이버 회원가입");

			if(service.snsRegister(user)) {
				// alert로 회원가입 성공 여부 알림
				rtts.addFlashAttribute("registerSuccessMsg", user.getUsrName());
				return "redirect:/login/login";
				// 회원가입이 안되면 다시 회원가입 페이지로 이동
			}else {
				rtts.addFlashAttribute("registerFailMsg", "회원정보를 다시 입력해주세요.");
				return "redirect:/login/register";
			}
		}

		// 6-1-2. 이메일이 DB에 있으면 사이트 회원이므로 로그인 입력창 회원정보 넘겨주기.
		model.addAttribute("username", naverEmail);
		model.addAttribute("password", naverEmail);

		return "/login/login";
	}

	@GetMapping("/test")
	@PreAuthorize("isAuthenticated()")
	public void test() {
		CustomUser customUser = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String name = customUser.getUser().getUsrName();
		log.info("####test####");
		log.info("name" + name);

	}

	// 7. 구글 로그인
	@RequestMapping(value = "/googleLogin", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {
		log.info("##/login/googleLogin");
		/* 구글 아이디 인증 URL을 생성하기 위하여 googleLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String googleAuthUrl = GoogleLogin.getAuthorizationUrl();
		System.out.println("구글 AuthURI: " + googleAuthUrl);

		model.addAttribute("url", googleAuthUrl);

		/* 생성한 인증 URL로 로그인 요청 */
		return "redirect: " + googleAuthUrl;
	}

	// 7-1. 구글 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/auth/google/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code)
			throws IOException, InterruptedException, ExecutionException {
		log.info("##/login/googleCallback");

		OAuth2AccessToken oauthToken = GoogleLogin.getAccessToken(code);

		//로그인 사용자 정보를 읽어온다.
		String apiResult = GoogleLogin.getUserProfile(oauthToken);

		ObjectMapper mapper = new ObjectMapper();
		JsonNode userInfo = mapper.readTree(apiResult);

		log.info("userInfo: " + userInfo);

		String googleEmail = userInfo.path("email").asText();
		System.out.println(googleEmail);

		// 이름 정보를 가져오고 싶으면 GoogleLogin에서 scope 변경해서 가져와야함.
		//		String usrName = userInfo.path("name").asText();
		//		System.out.println(usrName);

		model.addAttribute("user", googleEmail);
		return "/login/googleSuccess";
	}
}

