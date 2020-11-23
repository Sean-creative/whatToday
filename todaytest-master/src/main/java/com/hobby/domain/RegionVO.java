package com.hobby.domain;

import lombok.Data;

@Data
public class RegionVO {

	private String rgCode;
	private String rgName;
	private String rgClassificationCode;
	private String rgClassificationName;
	private int rgSortOrder;
	private String rgUsageStatus;
	
}
