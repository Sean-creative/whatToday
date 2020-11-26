package com.hobby.mapper;
/**
 * 작성자: 김선우
 */
import java.util.List;

import com.hobby.domain.ThunderVO;
import com.hobby.domain.Criteria;

public interface ThunderMapper {
	
	public List<ThunderVO> getList();
	
	public List<ThunderVO> getListWithPaging(Criteria cri);
	
	public void insert(ThunderVO clubVO);	
	
	public ThunderVO read(long cbNum);			
	
	public int getTotalCount(Criteria cri);
			
	public int delete(long cbNum);
	
	public int update(ThunderVO clubVO);
	
}
