package com.swarthyPig.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.swarthyPig.domain.PageMaker;
import com.swarthyPig.domain.ReplyPageDTO;
import com.swarthyPig.domain.ReplyVO;
import com.swarthyPig.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/reply")
@RestController // controller가 REST방식을 처리하기 위함을 명시
@Log4j
@AllArgsConstructor
public class ReplyController {
	
	private ReplyService service;
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/newReply", // 등록 URL
			consumes ="application/json", // POST를 수행시 Data를 전달할 때 JSON타입으로 전달 하고 싶을 때 
			produces = {MediaType.TEXT_PLAIN_VALUE}) // 요청/응답 미디어 타입
	// ResponseEntity : 원하는 헤더 정보나 데이터를 전달 할 수 있다. 데이터와 함께 HTTP 헤더의 상태 메세지 등을 같이 전달하는 용도
	// @RequestBody : 전달된 요청의 내용을 이용해서 해당 파라미터의 타입으로 변환을 요구, json데이터를 원하는 타입으로 바인딩 처리
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){ // 댓글 등록
		
		log.info("ReplyVO: " + vo);
		
		int insertCheck = service.register(vo);
		
		log.info("insert Check -> " + insertCheck);
		
		return insertCheck == 1 // 댓글 등록 성공하면 1을 반환(내부적으로 ReplyServiceImpl호출 -> register()호출 -> 댓글이 추가된 숫자를 확인)
		? new ResponseEntity<>("success", HttpStatus.OK) // 성공, 문자열을 반환
		: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); // 실패(500에러 반환)
	}
	
	@GetMapping(value = "/{rno}",
			produces = {MediaType.APPLICATION_XML_VALUE,
						MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) { // 특정 댓글을 조회
		
		log.info("get ->" + rno);
		
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	@GetMapping(value = "/pages/{bno}/{page}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("bno") Long bno, @PathVariable("page") int page){ // 특정 게시물의 댓글목록 조회
		
		log.info("getList->");
		
		PageMaker pm = new PageMaker(page,10); // (pageNum, amount)
		
		log.info("bno : " + bno);
		log.info("pm : " + pm);
		
		return new ResponseEntity<> (service.getListPage(pm, bno), HttpStatus.OK);
	}
	
	@PreAuthorize("(principal.username == #vo.replyer) or (hasRole('ROLE_ADMIN'))")
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
		value = "/{rno}",
		consumes ="application/json")
	// @RequestBody : 전달된 요청의 내용을 이용해서 해당 파라미터의 타입으로 변환을 요구, json데이터를 원하는 타입으로 바인딩 처리
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno){ // 댓글 수정
		
		vo.setRno(rno);
		
		log.info("rno ->" + rno);
		log.info("modify ->" + vo);
		
		return service.modify(vo) == 1
		? new ResponseEntity<>("success", HttpStatus.OK)
		: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
		
	@PreAuthorize("(principal.username == #vo.replyer) or (hasRole('ROLE_ADMIN'))")
	@DeleteMapping(value = "/{rno}") // json타입으로 전송
	public ResponseEntity<String> remove(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno) { // 특정 댓글을 삭제
		
		log.info("remove ->" + rno);
		log.info("replyer : " + vo.getReplyer());
		
		return service.remove(rno) == 1 // 댓글 삭제를 성공하면 1을 반환
		? new ResponseEntity<>("success", HttpStatus.OK) // 성공, 문자열을 반환
		: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); // 실패(500에러 반환)
	}
}
