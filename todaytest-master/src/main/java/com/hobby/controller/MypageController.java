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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hobby.domain.CategoryVO;
import com.hobby.domain.ClubVO;
import com.hobby.domain.RegionVO;
import com.hobby.domain.UserVO;
import com.hobby.security.domain.CustomUser;
import com.hobby.service.MypageService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/mypage/*")
@SessionAttributes("userVO")
@AllArgsConstructor
@Log4j
public class MypageController {

	@Setter(onMethod_ = @Autowired)
	private MypageService service;

	// 메인페이지
	@GetMapping("/main")
	public String main(Model model, Authentication auth) {

		String url = "/mypage/main";
		// 0. 만일 로그인이 되어 있지 않은데 주소로 이곳을 접속하려고하면, login page로 redirect시켜버림
		log.info("##/main");
		if (auth == null) {
			url = "redirect:/login/login";
		} else {
			// 기본적인 사용자의 정보를 보여줌 : 회원 ID/이름/전화번호 현재가입모임 등등
			// 1. 회원 정보를 가져온다 -> 로그인을 하면 생기는 Authentication 통하여 회원정보를 가져옴
			CustomUser customUser = (CustomUser) auth.getPrincipal();
			Long usrNum = customUser.getUser().getUsrNum();
			
			// 1.1 회원 정보를 가져와서 모델에 넣음
			model.addAttribute("userVO", service.getUser(customUser.getUser().getUsrId()));

			// 2. 회원정보를 통해서 현재가입모임을 가져와서 모델에 넣음
			model.addAttribute("clubVO", service.getMyClubList(usrNum));

			// 가입대기중인 모임 / 이전에 가입한 모임 => 모임가입이 구현되면써먹을것.
//			model.addAttribute("waitClub", service.getWaitClubList(usrNum));
//			model.addAttribute("prevClub", service.getPrevClubList(usrNum));
		}
		return url;
	}

	
	// 모임관리 메인페이지
	// 모임 수정버튼누르면 -> 모임페이지에서 수정하도록
	@GetMapping("/myclub/main")
	public String myclubMain(Authentication auth, Model model) {
		// 0. 만일 로그인이 되어 있지 않은데 주소로 이곳을 접속하려고하면, login page로 redirect시켜버림
		String url = "mypage/myclub/main";
		if (auth == null) {
			url = "redirect:/login/login";
		} else {
			// Authentication에 저장된 usrNum(유저번호)을 통하여 내가 만든 모임을 가져옴
			CustomUser customUser = (CustomUser) auth.getPrincipal();
			model.addAttribute("clubVO", service.getMyCreateClubList(customUser.getUser().getUsrNum()));
		}
		return url;

	}
	
	// 회원정보수정하게되면 비밀번호를 재입력받는 페이지
	// auth_leave 페이지랑 통합하는 방법을 생각해볼것
	@GetMapping("/auth_edit")
	public String auth_edit(Authentication auth) {

		String url = "/mypage/auth_edit";
		// 0. 만일 로그인이 되어 있지 않은데 주소로 이곳을 접속하려고하면, login page로 redirect시켜버림
		log.info("##/auth_edit");
		if (auth == null) {
			url = "redirect:/login/login";
		}

		return url;
	}

	// 비밀번호 유효성 검사
	// if else들을 어떻게 줄일지 생각해보기???
	@PostMapping("/authAction")
	public String authAction(Authentication auth, @RequestParam("password") String password, Model model,
			RedirectAttributes rtts) {
		String url = "";
		// 0. 만일 로그인이 되어 있지 않은데 주소로 이곳을 접속하려고하면, login page로 redirect시켜버림

		log.info("##/authAction");
		if (auth == null) {
			url = "redirect:/login/login";
		} else {
			// 1. DB에 있는 비밀번호와 사용자가 입력한 비밀번호를 비교하기위해 회원 정보를 가져온다.
			// Authentication에 저장된 usrId(유저 아이디)를 통해서 유저 정보를 가져옴
			CustomUser customUser = (CustomUser) auth.getPrincipal();
			UserVO userVO = service.getUser(customUser.getUser().getUsrId());
			System.out.println(userVO);

			// 2-1. 비밀번호 유효성검사, 가져온 유저정보와 비교해서 맞는지 Check하고 수정페이지로 보냄
			if (password != null && service.isPwdValid(password)
					&& service.comparePwdDB(password, userVO.getUsrPwd())) {

				url = "/mypage/edit";
				// 2-2. 비밀번호 유효성 검사를 통과히자 못하였을때
			} else {
				rtts.addFlashAttribute("msg", "비밀번호가 맞지 않아요");
				url = "redirect:/mypage/auth_edit";
			}
		}

		return url;
	}

	// 회원정보 수정페이지
	@PostMapping("/edit")
	public String edit(Authentication auth, Model model) {

		String url = "/mypage/edit";

		// 0. 만일 로그인이 되어 있지 않은데 주소로 이곳을 접속하려고하면, login page로 redirect시켜버림
		// postmapping이라 필요한지는 모르겠는데 일단 넣어둠
		log.info("##/edit");
		if (auth == null) {
			url = "redirect:/login/login";
		} else {

			// 1. 유저 정보를 가져옴
			CustomUser customUser = (CustomUser) auth.getPrincipal();
			UserVO userVO = service.getUser(customUser.getUser().getUsrId());
			System.out.println(userVO);

			// 2. 유저 정보를 모델에 넣어서 준다
			model.addAttribute("userVO", userVO);
			
		}
		return url;
	}

	// edit에서 전해준것들 유효성 검사, 업데이트
	@PostMapping("/editAction")
	public String editAction(Authentication auth, Model model, UserVO userVO, RedirectAttributes rtts) {

		String url = "redirect:/mypage/main";
		// 0. 만일 로그인이 되어 있지 않은데 주소로 이곳을 접속하려고하면, login page로 redirect시켜버림
		log.info("##/editAction");
		if (auth == null) {
			url = "redirect:/login/login";
		} else {
			// 부가 정보는 null일시 디폴트값이 정해져있으므로 null값이면 안되는 유저전화번호만 체크한다.
			if (userVO.getUsrPhone() == null) {
				rtts.addFlashAttribute("msg", "핸드폰 번호가 입력되지 않았어요!");
				url = "redirect:/mypage/auth_edit/";
			}

			// 1. edit에서 UserVO의 정보들을 보낸것을 통하여 업데이트가 필요한 테이블들을 업데이트
			if (service.updateUserTotalInfo(userVO) != 2) {
				rtts.addFlashAttribute("msg", "회원정보가 업데이트 되지 않았습니다!");
				url = "redirect:/mypage/auth_edit/";
			} else
				rtts.addFlashAttribute("msg", "회원정보가 업데이트 되었습니다.");
		}
		return url;
	}

	// 비밀번호 변경 페이지
	@GetMapping("/password")
	public String password(Authentication auth) {
		String url = "/mypage/password";

		// 0. 만일 로그인이 되어 있지 않은데 주소로 이곳을 접속하려고하면, login page로 redirect시켜버림
		log.info("##/password");
		if (auth == null) {
			url = "redirect:/login/login";
		}
		return url;
	}

	// 비밀번호 변경 유효성검사
	// password페이지에서 현재비밀번호와 새로운 비밀번호를 가져온다.
	@PostMapping("/passwordAction")
	public String passwordAction(Authentication auth, @RequestParam("newPassword") String newPassword,
			@RequestParam("currentPassword") String currentPassword, RedirectAttributes rtts) {

		String url = "";
		// 0. 만일 로그인이 되어 있지 않은데 주소로 이곳을 접속하려고하면, login page로 redirect시켜버림
		log.info("##/passwordAction");
		if (auth == null) {
			url = "redirect:/login/login";
		} else {
			// 1. DB에 있는 비밀번호와 사용자가 입력한 비밀번호를 비교하기위해 Authencication에 저장된 usrId를 이용하여 유저 정보를 가져옴.
			CustomUser customUser = (CustomUser) auth.getPrincipal();
			UserVO userVO = service.getUser(customUser.getUser().getUsrId());

			// 2. 비밀번호 유효성검사, 가져온 유저정보의 비밀번호와 비교하여 유효성검사.
			// 2-1 맞으면 유저정보에 비밀번호를 업데이트하고 마이페이지 메인으로 보냄
			if (service.isPwdValid(newPassword) && service.isPwdValid(currentPassword)
					&& service.comparePwdDB(currentPassword, userVO.getUsrPwd())) {
				
				userVO.setUsrPwd(newPassword);
				
				if(service.updateUserInfo(userVO) == 1) {
					rtts.addFlashAttribute("msg", "비밀번호가 수정되었습니다.");
					url = "redirect:/mypage/main";
				}else {
					rtts.addFlashAttribute("msg", "비밀번호 수정에 실패했습니다");
					userVO.setUsrPwd(currentPassword);
					url = "redirect:/mypage/main";
				}
				
				
			} else {
				// 2-2 만일 유효성검사에 실패하면 password변경페이지로 보내버림
				rtts.addFlashAttribute("msg", "비밀번호가 틀렸어요.");
				url = "redirect:/mypage/password";
			}
		}
		return url;
	}

	// 회원탈퇴 비밀번호 입력페이지
	@GetMapping("/auth_leave")
	public String auth_leave(Authentication auth) {

		String url = "/mypage/auth_leave";
		// 0. 만일 로그인이 되어 있지 않은데 주소로 이곳을 접속하려고하면, login page로 redirect시켜버림
		log.info("##/auth_leave");
		if (auth == null) {
			url = "redirect:/login/login";
		}
		return url;
	}

	// 탈퇴하면 유저 상태를 사이트탈퇴로 바꾸고 main이나 login 페이지로 이동하게
	// if else 들을 삼항연산자로 변환??
	@GetMapping("/leaveAction")
	public String leaveAction(Authentication auth, @RequestParam("password") String password, Model model,
			RedirectAttributes rtts) {

		// 0. 만일 로그인이 되어 있지 않은데 주소로 이곳을 접속하려고하면, login page로 redirect시켜버림
		// postmapping이라 필요한지는 모르겠는데 일단 넣어둠
		String url = "/mypage/auth_leave";
		log.info("##/leaveAction");
		if (auth == null) {
			url = "redirect:/login/login";
		} else {
			CustomUser customUser = (CustomUser) auth.getPrincipal();
			UserVO userVO = service.getUser(customUser.getUser().getUsrId());
			// 1.비밀번호 유효성검사
			if (service.isPwdValid(password) && service.comparePwdDB(password, userVO.getUsrPwd())) {
				userVO.setUsrState("사이트탈퇴");
				// 비밀번호 유효성검사에서 통과했는데 탈퇴가 안될 수 있는 케이스
				if (service.leaveUser(userVO) == 3) {
					url = "redirect:/login/logout";
				} else {
					rtts.addFlashAttribute("msg", "회원탈퇴 실패했습니다!");
					userVO.setUsrState("회원");
					url = "redirect:/mypage/auth_leave";
				}
				// 1-1. 비밀번호 틀렸을때
			} else {
				rtts.addFlashAttribute("msg", "비밀번호가 맞지 않아요");
				url = "redirect:/mypage/auth_leave";
			}
		}

		return url;
	}



////	// ajax로 내가 가입한 클럽 리스트 db 가져옴
//	@RequestMapping(value = "/myclub/joinclub/{cbNum}", produces = { MediaType.TEXT_XML_VALUE,
//			MediaType.APPLICATION_JSON_UTF8_VALUE })
//	public ResponseEntity<ClubVO> getJoinClub(@PathVariable("cbNum") Long cbNum, Authentication auth) {
//		log.info("get...........: " + cbNum);
//		CustomUser customUser = (CustomUser) auth.getPrincipal();
//		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
//		return new ResponseEntity<>(service.getJoinClub(cbNum), HttpStatus.OK);
//	}
//	
//	// ajax로 내가 만든 모임을 가져옴
//	@RequestMapping(value = "/myclub/createclub/{cbLeaderNum}",` produces = { MediaType.TEXT_XML_VALUE,
//			MediaType.APPLICATION_JSON_UTF8_VALUE })
//	public ResponseEntity<List<ClubVO>> getMyCreateClubList(@PathVariable("cbLeaderNum") Long cbLeaderNum,
//			Authentication auth) {
//		log.info("get...........: " + cbLeaderNum);
//		CustomUser customUser = (CustomUser) auth.getPrincipal();
//		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
//		return new ResponseEntity<>(service.getMyCreateClubList(userVO.getUsrNum()), HttpStatus.OK);
//	}
//
//	// 굳이 ajax쓸 필요없어보이긴함. model로 리스트 담아서 스크립트단에서 처리하는 방법으로 바꿀것
//	// 굳이 ajax쓸 필요없어보이긴함. model로 리스트 담아서 스크립트단에서 처리하는 방법으로 바꿀것
//
//
//	// ajax로 카테고리 db 가져옴
//	@RequestMapping(value = "/categorylist/{catClassificationCode}", produces = { MediaType.TEXT_XML_VALUE,
//			MediaType.APPLICATION_JSON_UTF8_VALUE })
//	public ResponseEntity<List<CategoryVO>> getCategorylist(
//			@PathVariable("catClassificationCode") String catClassificationCode, Principal principal) {
//		log.info("get...........: " + catClassificationCode);
//
//		return new ResponseEntity<>(service.getCategoryList(catClassificationCode), HttpStatus.OK);
//	}
//
//	// ajax로 citylist 가져옴
//	@RequestMapping(value = "/citylist/", produces = { MediaType.TEXT_XML_VALUE,
//			MediaType.APPLICATION_JSON_UTF8_VALUE })
//	public ResponseEntity<List<RegionVO>> getCitylist(Authentication auth) {
//		log.info("get...........: ");
//		CustomUser customUser = (CustomUser) auth.getPrincipal();
////		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
//		return new ResponseEntity<>(service.getCityList(), HttpStatus.OK);
//	}
//
//	// ajax로 districtlist 가져옴
//	@RequestMapping(value = "/districtlist/{rgName}", produces = { MediaType.TEXT_XML_VALUE,
//			MediaType.APPLICATION_JSON_UTF8_VALUE })
//	public ResponseEntity<List<RegionVO>> getDistrictlist(@PathVariable("rgName") String rgName, Authentication auth) {
//		log.info("get...........: " + rgName);
//		CustomUser customUser = (CustomUser) auth.getPrincipal();
////		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
//		return new ResponseEntity<>(service.getDistrictList(rgName), HttpStatus.OK);
//	}
}