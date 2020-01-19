package com.swarthyPig.mapper;

import com.swarthyPig.domain.AuthVO;
import com.swarthyPig.domain.MemberVO;

public interface MemberMapper {
	
	public MemberVO read(String userid);
	
	public void insertUser(MemberVO vo); // 회원 등록 작업
	
	public void insertUserAuth(AuthVO vo); // 회원 권한 작업
}
