package com.swarthyPig.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice // 해당 객체가 스프링의 컨트롤러에서 발생하는 예외를 처리하는 존재임을 명시
public class CommonExceptionAdvice {
	
	// 400에러 처리
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handler404(NoHandlerFoundException ex) {
		
		return "custom404_error";
	}
}
