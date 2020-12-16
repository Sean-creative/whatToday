package com.hobby.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hobby.mapper.PayMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
/***
 * 포인트 결제 - DB연동 인터페이스 구현 클래스
 * @author jiyeong
 *
 */
@Log4j
@Service
public class PayServiceImpl implements PayService{
	
	@Setter(onMethod_ = @Autowired)
	private PayMapper mapper;
	
	@Override
	public boolean pointInsert(Long usrNum, Long usrPoint) {
		// 결제한 포인트 DB에 저장
		System.out.println("usrNum: " + usrNum + ", usrPoint: " + usrPoint);
		return mapper.pointInsert(usrNum, usrPoint) == 1;
	}
	
}
