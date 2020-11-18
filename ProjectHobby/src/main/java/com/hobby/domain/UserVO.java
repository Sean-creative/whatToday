package com.hobby.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class UserVO {
	
    private Long usrNum;
    private String usrClassification;
    private String usrId;
    private String usrPwd;
    private String usrName;
    private String usrPhone;
    private String usrGender;
    private Date usrBirth;
    private Date usrJoinDate;
    // 회원가입 유형
    private String usrType;
    // 회원상태
    private String usrState;
    private Date usrLoginDate;
    private String usrImg;
    private Date usrChangePwdDate;
    
    private List<AuthVO> authList;
    
    //userdetail
    private String usrCity1;
    private String usrDistrict1;
    private String usrCity2;
    private String usrDistrict2;
    private String usrCategory1;
    private String usrCategory2;
    
    //userterms
    private String usrTerm;            
    private String usrPersonalTerm;  
    private String usrEmailTerm;
    
    //userhistory
    private Long usrHistroyNum;
    private Date usrStateUpdateDate;
    
    
    
    
}
