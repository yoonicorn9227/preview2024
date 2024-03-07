package com.java.www.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.java.www.dto.MemberDto;

@Mapper
public interface MemberMapper {

	//1. 로그인 접속
	MemberDto loginSelect(MemberDto mdto);
	void loginTime(String id); //1-a로그인 최근 접속시간
	void loginCount(String id); //1-b 로그인 접속횟수

	//2. 회원정보 리스트 가져오기
	ArrayList<MemberDto> mSelectAll(int startContRowNum, int endContRowNum);
	int mSelectCountAll(); //2-a. 회원정보 리스트 총갯수


}//MemberMapper(Interface)
