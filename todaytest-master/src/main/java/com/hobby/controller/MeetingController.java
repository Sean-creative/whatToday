package com.hobby.controller;

import java.io.File;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hobby.domain.Criteria;
import com.hobby.domain.MeetingVO;
import com.hobby.domain.ThunderVO;
import com.hobby.domain.UserVO;
import com.hobby.security.domain.CustomUser;
import com.hobby.service.MeetingService;
import com.hobby.utils.UploadFileUtils;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/meeting/*")
@AllArgsConstructor
public class MeetingController {

	private MeetingService service;

// 만남을 개설 할 떄는, cbNum만 있으면 된다. 		 
	@GetMapping("/add")
	public String registerClub(Authentication auth, Model model, @ModelAttribute("cbNum") Long cbNum, @ModelAttribute("cbName") String cbName) {

		// 로그인 체크를 해서, 로그인이 안되어 있으면 로그인 페이지로 보낸다.
		if (auth == null)
			return "redirect:/login/login";

		log.info("/add(GET)");
		log.info("/add(GET) cbNum : " + cbNum);
		log.info("/add(GET) cbName : " + cbName);

		// 로그인을 하면 Authentication을 통해 회원 정보를 가져온다.
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO loginUser = customUser.getUser();
		model.addAttribute("loginUser", loginUser);

		log.info("/add(GET) userNum : " + loginUser.getUsrNum());
		log.info("/add(GET) userName : " + loginUser.getUsrName());

		return "/meeting/add";
	}
	
	
	
//만남이 개설 되는 것 
	@PostMapping("/add")
	public String registerClub(Authentication auth, MeetingVO meeting, RedirectAttributes rttr) {

		log.info("/add(POST) - meeting : " + meeting);

		service.register(meeting);

		rttr.addAttribute("cbNum", meeting.getCbNum());

		return "redirect:/regular/info";
	}


	
	@GetMapping("/modify")
	public String modify(Authentication auth, Long cbNum, Long mtNum, Model model) {
		// 로그인 체크를 해서, 로그인이 안되어 있으면 로그인 페이지로 보낸다.
		if (auth == null)
			return "redirect:/login/login";

		// 들어온 파라미터 값 확인
		log.info("/modify(GET) - cbNum : " + cbNum);
		log.info("/modify(GET) - mtNum : " + mtNum);

		// 유저정보를 가져와서, 개설자 번호와 현재 로그인된 사람의 Key가 일치하는지 봐야한다.
//		CustomUser customUser = (CustomUser) auth.getPrincipal();
//		UserVO loginUser = customUser.getUser();
//		log.info("/modify(GET) - 로그인 한 유저의 Num : " + loginUser.getUsrNum());

		MeetingVO meeting = service.getMeeting(mtNum);
		log.info("/modify(GET)- meeting : " + meeting);
				
		model.addAttribute("meeting", meeting);
		
		return "/meeting/modify";
	}
	
	
	@PostMapping("/modify")
	public String modify(MeetingVO meeting,RedirectAttributes rttr) {

		log.info("modify(POST) - meeting " + meeting);
			

		if (service.modify(meeting)) {
			// 모달창으로 수정이되거나 삭제되면 버튼이 구현되면, 사용할 메세지
			rttr.addFlashAttribute("result", "모임 정보가 수정되었습니다..");
		} else {
			rttr.addFlashAttribute("result", "모임 정보가 수정되지 않았습니다.");
		}

		return "redirect:/regular/list";
	}
	
	
	
	@PostMapping("/remove")
	public String remove(Long mtNum, RedirectAttributes rttr) {
		log.info("/remove(POST) - mtNum : " + mtNum);

		if (service.remove(mtNum)) {
			// 모달창으로 수정이되거나 삭제되면 버튼이 구현되면, 사용할 메세지
			rttr.addFlashAttribute("result", "모임 정보가 삭제되었습니다.");
		} else {
			rttr.addFlashAttribute("result", "모임 정보가 삭제되지 않았습니다.");
		}
		
		return "redirect:/regular/list";
	}
	
	
	
	
	
	
	// 만남에 참석하는 것 
	@PostMapping("/join")
	public String join(Authentication auth, Long mtNum, RedirectAttributes rttr) {

		// 로그인 체크를 해서, 로그인이 안되어 있으면 로그인 페이지로 보낸다.
		if (auth == null)
			return "redirect:/login/login";
		log.info("/join(POST) - mtNum : " + mtNum);

		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO loginUser = customUser.getUser();
		log.info("/join(POST) -loginUser : " + loginUser);

				
		
		// 1.regular - info에서 참석하기를 누르면, mtNum만 받아와서 get 하는걸로!!
		// (info에서 input 다 써주는것 보다 효율적일듯)
		MeetingVO meeting = service.getMeeting(mtNum);
		log.info("/join(POST) - MeetingVO : " + meeting);

		//	로그인한 유저를 기준으로 해당 모임의, 만남에 대한 상태를 넣어준다.
		String mtAttendState = service.getMtStateByUsrNum(loginUser.getUsrNum(), meeting.getCbNum(), mtNum);
		log.info("/join(POST) - mtAttendState : " + mtAttendState);

		// join메서드에 주어야 하는 것 -> 1.loginUser 2.meeting 3.mtAttendState
				
		if (service.attend(meeting, loginUser, mtAttendState)) {
			// 모달창으로 신청되었는지 알려줘야함!!
			rttr.addFlashAttribute("result", "처리되었습니다.");
		} else {
			rttr.addFlashAttribute("result", "처리되지 않았습니다.");
		}

		
		
		
		rttr.addAttribute("cbNum", meeting.getCbNum());
		return "redirect:/regular/info";
	}

	
}