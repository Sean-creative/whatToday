package com.hobby.exception;

/**
 * 에러 페이지 관리
 * @author jiyeong
 */
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {

	@ExceptionHandler(Exception.class)
	// Exception.class에 대한 예외처리 메소드
	public String except(Exception ex) {
		log.error("알 수 없는 Excption 발생 : ", ex);
		return "/error/error_page";
	}
	
	// 페이지가 존재하지 않을 경우 메인페이지가는 링크가 있는 페이지를 보여줌
	@ExceptionHandler(NoHandlerFoundException.class)
	// NoHandlerFoundException.class에 대한 예외처리 메소드
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404() {
		log.error("##NOT_FOUND");
		return"/error/custom404";
	}
	
	// DB와 관련된 에러
	@ExceptionHandler(MyBatisSystemException.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	public String handle500(Exception ex) {
		log.error("##INTERNAL_SERVER_ERROR : ", ex);
		return"/error/custom500";
	}
	
}