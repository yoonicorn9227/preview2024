package com.java.www.service;

import java.util.ArrayList;

import com.java.www.dto.MemberDto;

public interface MService {
	//1. 로그인
	MemberDto loginSelect(MemberDto mdto);

	//2. 회원정보 리스트 가져오기
	ArrayList<MemberDto> mSelectAll();

}//MService
