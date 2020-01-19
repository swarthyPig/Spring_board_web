package com.swarthyPig.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage; // 화면에서 보여지는 페이지의 시작 번호
	private int endPage; // 화면에서 보여지는 페이지의 끝 번호
	private boolean prev, next; // 이전, 다음
	
	private int total;
	private PageMaker pm;
	
	public PageDTO(PageMaker pm, int total) {
		
		this.pm = pm;
		this.total = total;
		
		this.endPage = (int) (Math.ceil(pm.getPageNum() / 10.0)) * 10; // 페이지의 끝 번호 부터 구함
		this.startPage = this.endPage - 9; // 시작번호는 끝 번호 -9
		
		int realEnd = (int) (Math.ceil((total * 1.0) / pm.getAmount())); // 데이터의 전체 수를 사용해서 진짜 끝페이지가 몇번 까지인지 구함
		
		if(realEnd < this.endPage) { // 진짜 끝페이지가 구해둔 끝 번호 보다 작다면
			this.endPage = realEnd; // 끝페이지를 수정해줌.
		}
		
		this.prev = this.startPage > 1; // 이전번호는 시작번호가 1보다 크면 생성
		this.next = this.endPage < realEnd; // 진짜 끝번호가 구해놓은 끝번호보다 큰 경우에만 생성
	}
}
