package com.swarthyPig.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.swarthyPig.domain.AuthVO;
import com.swarthyPig.domain.MemberVO;
import com.swarthyPig.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/")
@AllArgsConstructor
@Log4j
public class CommonController {
	
	private MemberService service;
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) { // 에러 발생 했을때
		log.info("access Denied : " + auth);
		
		model.addAttribute("msg", "Access Denied");
	}

	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		
		log.info("error: " + error);
		log.info("logout : " + logout);
		
		if(error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		
		if (logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
	}
	
	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("custom logout");
	}
	
	@PostMapping("/customLogout")
	public void logoutPost() {
		log.info("post custom logout");
	}
	
	@GetMapping("/memberRegister")
	public void register() { // 회원가입 작업은 POST방식으로 처리했지만 화면에서 입력을 받아야되므로 GET방식으로 처리합니다.
		
	}
	
	@PostMapping("/memberRegister")
	public String register(MemberVO member, AuthVO auth, RedirectAttributes rttr) { // 추가적으로 새롭게 등록된 게시물의 번호를 같이 전달하기 위해 RedirectAttributes사용.
		
		service.registerUser(member);
		service.registerUserAuth(auth);
		
		log.info("register -> " + member);
		
		// redirect직전에 플래시에 저장, 이후에는 소멸됨. header가 아닌 세션을 통해 전달되므로 파라미터가 보이지않는다
		rttr.addFlashAttribute("result", member.getUserName()); 
		
		return "redirect:/board/list"; // 회원가입 작업이 끝난 후 다시 list 페이지로 이동(내부적으로 response.sendRedirect()처리)
		
	}
}
