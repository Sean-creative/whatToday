package com.hobby.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class UserVO {
	
	// tbluser테이블
	// 회원번호 
    private Long usrNum;
    // 회원구분 (일반회원 or 운영자)
    private String usrClassification;
    // 아이디(=이메일)
    private String usrId;
    // 비밀번호
    private String usrPwd;
    // 이름
    private String usrName;
    // 휴대전화 번호
    private String usrPhone;
    // 성별
    private String usrGender;
    // 생년월일
    private String usrBirth;
    // 회원가입 일시
    private String usrJoinDate;
    // 회원가입 유형
    private String usrType;
    // 회원상태
    private String usrState;
    // 접속일
    private String usrLoginDate;
    // 이미지
    private String usrImg;
    // 비밀번호 변경일자
    private String usrChangePwdDate;
    // 회원 권한 리스트
    private List<AuthVO> authList;
    
    //userdetail 테이블
    // 관심지역1
    private String usrCity1;
    // 관심지역1_세부지역
    private String usrDistrict1;
    // 관심지역2
    private String usrCity2;
    // 관심지역2_세부지역
    private String usrDistrict2;
    // 관심분야1
    private String usrCategory1;
    // 관심분야2
    private String usrCategory2;
    
    //userterms 테이블
    // 이용약관 동의 여부
    private String usrTerm; 
    // 개인정보 동의 여뷰
    private String usrPersonalTerm;  
    // 이메일 수신 여부
    private String usrEmailTerm;
    
    //userhistory 테이블
    // 일련 번호
    private Long usrHistoryNum;
    // 상태변경날짜
    private Date usrStateUpdateDate;
    
    
    
    
}
