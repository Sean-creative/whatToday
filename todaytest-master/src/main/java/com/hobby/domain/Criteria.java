package com.hobby.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 작성자: 김선우
 */
@Getter
@Setter
@ToString
public class Criteria {
	
	private int pageNum;
	private int amount;
	
	private String category;
	private String subclass;
	private String city;
	private String district;
	
	//searchBy가 어떤거냐에 따라서 쿼리문이 달라져야한다.
	private String searchBy;
	
	private String keyword;
	
	
	private String orderBy;
	private Double userLatitude;
	private Double userLongitude;
		
	
	public Criteria() {
		//한번에 5개 정도만 보여준다.
		this(1,24, "cbNum");		
	}
	
	public Criteria(int pageNum, int amount, String orderBy) {
		this.pageNum = pageNum;
		this.amount = amount;
//		orderBy = new String[]{"cbnum desc", "cbView desc", "cbappperiod desc", "distance"};
		//디폴트로 최신순으로 해놓자.
		this.orderBy = orderBy;
	}
	
	
	  public String getListLink() {	 
      //여러개의 파라미터들을 연결해서 URL 형태로 만들어주는 기능 
	  //URL을 만들어주면 리다이렉트를 하거나, <form> 태그를 사용하는 상황을 많이 줄여줄 수 있다.
	  UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
	  .queryParam("pageNum", this.getPageNum()) 
	  .queryParam("amount", this.getAmount())
	  .queryParam("category", this.getCategory()) 
	  .queryParam("subclass", this.getSubclass()) 
	  .queryParam("city", this.getCity()) 
	  .queryParam("district", this.getDistrict())
	  .queryParam("searchBy", this.getSearchBy())
	  .queryParam("keyword",this.getKeyword())
	  .queryParam("orderBy",this.getOrderBy()); 
	  return builder.toUriString(); }
	 
}

