package com.swarthyPig.domain;

import java.util.Date;

import lombok.Data;

@Data // lombok을 사용해서 생성자, getter/setter, toString()등을 자동으로 생성
public class BoardVO {
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;
	
	private int replyCnt;
}
