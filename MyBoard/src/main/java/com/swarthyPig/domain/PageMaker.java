package com.swarthyPig.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class PageMaker {
	
	private int pageNum; // 페이지 수
	private int amount; // 한 페이지에 보일 게시글 수
	
	private String searchType;
	private String searchKeyword;
	
	public PageMaker() { // 기본 한페이지에 게시글 10개
		this(1,10);
	}
	
	public PageMaker(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() { // 검색 조건을 배열로 만들어서 처리
		
		return searchType == null? new String[] {} : searchType.split(""); // type이 비어있으면 빈 객체를 전달하고 아니면 각 type별로 자른 데이터를 담은 객체를 반환
	}
	
	public String getListLink() { // 웹페이지에서 매번 파라미터를 유지하는 것을 편리하게 하기위함
		
		UriComponentsBuilder builder  = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("searchType", this.getSearchType())
				.queryParam("searchKeyword", this.getSearchKeyword());
		
		return builder.toUriString();
	}
}
