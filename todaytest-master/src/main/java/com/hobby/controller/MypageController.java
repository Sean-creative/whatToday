package com.hobby.controller;


import java.security.Principal;
/**
 * 작성자 : 국민성
 */
import java.util.List;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;


import com.hobby.domain.CategoryVO;
import com.hobby.domain.ClubVO;
import com.hobby.domain.UserVO;
import com.hobby.security.domain.CustomUser;
import com.hobby.service.MypageService;


import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/account/*")
@SessionAttributes("userVO")
@AllArgsConstructor
@Log4j
public class MypageController {

	@Setter(onMethod_ = @Autowired)
	private MypageService service;

	
	//메인페이지
	//가입한 모임 누르면 탈퇴/상세 보이게 구현해야함 -> 아직안했어요
	@RequestMapping("/main")
	public void main(Model model,Authentication auth) {
		
		log.info("##/main");
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		Long usrNum = customUser.getUser().getUsrNum();
		model.addAttribute("userVO",service.getUser(customUser.getUser().getUsrId()));
		model.addAttribute("myClub",service.getMyClubList(usrNum));
		model.addAttribute("waitClub",service.getWaitClubList(usrNum));
		model.addAttribute("prevClub",service.getPrevClubList(usrNum));
		
	} 
	
	//회원정보수정하게되면 비밀번호를 재입력받는 페이지
	//auth_leave 페이지랑 통합하는 방법을 생각해볼것
	@RequestMapping("/auth_edit") 
	public void auth_edit(Principal principal) {
		
	}
	
	//대략적인 비밀번호 유효성 검사
	@PostMapping("/authAction")
	public String authAction(Authentication auth, @RequestParam("password")String password, Model model) {
		
		String url = "redirect:/account/auth_edit";
		
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		System.out.println(userVO);
		if(service.isPwdValid(password) && 
				service.findPwdInDB(password, userVO.getUsrPwd())) {
			url = "forward:/account/edit";
		}

		return url;
	}
	
	//ajax로 카테고리 db 가져옴
	@RequestMapping(value = "/{catClassificationCode}",
			produces = { MediaType.TEXT_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<CategoryVO>>getCategorylist(@PathVariable("catClassificationCode") String catClassificationCode,
			Principal principal) {
		log.info("get...........: " + catClassificationCode);
		
		return new ResponseEntity<>(service.getCategoryList(catClassificationCode),HttpStatus.OK);
	}
	
	//회원정보 수정페이지
	//도시정보를 가져와서 처음부터 박게 만들것
	@PostMapping("/edit")
	public void edit(Authentication auth, Model model){
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		System.out.println(userVO);
		model.addAttribute("userVO",userVO);
	}
	
	
	//수정한다으 업데이트
	//서비스들 통합 -> 트랜잭션?
	@PostMapping("/editAction")
	public String editAction(Authentication auth, Model model, UserVO updateUser) {
		
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		
		

		service.updateClubFounderName(updateUser);
		service.updateUserInfo(updateUser);
		service.updateClubMemberUpdate(updateUser);
		service.updateNameUserHistory(updateUser);
		service.updateMeetingMemberName(updateUser);
		service.updateUserDetail(updateUser);
		
		return "redirect:/account/main";
		}
	
	//비밀번호 변경 페이지
	@RequestMapping("/password")
	public void password(Authentication auth) {
		log.info("##/password");
		
	}
	
	//변경 유효성 검사
	@PostMapping("/passwordAction")
	public String passwordAction(Authentication auth,
			@RequestParam("newPassword") String newPassword,@RequestParam("currentPassword") String currentPassword) {
		log.info("##/passwordAction");
		String url = "/account/password";
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		String usrId = customUser.getUser().getUsrId();
		UserVO userVO = service.getUser(usrId);
		if(service.isPwdValid(newPassword) &&
				service.isPwdValid(currentPassword)
				&& service.findPwdInDB(currentPassword, userVO.getUsrPwd())) {
			userVO.setUsrPwd(newPassword);
			service.updateUserInfo(userVO);
			
			url = "/account/main";
		}	
		
		return url;
	}
	
	//회원탈퇴 비밀번호 입력페이지
	@RequestMapping("/auth_leave") 
	public void auth_leave(Authentication auth) {
	}
	
	//탈퇴하면 유저 상태를 사이트탈퇴로 바꾸고 main이나 login 페이지로 이동하게
	@PostMapping("/leaveAction")
	public String leaveAction(Authentication auth, @RequestParam("password")String password, 
			 Model model) {
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		String url = "/account/auth_leave";
		
		if(service.isPwdValid(password) && 
				service.findPwdInDB(password, userVO.getUsrPwd())) {
			userVO.setUsrState("사이트탈퇴");
			service.updateUserInfo(userVO);
			service.insertUserHistory(userVO);
			service.leaveSite(userVO);
			url = "redirect:/login/logout";
		}

		return url;
	}
	
	//모임관리 메인페이지
	//모임 수정버튼누르면 -> 모임페이지에서 수정하도록
	//모임 탈퇴누르면 -> 탈퇴하도록 구현해야함
	//아직 버튼 이동경로 몰라서 안함
	@PostMapping("/myclub/main")
	public void myclubMain(Authentication auth, Model model) {
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		model.addAttribute("clubVO",service.getMyCreateClubList(userVO.getUsrNum()));
	
	}
	
	//ajax로 내가 만든 모임을 가져옴
	@RequestMapping(value = "/myclub/{cbLeaderNum}",
			produces = { MediaType.TEXT_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ClubVO>>getlist(@PathVariable("cbLeaderNum") Long cbLeaderNum,
			Authentication auth) {
		log.info("get...........: " + cbLeaderNum);
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		return new ResponseEntity<>(service.getMyCreateClubList(userVO.getUsrNum()),HttpStatus.OK);
	}
	
	@RequestMapping(value = "/myclub/club/{cbNum}",
			produces = { MediaType.TEXT_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ClubVO>getMyClublist(@PathVariable("cbNum") Long cbNum,
			Authentication auth) {
		log.info("get...........: " + cbNum);
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		return new ResponseEntity<>(service.getMyClublist(cbNum),HttpStatus.OK);
	}
	
//	@PostMapping("/myclub/regularEdit")
//	public void regularEdit(ClubVO clubVO, Model model) {
//
//	}
//	@PostMapping("/myclub/thunderEdit")
//	public void thunderEdit(ClubVO clubVO, Model model) {
//
//	}
}