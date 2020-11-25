package com.hobby.exception;
/**
 * 에러 페이지 관리
 * @author jiyeong
 */
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {

	// error메시지를 브라우저 화면에서 확인 할 수 있음.
//	@ExceptionHandler 
//	public String except(Exception ex, Model model) {
//		log.error("Excption", ex);
//		model.addAttribute("exception" ,ex);
//		log.error(model);
//		return "/error/error_page";
//	}
	
	// 페이지가 존재하지 않을 경우 메인페이지가는 링크가 있는 페이지를 보여줌
	@ExceptionHandler(NoHandlerFoundException.class) 
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404() {
		return"/error/custom404";
	}
	
	// DB와 관련된 에러
	@ExceptionHandler
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	public String handle500(Exception ex) {
		log.error("##INTERNAL_SERVER_ERROR : ", ex);
		return"/error/custom500";
	}
}