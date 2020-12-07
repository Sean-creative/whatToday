package com.hobby.domain;

import lombok.Data;

//파일업로드용 DTD
@Data
public class AttachFileDTO {

	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;
	
}
