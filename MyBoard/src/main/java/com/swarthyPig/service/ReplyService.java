package com.swarthyPig.service;

import java.util.List;

import com.swarthyPig.domain.PageMaker;
import com.swarthyPig.domain.ReplyPageDTO;
import com.swarthyPig.domain.ReplyVO;

public interface ReplyService {
	
	public int register(ReplyVO vo); // 댓글 등록
	
	public ReplyVO get(Long rno); // 특정 댓글을 가져옴
	
	public int modify(ReplyVO vo); // 댓글 수정
	
	public int remove(Long rno); // 댓글 삭제
	
	public List<ReplyVO> getList(PageMaker pm, Long bno); // 해당 댓글 페이지의 댓글을 가져옴
	
	public ReplyPageDTO getListPage(PageMaker pm, Long bno); //ReplyPageDTO를 반환함
}
