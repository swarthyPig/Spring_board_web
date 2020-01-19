package com.swarthyPig.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.swarthyPig.domain.AuthVO;
import com.swarthyPig.domain.MemberVO;
import com.swarthyPig.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service // 주로 비즈니스 영역을 담당하는 객체임을 표시함
@AllArgsConstructor
@Log4j
public class MemberServiceImpl implements MemberService{
	
	private MemberMapper mapper;
	
	private PasswordEncoder pwencoder;

	@Override
	public void registerUser(MemberVO member) {

		log.info("registerUser -> " + member);
		
		String encodingPassword = pwencoder.encode(member.getUserpw());
		
		member.setUserpw(encodingPassword);
		
		mapper.insertUser(member);
	}

	@Override
	public void registerUserAuth(AuthVO auth) {

		log.info("registerUserAuth -> " + auth);
		
		mapper.insertUserAuth(auth);
	}

}
