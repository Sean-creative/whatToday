package com.hobby.service;

public interface PayService {
	
	public boolean pointInsert(Long usrNum, Long usrPoint);

	public Long getUserPoint(Long usrNum);
}
