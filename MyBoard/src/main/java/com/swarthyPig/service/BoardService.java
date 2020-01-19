package com.swarthyPig.service;

import java.util.List;

import com.swarthyPig.domain.BoardVO;
import com.swarthyPig.domain.PageMaker;

public interface BoardService {
	
	public void register(BoardVO board);
	
	public BoardVO get(Long bno); // 특정한 게시물을 가져옴
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
	
	public List<BoardVO> getList(PageMaker pm); // 전체 리스트를 가져옴, pageMaker를 파라미터로 처리
	
	public int getTotal(PageMaker pm); // 게시글의 전체 수를 구함, 목록과 전체 데이터 개수는 항상 같이 동작하므로 PageMaker파라미터 같이 지정 

}
