package com.swarthyPig.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.swarthyPig.domain.BoardVO;
import com.swarthyPig.domain.PageMaker;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	/*
	@Test
	public void testGetList() { // 게시글의 전체 list 출력 테스트 
		mapper.getList().forEach(board -> log.info(board));
	}
	*/
	/*
	@Test
	public void testInsert() { // 새로운 게시글 등록 테스트 -> id="insert"
		
		BoardVO board = new BoardVO();
		board.setTitle("새글");
		board.setContent("새 내용");
		board.setWriter("admin");
		
		mapper.insert(board);
		
		log.info(board);
	}
	*/
	/*
	@Test
	public void testInsertSelectKey() { // 새로운 게시글 등록 테스트 -> id="insertSelectKey"
		
		BoardVO board = new BoardVO();
		board.setTitle("새글 select key");
		board.setContent("새 내용 select key");
		board.setWriter("admin");
		
		mapper.insertSelectKey(board);
		
		log.info(board);
	}
	*/
	/*
	@Test
	public void testRead() { // 특정 게시글의 내용 확인 -> 테이블에 존재하는 bno 칼럼의 값을 이용
		
		BoardVO board = mapper.read(5L);
		
		log.info(board);
	}
	*/
	/*
	@Test
	public void testDelete() { // 특정 게시글의 삭제(bno사용) 삭제되면 1이상의값 반환, 해당 bno게시글이 없으면 0반환
		log.info("DELETE COUNT: " + mapper.delete(3L));
	}
	*/
	
	/*
	@Test
	public void testUpdate() { // read를 통해서 가져온 BoardVO객체의 일부를 수정하는 방식이나 직접 BoardVO객체를 생성해서 처리함
		
		BoardVO board = new BoardVO();
		
		board.setBno(5L);
		board.setTitle("수정된 제목");
		board.setContent("수정된 내용");
		board.setWriter("admin");
		
		int count = mapper.update(board);
		
		log.info("UPDATE COUNT: " + count);
	}
	*/
	
	/*
	@Test
	public void testPaging() { // 페이징 처리 테스트
		PageMaker pm = new PageMaker();
		// 10개씩 2페이지
		pm.setPageNum(2);
		pm.setAmount(10);
		
		List<BoardVO> list = mapper.getListWithPaging(pm);
		
		list.forEach(board -> log.info(board));
	}
	*/
	
	@Test
	public void testSearch() { // 검색 sql 테스트
		PageMaker pm = new PageMaker();
		pm.setSearchType("TC"); // 제목과 내용
		pm.setSearchKeyword("null"); // 제목과 내용에 null이라는 단어가 있는 경우
		
		List<BoardVO> list = mapper.getListWithPaging(pm);
		
		list.forEach(board -> log.info(board));
	}
}
