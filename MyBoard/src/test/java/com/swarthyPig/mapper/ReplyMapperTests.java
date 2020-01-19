package com.swarthyPig.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.swarthyPig.domain.PageMaker;
import com.swarthyPig.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	private Long[] bnoArr = { 1L, 2L, 3L, 4L, 5L }; // 1~5번 게시물
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	/*
	@Test
	public void testMapper() { // ReplyMapper 타입의 객체가 정상적으로 사용가능한지 테스트
		log.info(mapper);
	}
	*/
	
	/*
	@Test
	public void testInsert() { // 등록 테스트
		
		IntStream.rangeClosed(1,5).forEach(i -> { // 1,2,3,4,5
			
			ReplyVO vo = new ReplyVO();
			
			vo.setBno(bnoArr[i-1]); // 0, 1, 2, 3, 4
			vo.setReply("댓글 테스트" + i);
			vo.setReplyer("replyer" + i);
			
			mapper.insert(vo);
		});
	}
	*/
	/*
	@Test
	public void testRead() { // 조회 테스트
		Long rno = 5L;
		
		ReplyVO vo = mapper.read(rno);
		
		log.info(vo);
	}
	*/
	/*
	@Test
	public void testUpdate() { // 수정 테스트
		
		Long rno = 4L;
		
		ReplyVO vo = mapper.read(rno); // 읽어와서
		
		vo.setReply("update Reply1"); // 댓글 내용을 변경
		
		mapper.update(vo); // 적용
	}
	*/
	
	/*
	@Test
	public void testDelete() { // 삭제 테스트
		
		Long rno = 5L;
		
		mapper.delete(rno);
	}
	*/
	/*
	@Test
	public void testList() { // 댓글 가져오기
		
		PageMaker pm = new PageMaker();
		
		List<ReplyVO> replies = mapper.getListWithPaging(pm, 1L); // 페이지와 게시글 넘버를 매개변수로 가짐
		
		replies.forEach(reply -> log.info(reply));
	}
	*/
	
	@Test
	public void testListPaging() { // 댓글 페이징 처리 테스트
		
		PageMaker pm = new PageMaker(2,10);
		
		List<ReplyVO> replies= mapper.getListWithPaging(pm, 193L);
		
		replies.forEach( reply -> log.info(reply));
	}
	
	
}
