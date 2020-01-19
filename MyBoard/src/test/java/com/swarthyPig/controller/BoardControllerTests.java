package com.swarthyPig.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration // Servlet의 ServletContext를 이용하기 위함
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml",
"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@Log4j
public class BoardControllerTests { // 매번 톰캣을 실행하지 않고 테스트 함.
	
	@Setter(onMethod_ = {@Autowired})
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before // 모든 테스트 전에 매번 실행되는 메서드
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	/*
	@Test
	public void testList() throws Exception { // 게시글 list 불러오기 테스트
	
		log.info(
			mockMvc.perform(MockMvcRequestBuilders.get("/board/list")) // MockMvcRequestBuilders라는 존재를 이용해서 get방식의 호출을 함.
			.andReturn()
			.getModelAndView()
			.getModelMap()); // 이후에 BoardController의 getList()에서 반환된 결과를 이용하여 Model에 어떤 데이터들이 담겨있는지 확인함.
	}
	*/
	
	/*
	@Test
	public void testRegister() throws Exception{ // 등록 테스트
		
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
				.param("title", "등록 테스트 제목")
				.param("content","등록 테스트 내용")
				.param("writer", "admin")
				).andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	*/
	
	/*
	@Test
	public void testGet() throws Exception { // 게시글 조회 테스트
		
		log.info(
			mockMvc.perform(MockMvcRequestBuilders
				.get("/board/get")
				.param("bno", "12")) // 해당 게시물을 조회할때 bno가 필요하므로 전달.
				.andReturn()
				.getModelAndView().getModelMap());
	}
	*/
	
	/*
	@Test
	public void testModify() throws Exception { // 게시글 수정 테스트
		
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/modify")
				.param("bno", "6")
				.param("title", "수정 테스트 제목")
				.param("content","수정 테스트 내용")
				.param("writer", "admin"))
				.andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	*/
	/*
	@Test
	public void testRemove() throws Exception {
		
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
				.param("bno", "7"))
				.andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	*/
	
	@Test
	public void testListPaging() throws Exception {
		
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/list")
				.param("pageNum", "2")
				.param("amount", "10"))
				.andReturn().getModelAndView().getModelMap());
	}
}
 