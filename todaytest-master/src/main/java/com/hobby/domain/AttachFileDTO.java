package com.hobby.domain;

import lombok.Data;

/**
 * 
 * @author 국민성
 * 파일 첨부 DTO
 */

@Data
public class AttachFileDTO {

	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;
	
}
