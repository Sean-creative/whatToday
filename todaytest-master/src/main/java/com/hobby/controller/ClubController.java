package com.hobby.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hobby.domain.ClubMemberVO;
import com.hobby.domain.ClubVO;
import com.hobby.domain.Criteria;
import com.hobby.domain.MeetingVO;
import com.hobby.domain.NoticeCri;
import com.hobby.domain.NoticeDTO;
import com.hobby.domain.PageDTO;
import com.hobby.domain.ReplyVO;
import com.hobby.domain.UserVO;
import com.hobby.security.domain.CustomUser;
import com.hobby.service.ClubService;
import com.hobby.service.MeetingService;
import com.hobby.utils.UploadFileUtils;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/regular/*")
@AllArgsConstructor
public class ClubController {

	private ClubService service;
	private MeetingService meetingservice;
	
//	servlet-context.xml에서 설정했던 uploadPath를 추가
	@Resource(name = "uploadPath")
	private String uploadPath;

	
	// 정기모임 개설
	@PostMapping("/add")
	public String registerClub(Authentication auth, MultipartFile file, ClubVO club, RedirectAttributes rttr) throws Exception {
		// 개설(등록)작업이 완료되면 목록화면으로 이동 및 새로 개설된 모임의 모임번호를 같이 전달하기 위해 Redirect Attributes를
		// 파라미터로 지정
		log.info("/add(POST) - file : " + file);
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload"; // 이미지를 업로드할 폴더를 설정 = /uploadPath/imgUpload
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath); // 위의 폴더를 기준으로 연월일 폴더를 생성
		String fileName = null; // 기본 경로와 별개로 작성되는 경로 + 파일이름

		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			// 파일 인풋박스에 첨부된 파일이 없다면(=첨부된 파일이 이름이 없다면)

			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);

			// file에 원본 파일 경로 + 파일명 저장
			club.setCbFile(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
			// Thumbimg에 썸네일 파일 경로 + 썸네일 파일명 저장
			club.setCbThumbImg(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);

		} else { // 첨부된 파일이 없으면
			fileName = File.separator + "img" + File.separator + "none.png";
			// 미리 준비된 none.png파일을 대신 출력함

			// file에 원본 파일 경로 + 파일명 저장
			club.setCbFile(fileName);
			// Thumbimg에 썸네일 파일 경로 + 썸네일 파일명 저장
			club.setCbThumbImg(fileName);
		}

		

		club.setCbName(club.getCbName().replaceAll("^(\\s|\\.)*|(\\s|\\.)*$", "")); // 유효성검사

		service.registerClub(club);

		// 일회성으로 데이터를 전달하는 용도 (전달된 값은 url뒤에 붙지 않는다.)
		rttr.addFlashAttribute("result", club.getCbNum());

		log.info("registerClub: " + club);
		log.info("##개설된 모임번호는:" + club.getCbNum());

		return "redirect:/regular/list";
	}

	// 정기모임 개설
	@GetMapping("/add")
	@PreAuthorize("isAuthenticated()")
	public String registerClub(Authentication auth, Model model) {

		log.info("register: ");

		// 로그인을 하면 Authentication을 통해 회원 정보를 가져온다.
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = customUser.getUser();

		// 파라미터 model을 통해 회원번호와 회원이름을 결과에 담아 전달 한다.
		model.addAttribute("usrName", userVO.getUsrName());
		model.addAttribute("usrNum", userVO.getUsrNum());

		log.info("##/add 회원번호는 :" + userVO.getUsrNum());
		log.info("##/add 회원이름는 :" + userVO.getUsrName());

		return "/regular/add";
	}

	// 정기모임 목록
	@GetMapping("/list")
	public void clublist(Criteria cri, Model model) {

		log.info("clublist");
		log.info("list - cri : " + cri);

		// cri에 들어있는 조건 대로, club 정보를 가져온다.
		model.addAttribute("clublist", service.getList(cri));

		log.info("list : " + service.getList(cri));

		// cri에 들어있는 조건 대로, 가져올 수 있는 club의 개수를 체크한다.
		int total = service.getTotal(cri);
		log.info("list - total : " + total);

		model.addAttribute("pageMaker", new PageDTO(cri, total));

		// 파라미터 model을 통해 clubserviceImpl 객체의 getClubList 결과를 담아 전달 한다.
		// model.addAttribute("clublist", service.getClubList());
	}

	// 정기모임 상세정보
	@GetMapping("/info")
	public void getClub(Authentication auth, @RequestParam("cbNum") Long cbNum, Model model) {

		UserVO userVO = null;

		if (auth != null) {
			CustomUser customUser = (CustomUser) auth.getPrincipal();
			userVO = customUser.getUser();
			LocalDate onlyDate = LocalDate.now();
			// 파라미터 model을 통해 회원번호와 회원이름을 결과에 담아 전달 한다.
			model.addAttribute("usrName", userVO.getUsrName());
			model.addAttribute("toDate", onlyDate);

			log.info("###usrnum:" + userVO);

			String joinState = service.getCbMemByUsrNum(userVO.getUsrNum(), cbNum);
			log.info("/info(GET) - joinState : " + joinState); // ** - 모임추방, 모임만료, 모임탈퇴, 가입승인, Null (아직 데이터 넣기 전)
			model.addAttribute("joinState", joinState);

			model.addAttribute("usrNum", userVO.getUsrNum());

			
			// 해당 모임에 대한 만남리스트를 가져온다.
			List<MeetingVO> meetingList = meetingservice.getMeetingList(cbNum);
			for (MeetingVO meeting : meetingList) {

				meetingservice.updateMtCurMbNum(meeting);

				// 모임리스트의 각각의 모임에다가, 로그인한 유저를 기준으로 각각의 만남에 대한 상태를 넣어준다.
				String mtAttendState = meetingservice.getMtStateByUsrNum(userVO.getUsrNum(), cbNum, meeting.getMtNum());
				log.info("/info(GET) - mtAttendState : " + mtAttendState);

				meeting.setUsrMtState(mtAttendState);
				log.info("/info(GET) - meetingList : " + meeting);
			}

			model.addAttribute("meetingList", meetingList);
		}

		// 해당 클럽에서 가입승인 사람의 리스트를 가져온다. -> 뷰단에서 가입중인 모임원을 보여줄 수 있다.
		List<ClubMemberVO> joinList = service.getJoinList(cbNum, "가입승인");
		for (ClubMemberVO club : joinList) {
			log.info("/info(GET) - joinList : " + club);
		}
		model.addAttribute("joinList", joinList);

		log.info("/info");
		// 화면쪽으로 해당 모임번호의 정보를 전달하기위해 model에 담는다.
		model.addAttribute("cbNum", cbNum);
		model.addAttribute("club", service.getClub(cbNum));
		
		
		log.info(service.getClub(cbNum));

		// 로그인한유저가 해당 모임에 대해서, 만남참석정보를 가져온다. -> 문제는 만남참석정보가 여러개다..;;

	}

	// 정기모임 게시판 - 목록list
//	@GetMapping("/board")
//	public void list(Model model, @RequestParam("cbNum") Long cbNum) {
//
//		log.info("list");
//		// 파라미터 model을 통해 cbNum과 clubserviceImpl 객체의 getList 결과를 담아 전달 한다.
//		model.addAttribute("cbNum", cbNum);
//		model.addAttribute("list", service.getList(cbNum));
//	}

	// 정기모임 게시판 - 목록list (페이징)
	@GetMapping("/board")
	public void list(@RequestParam("cbNum") Long cbNum, NoticeCri cri, Model model) {

		log.info("#list page cbNum:" + cbNum);
		log.info("#list page :" + cri);

		model.addAttribute("cbNum", cbNum);
		model.addAttribute("list", service.boardgetList(cri, cbNum));
		// model.addAttribute("pageMaker", new NoticeDTO(cri, 123));

		int total = service.boardgetTotal(cri, cbNum);
		log.info("#board total:" + total);
		model.addAttribute("pageMaker", new NoticeDTO(cri, total));
	}

	// 정기모임 게시판 - 조회
	@GetMapping({ "/boardget", "/boardupdate" })
	public void get(@RequestParam("cbBno") Long cbBno, @ModelAttribute("cri") NoticeCri cri, @RequestParam("cbNum") Long cbNum, Model model) {

		log.info("/get or boardupdate");
		// 화면쪽으로 해당 게시물번호의 정보를 전달하기위해 model에 담는다.
		model.addAttribute("cbNum", cbNum);
		model.addAttribute("club", service.get(cbBno));
		model.addAttribute("replyVO", new ReplyVO());
	}

	// 정기모임 게시판 - 등록
	@PostMapping("/boardadd")
	public String boardRegister(ClubVO club, RedirectAttributes rttr) {

		log.info("###boardregister: " + club);

		service.boardRegister(club);

		rttr.addFlashAttribute("result", club.getCbBno());

		return "redirect:/regular/board?cbNum=" + club.getCbNum();
	}

	// 정기모임 게시판 - 등록
	@GetMapping("/boardadd")
	public void boardRegister(Model model, @ModelAttribute("cri") NoticeCri cri, @RequestParam("cbNum") Long cbNum) {

		log.info("#boardRegister");
		// 파라미터 model을 통해 cbNum과 clubserviceImpl 객체의 boardgetList 결과를 담아 전달 한다.
		model.addAttribute("cbNum", cbNum);
		// model.addAttribute("boardRegister", service.getList(cbNum));
		model.addAttribute("boardRegister", service.boardgetList(cri, cbNum));
	}

	// 정기모임 게시판 - 삭제
	@PostMapping("/boarddelete")
	public String boardRemove(ClubVO club, @RequestParam("cbBno") Long cbBno, @ModelAttribute("cri") NoticeCri cri, RedirectAttributes rttr) {

		log.info("boardremove : " + cbBno);

		if (service.boardRemove(cbBno)) {

			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());

		return "redirect:/regular/board?cbNum=" + club.getCbNum();
	}

	// 정기모임 게시판 - 수정
	@PostMapping("/boardupdate")
	public String boardModify(ClubVO club, @ModelAttribute("cri") NoticeCri cri, RedirectAttributes rttr) {

		log.info("boardmodify: " + club);

		if (service.boardModify(club) == 2) {

			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());

		return "redirect:/regular/board?cbNum=" + club.getCbNum();
	}

	// 정기모임 가입
	@GetMapping("/clubjoin")
	@PreAuthorize("isAuthenticated()") // 인증된 사용자면 true
	public String clubJoin(@RequestParam("cbNum") Long cbNum) {

		log.info("###/clubjoin");

		return "redirect:/regular/info?cbNum=" + cbNum;
	}

	// 정기모임 가입
	@PostMapping("/clubjoin")
	public String clubJoin(Authentication auth, ClubVO club, RedirectAttributes rttr) {

		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = customUser.getUser();

		String joinState = service.getCbMemByUsrNum(userVO.getUsrNum(), club.getCbNum());
		log.info("/clubjoin(POST) - joinState : " + joinState); // joinState - 모임추방, 모임만료, 모임탈퇴, 가입승인, Null (아직 데이터 넣기 전)

		log.info(service.join(club, userVO, joinState));

		rttr.addFlashAttribute("usrName", userVO.getUsrName());
		rttr.addFlashAttribute("usrNum", userVO.getUsrNum());
		rttr.addFlashAttribute("cbType", club.getCbType());
		rttr.addFlashAttribute("cbName", club.getCbName());
		// 일회성으로 데이터를 전달하는 용도 (전달된 값은 url뒤에 붙지 않는다.)
		rttr.addFlashAttribute("cbNum", club.getCbNum());

		log.info("##/add 회원번호는 :" + userVO.getUsrNum());
		log.info("##/add 회원이름는 :" + userVO.getUsrName());
		log.info("###clubjoin: " + club);

		return "redirect:/index/main";
	}

	// 정기모임 채팅창 - 지영
//	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/chat", method = RequestMethod.GET)
	public void chat(@RequestParam("cbNum") Long cbNum, Model model) {
		log.info("##/chat");

//		CustomUser customUser = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		String name = customUser.getUser().getUsrName();
//		Long usrNum = customUser.getUser().getUsrNum();

		System.out.println("cbNum: " + cbNum);
//		System.out.println("usrNum: " + usrNum);

//		// 모임에 가입한 사람(+가입승인)만 채팅창 입장버튼을 누를 수 있음. 
//		Long result = service.getCbMember(cbNum, usrNum);
//		System.out.println(result);
//
//		if(result==null) {
//			model.addAttribute("msg", "모임에 가입한 사람만 입장할 수 있습니다.");
//		}else {
//			model.addAttribute("cbNum", cbNum);
//			model.addAttribute("usrName", name);
//		}
		model.addAttribute("cbNum", cbNum);
	}

	// 정기모임 수정
	@GetMapping("/update")
	public void updateClub(@RequestParam("cbNum") Long cbNum, Model model) {
		log.info("##getClub:" + service.getClub(cbNum));
		model.addAttribute("cbNum", cbNum);
		model.addAttribute("club", service.getClub(cbNum));
	}

	@PostMapping("/update")
	public String updateClub(ClubVO club, MultipartFile file, RedirectAttributes rttr) throws Exception {

		log.info("##updateclub:" + club);

		String imgUploadPath = uploadPath + File.separator + "imgUpload"; // 이미지를 업로드할 폴더를 설정 = /uploadPath/imgUpload
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath); // 위의 폴더를 기준으로 연월일 폴더를 생성
		String fileName = null; // 기본 경로와 별개로 작성되는 경로 + 파일이름

		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			// 파일 인풋박스에 첨부된 파일이 있다면

			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);

			// file에 원본 파일 경로 + 파일명 저장
			club.setCbFile(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
			// Thumbimg에 썸네일 파일 경로 + 썸네일 파일명 저장
			club.setCbThumbImg(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);

		}
		// 첨부된 파일이 없으면 기존의것 그대로 가면 됨!!
		if (service.updateClub(club)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/regular/list";
	}

	// 정기모임 삭제(폐쇄)
	@PostMapping("/delete")
	public String deleteClub(@RequestParam("cbNum") Long cbNum, RedirectAttributes rttr) {

		log.info("##delete:" + cbNum);

		if (service.deleteClub(cbNum)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/regular/list";
	}
}