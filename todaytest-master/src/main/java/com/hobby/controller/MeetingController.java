package com.hobby.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hobby.domain.MeetingVO;
import com.hobby.service.MeetingService;

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
//		Authentication auth
		public String registerClub(Model model, @ModelAttribute("cbNum") Long cbNum, @ModelAttribute("cbName") String cbName) {
			
			log.info("/add(GET)");
//			log.info("/add(GET) - cri : " + cri);

			// 로그인을 하면 Authentication을 통해 회원 정보를 가져온다.
//			CustomUser customUser = (CustomUser) auth.getPrincipal();
//			UserVO userVO = customUser.getUser();
//			
//			model.addAttribute("usrName", userVO.getUsrName());
//			model.addAttribute("usrNum", userVO.getUsrNum());
//
//			log.info("##/add 회원번호는 :" + userVO.getUsrNum());
//			log.info("##/add 회원이름는 :" + userVO.getUsrName());

			return "/meeting/add";
		}
		
		
	@PostMapping("/add")
	//Authentication auth,
	public String registerClub(MeetingVO meeting, RedirectAttributes rttr) {

		log.info("/add(POST) - meeting : " + meeting);
		
		service.register(meeting);
		
		
		rttr.addAttribute("cbNum", meeting.getCbNum());

		return "redirect:/regular/info";
	}

	
//	
//
//	// 정기모임 목록
//	@GetMapping("/list")
//	public void clublist(Criteria cri, Model model) {
//
//		log.info("clublist");
//		log.info("list - cri : " + cri);
//
//		// cri에 들어있는 조건 대로, club 정보를 가져온다.
//		model.addAttribute("clublist", service.getList(cri));
//
//		log.info("list : " + service.getList(cri));
//
//		// cri에 들어있는 조건 대로, 가져올 수 있는 club의 개수를 체크한다.
//		int total = service.getTotal(cri);
//		log.info("list - total : " + total);
//
//		model.addAttribute("pageMaker", new PageDTO(cri, total));
//
//		// 파라미터 model을 통해 clubserviceImpl 객체의 getClubList 결과를 담아 전달 한다.
//		// model.addAttribute("clublist", service.getClubList());
//	}
//
//	// 정기모임 상세정보
//	@GetMapping("/info")
//	public void getClub(Authentication auth, @RequestParam("cbNum") Long cbNum, Model model) {
//
//		UserVO userVO;
//
//		if (auth != null) {
//			CustomUser customUser = (CustomUser) auth.getPrincipal();
//			userVO = customUser.getUser();
//			LocalDate onlyDate = LocalDate.now();
//			// 파라미터 model을 통해 회원번호와 회원이름을 결과에 담아 전달 한다.
//			model.addAttribute("usrName", userVO.getUsrName());
//			model.addAttribute("toDate", onlyDate);
//
//			log.info("###usrnum:" + userVO);
//			
//			
//			String joinState = service.getCbMemByUsrNum(userVO.getUsrNum(), cbNum);
//			log.info("/info(GET) - joinState : " + joinState); // ** - 모임추방, 모임만료, 모임탈퇴, 가입승인, Null (아직 데이터 넣기 전)
//			model.addAttribute("joinState", joinState);
//
//			model.addAttribute("usrNum", userVO.getUsrNum());
//
//			//해당 클럽에서 가입승인 사람의 리스트를 가져온다. -> 뷰단에서 가입중인 모임원을 보여줄 수 있다.
//			List<ClubMemberVO> joinList = service.getJoinList(cbNum, "가입승인");			            
//			for (ClubMemberVO club : joinList) {
//				log.info("/info(GET) - joinList : " + club);				
//			}
//
//			model.addAttribute("joinList", joinList);
//		}
//
//		log.info("/info");
//		// 화면쪽으로 해당 모임번호의 정보를 전달하기위해 model에 담는다.
//		model.addAttribute("club", service.getClub(cbNum));
//	}
//
//
//	// 정기모임 가입
//	@PostMapping("/clubjoin")
//	public String clubJoin(Authentication auth, ClubVO club, RedirectAttributes rttr) {
//
//		CustomUser customUser = (CustomUser) auth.getPrincipal();
//		UserVO userVO = customUser.getUser();
//
//		String joinState = service.getCbMemByUsrNum(userVO.getUsrNum(), club.getCbNum());
//		log.info("/clubjoin(POST) - joinState : " + joinState); // joinState - 모임추방, 모임만료, 모임탈퇴, 가입승인, Null (아직 데이터 넣기 전)
//		
//		log.info(service.join(club, userVO, joinState));
//
//		rttr.addFlashAttribute("usrName", userVO.getUsrName());
//		rttr.addFlashAttribute("usrNum", userVO.getUsrNum());
//		rttr.addFlashAttribute("cbType", club.getCbType());
//		rttr.addFlashAttribute("cbName", club.getCbName());
//		// 일회성으로 데이터를 전달하는 용도 (전달된 값은 url뒤에 붙지 않는다.)
//		rttr.addFlashAttribute("cbNum", club.getCbNum());
//
//		log.info("##/add 회원번호는 :" + userVO.getUsrNum());
//		log.info("##/add 회원이름는 :" + userVO.getUsrName());
//		log.info("###clubjoin: " + club);
//
//		return "redirect:/index/main";
//	}

}