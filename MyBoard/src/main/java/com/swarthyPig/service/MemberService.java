package com.swarthyPig.service;

import com.swarthyPig.domain.AuthVO;
import com.swarthyPig.domain.MemberVO;

public interface MemberService {

	public void registerUser(MemberVO member);
	
	public void registerUserAuth(AuthVO auth);
}
