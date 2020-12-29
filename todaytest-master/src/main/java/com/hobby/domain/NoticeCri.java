package com.hobby.domain;
/**
 * 작성자: 이수진
 */
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeCri{
	private int pageNum;
	private int amount;
	
	//header로 인한 cri 이름이 겹쳐서 -> 임시방편(선우)
	private String keyword;
	
	public NoticeCri() {
		//1페이지에 10개씩 나오게 
		this(1,10);
	}
	
	public NoticeCri(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
