package com.swarthyPig.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.swarthyPig.domain.BoardVO;
import com.swarthyPig.domain.PageMaker;
import com.swarthyPig.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Service // 주로 비즈니스 영역을 담당하는 객체임을 표시함
@AllArgsConstructor
@Log4j
public class BoardServiceImpl implements BoardService{
	
	private BoardMapper mapper; // spring 4.3 이상에서는 자동 처리

	@Override
	public void register(BoardVO board) { // 등록작업, BoardVO타입의 객체를 BoardMapper를 통해서 처리.

		log.info("register(serviceImpl) -> " + board);
		
		mapper.insertSelectKey(board);
		
	}

	@Override
	public BoardVO get(Long bno) { // 특정 게시글 조회

		log.info("get......." + bno);
		
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) { // 수정, void로 할수 있지만 엄격하게 처리하기위해 boolean타입 사용
		
		log.info("modify -> " + board);
		
		return mapper.update(board) == 1; // 수정이 이루어지면 1이라는 값이 반환됨
	}

	@Override
	public boolean remove(Long bno) { // 삭제, void로 할수 있지만 엄격하게 처리하기위해 boolean타입 사용

		log.info("remove -> " + bno);
		
		return mapper.delete(bno) == 1; // 삭제가 이루어지면 1이라는 값이 반환됨
	}

	@Override
	public List<BoardVO> getList(PageMaker pm) {

		log.info("page Maker -> " + pm);
		
		return mapper.getListWithPaging(pm);
	}

	@Override
	public int getTotal(PageMaker pm) {

		log.info("total count");
		return mapper.getTotalCount(pm);
	}

}
