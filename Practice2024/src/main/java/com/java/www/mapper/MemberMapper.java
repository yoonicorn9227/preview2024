package com.java.www.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.java.www.dto.MemberDto;

@Mapper
public interface MemberMapper {

	//1. 로그인 접속
	MemberDto loginSelect(MemberDto mdto);

	//2. 회원정보 리스트 가져오기
	ArrayList<MemberDto> mSelectAll();

}//MemberMapper(Interface)
