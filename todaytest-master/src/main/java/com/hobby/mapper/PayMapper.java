package com.hobby.mapper;

import org.apache.ibatis.annotations.Param;

/**
 * 포인트 결제 - DB연동
 * 
 * @author jiyeong
 *
 */
public interface PayMapper {

	public int pointInsert(@Param("usrNum") Long usrNum, @Param("usrPoint") Long usrPoint);
}