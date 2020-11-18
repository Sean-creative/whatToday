package com.hobby.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

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
	
	private String keyword;
		
				
	public Criteria() {
		//한번에 5개 정도만 보여준다.
		this(1,5);
		
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
//	public String[] getTypeArr() {			
////		String[] type = {"category", "subclass", "city", "district"};
//		  		 		
//		//일단은 하나라도 NUll이 되지 않도록
//		return keyword == null? new String[] {}: new String[]{"category", "subclass", "city", "district", "keyword"};
//	}
	

	
	  public String getListLink() {	 
	  UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
	  .queryParam("pageNum", this.pageNum) 
	  .queryParam("amount", this.getAmount())
	  .queryParam("category", this.getCategory()) 
	  .queryParam("subclass", this.getSubclass()) 
	  .queryParam("city", this.getCity()) 
	  .queryParam("district", this.getDistrict()) 
	  .queryParam("keyword",this.getKeyword()); 
	  return builder.toUriString(); }
	 
}

