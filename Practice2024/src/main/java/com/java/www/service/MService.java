package com.java.www.service;

import java.util.ArrayList;
import java.util.Map;

import com.java.www.dto.MemberDto;

public interface MService {
	//1. 로그인
	MemberDto loginSelect(MemberDto mdto);

	//2. 회원정보 리스트 가져오기
	Map<String, Object> mSelectAll(int page, int viewColumnsCount);

	void mDelete(int[] selectArr);



}//MService
