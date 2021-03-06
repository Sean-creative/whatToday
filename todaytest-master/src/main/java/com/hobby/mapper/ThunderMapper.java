package com.hobby.mapper;
import java.util.HashMap;
/**
 * 작성자: 김선우
 */
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hobby.domain.ClubMemberVO;
import com.hobby.domain.Criteria;
import com.hobby.domain.ThunderVO;
import com.hobby.domain.UserVO;

public interface ThunderMapper {
		
	
	public List<ThunderVO> getListWithPaging(Criteria cri);
	
	public int insert(ThunderVO clubVO);	
	
	//번개모임에 가입 (clubmember-in, clubjoinhistory-in)
	public int insertJoin(@Param("clubVO") ThunderVO clubVO, @Param("loginUser") UserVO loginUser, @Param("joinState") String joinState);
	
	public int updateJoin(@Param("clubVO") ThunderVO clubVO, @Param("loginUser") UserVO loginUser, @Param("joinState") String joinState);
	
	public int insertJoinHistory(@Param("clubVO") ThunderVO clubVO, @Param("loginUser") UserVO loginUser, @Param("joinState") String joinState);
		
	
	//로그인된 유저의 번호로, 지금 가입하려고하는 모임이 가입되어 있는지 상태를 조사
	//반환값은 cbmbstresult
	public String readCbMemByUsrNum(@Param("usrNum") Long usrNum, @Param("cbNum") Long cbNum);
	
	public  List<ClubMemberVO> getJoinList(@Param("cbnum") Long cbnum, @Param("cbmbstresult") String cbmbstresult);
	
	public ThunderVO read(Long cbNum);			
	
	
	public int getTotalCount(Criteria cri);
			
	public int delete(Long cbNum);
	
	public int update(ThunderVO clubVO);
	
	
	//모임 클릭 시 조회수 올라감
	public void clubViews(Long cbNum);
	
	// 현재시간이 지나면 해당 모임을 '폐쇄'로 바꾼다.
	public void updateFinalState();
	
	
	// 좋아요가 눌렸는지 조사!!
	public HashMap readLike(@Param("usrNum") Long usrNum, @Param("cbNum") Long cbNum);
	
	public int insertLikeBtn(@Param("usrNum") Long usrNum, @Param("cbNum") Long cbNum);		
	public int updateLikeCheck(@Param("usrNum") Long usrNum, @Param("cbNum") Long cbNum);
	public int updateLikeCheck1(@Param("usrNum") Long usrNum, @Param("cbNum") Long cbNum);
	
	
	
	
		
	
	
}
