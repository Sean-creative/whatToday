package com.hobby.domain;



import lombok.Data;

@Data
public class ClubVO {
	
	private Long cbNum;
	private String cbName;
	private String cbType;
	private Long cbLeaderNum;
	private String cbCategory;
	private String cbSubcat;
	private String cbCity;
	private String cbDistrict;
	private Long cbMbNum;
	private Long cbCurMbNum;
	private String cbHashtag;
	private String cbIntro;
	private String cbMakeDate;
	private String cbShutDate;
	private String cbFinalState;
	private String cbDetailContent;
	private String cbFile;
	
	
	
	///////////////////////////////////////////CLUBMEMBER
	private String usrName;
	private Long usrNum;
	private String cbMbStResult;
	private String cbMemIntro;
	private String cbAppDate;

	private UserVO userVO;
	
	
	
	//////////////////////////////////////////CLUBJOINHISTORY	
	private Long cbJoinNum;
	private String cbJoinStateResult;
	private String cbJoinStateUpdateDate;

	
	/////////////////////////////////////////THUNDERDETAIL
	private String cbDate;
	private String cbAppPeriod;
	private String cbPlace;
	private String cbSupplies;

	
	//CLUB/////////////////////////////////////////////////////////////
	private String cbLeaderName;
	
	
	//CLUBBOARD////////////////////////////////////////////////////////	
	private Long cbBno;
	private String cbBdWriter;
	private String cbBdTitle;
	private String cbBdDate;
	private Long cbBdView;	
	
	private int replyCount;
	
	//CLUBBOARDCONTENT/////////////////////////////////////////////////
	
	//CLUBBOARDCONTENT/////////////////////////////////////////////////	
	private String cbBdContent;
	
	

}
