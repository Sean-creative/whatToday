package com.hobby.domain;

import lombok.Data;

//���Ͼ��ε�� DTD
@Data
public class AttachFileDTO {

	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;
	
}
