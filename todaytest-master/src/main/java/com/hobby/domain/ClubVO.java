package com.hobby.domain;


import java.util.Date;

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
	private Date cbMakeDate;
	private Date cbShutDate;
	private String cbFinalState;
	private String cbDetailContent;
	private String cbFile;
	
	///////////////////////////////////////////CLUBMEMBER
	
	
	
	

	private Long usrName;
	private String cbMbStResult;
	private String cbMemIntro;
	private Date cbAppDate;
	
	//////////////////////////////////////////CLUBJOINHISTORY
	
	private Long cbJoinNum;
	private String cbJoingStateResult;
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

	private Date cbBdDate;

	private Long cbBdView;
	
	//CLUBBOARDCONTENT/////////////////////////////////////////////////
	

	private String cbBdContent;
	
	

}
