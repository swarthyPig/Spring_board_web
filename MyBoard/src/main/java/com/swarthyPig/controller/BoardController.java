package com.swarthyPig.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.swarthyPig.domain.BoardVO;
import com.swarthyPig.domain.PageDTO;
import com.swarthyPig.domain.PageMaker;
import com.swarthyPig.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller // 스프링의 빈으로 인식할 수 있게함.
@RequestMapping("/board/*") // /board로 시작하는 주소를 모두 처리.
@AllArgsConstructor // 생성자를 만들고 자동으로 주입.
@Log4j
public class BoardController { // 해당 controller가 속한 패키지는 servlet-context.xml에 기본으로 설정되어있음
	
	/*
	// 생성자를 만들지 않을경우
	@Setter(onMethod_ = @Autowired) 
	private BoardService service;
	*/
	
	private BoardService service; // BoardController는 BoardService에 대해서 의존적
	
	@GetMapping("/list")
	public void list(PageMaker pm, Model model) { // 전체 목록을 가져옴, 나중에 게시글의 목록을 전달해야 하므로 Model을 파라미터로 지정, jsp에서 list라는 이름으로 인식하여 데이터를 가져옴
		
		log.info("list -> " + pm);
		model.addAttribute("list", service.getList(pm)); // BoardServiceImpl객체의 getList()결과를 담아 전달
		
		int total = service.getTotal(pm);
		log.info("total -> " + total);
		
		model.addAttribute("PageMaker", new PageDTO(pm, total)); // pageMaker라는 이름으로  PageDTO클래스에서 나온 값을 model로 넘겨줌
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()") // 로그인한 사용자만이 해당 기능 사용
	public void register() { // 등록작업은 POST방식으로 처리했지만 화면에서 입력을 받아야되므로 GET방식으로 처리합니다.
		
	}
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()") // 로그인한 사용자만이 해당 기능 사용
	public String register(BoardVO board, RedirectAttributes rttr) { // 추가적으로 새롭게 등록된 게시물의 번호를 같이 전달하기 위해 RedirectAttributes사용.
		
		log.info("register -> " + board);
		
		service.register(board);
		
		// redirect직전에 플래시에 저장, 이후에는 소멸됨. header가 아닌 세션을 통해 전달되므로 ?result=13등의 파라미터가 보이지않는다(깔끔)
		rttr.addFlashAttribute("result", board.getBno()); 
		
		return "redirect:/board/list"; // 등록작업이 끝난 후 다시 list 페이지로 이동(내부적으로 response.sendRedirect()처리)
		
	}
	
	@GetMapping({"/get","/modify"}) // 수정/삭제 화면으로 이동하는 것은 조회 페이지와 같으므로 modify 추가
	// @RequestParam를 사용해서 값을 좀 더 명시적으로 처리(생략해도 무방함)
	// 화면으로 조회할 게시물의 bno값을 전달해야되므로 Model을 파라미터로 지정
	// @ModelAttribute은 자동으로 Model에 데이터를 지정한 이름으로 담아준다.
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("pm") PageMaker pm, Model model) { 
		
		log.info("/get or modify -> ");
		model.addAttribute("board", service.get(bno));
	}
	
	@PreAuthorize("(principal.username == #board.writer) or (hasRole('ROLE_ADMIN'))")
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("pm") PageMaker pm, RedirectAttributes rttr) {
		
		log.info("modify -> " + board);
		
		if(service.modify(board)) { // 수정이 이루어지면(1이라는 값이 반환)
			rttr.addFlashAttribute("result", "modifySuccess");
		}
		
		// 수정 페이지에서 list로 돌아갈때의 페이지 넘버 기억
		// UriComponentsBuilder 사용
		/*
		rttr.addAttribute("pageNum", pm.getPageNum());
		rttr.addAttribute("amount", pm.getAmount());
		rttr.addAttribute("searchType", pm.getSearchType());
		rttr.addAttribute("searchKeyword", pm.getSearchKeyword());
		*/
		
		return "redirect:/board/list" + pm.getListLink(); // 수정 작업이 끝난 후 다시 list 페이지로 이동, UriComponentsBuilder 사용
	}
	
	@PreAuthorize("(principal.username == #writer) or (hasRole('ROLE_ADMIN'))")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("pm") PageMaker pm, RedirectAttributes rttr, String writer) {
		
		log.info("remove ->" + bno);
		
		if(service.remove(bno)) { // 삭제가 이루어지면(1이라는 값이 반환)
			rttr.addFlashAttribute("result", "removeSuccess");
		}
		
		// 삭제 페이지에서 list로 돌아갈때의 페이지 넘버 기억
		// UriComponentsBuilder 사용
		/*
		rttr.addAttribute("pageNum", pm.getPageNum());
		rttr.addAttribute("amount", pm.getAmount());
		rttr.addAttribute("searchType", pm.getSearchType());
		rttr.addAttribute("searchKeyword", pm.getSearchKeyword());
		*/
		
		return "redirect:/board/list" + pm.getListLink(); // 삭제 작업이 끝난 후 다시 list 페이지로 이동, UriComponentsBuilder 사용
	}
	
	
}
