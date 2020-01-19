package com.swarthyPig.service;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	/*
	@Test
	public void testExist() { // 객체가 제대로 주입이 가능한지 확인
		log.info(service);
		assertNotNull(service); // service 객체가 null이 아님을 확인
	}
	*/
	/*
	@Test
	public void testRegister() { // 등록
		
		BoardVO board = new BoardVO();
		board.setTitle("새글");
		board.setContent("새 내용");
		board.setWriter("admin");
		
		service.register(board);
		
		log.info("추가된 게시물 번호 : " + board.getBno());
	}
	*/
	/*
	@Test
	public void testGetList() { // 게시글 리스트 조회
		service.getList(new pageMaker(2,10).forEach(board -> log.info(board));
	}
	*/
	
	/*
	@Test
	public void testGet() { // 특정 게시글 조회
		log.info(service.get(1L));
	}
	*/
	
	/*
	@Test
	public void testUpdate() {
		
		BoardVO board = service.get(1L); // 먼저 수정할 특정 게시물을 조회함
		
		if (board == null) {
			return;
		}
		
		board.setContent("내용 수정");
		log.info("modify : " + service.modify(board));
	}
	*/
	/*
	@Test 
	public void testDelete() {
		
		log.info("remove ->" + service.remove(2L));
	}
	 */
}
