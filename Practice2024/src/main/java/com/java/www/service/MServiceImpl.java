package com.java.www.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.www.dto.MemberDto;
import com.java.www.mapper.MemberMapper;

@Service
public class MServiceImpl implements MService {
	@Autowired
	MemberMapper memberMapper;

	@Override //1. 로그인 접속
	public MemberDto loginSelect(MemberDto mdto) {

		System.out.println("mimp id : " + mdto.getId());
		System.out.println("mimp pw : " + mdto.getPw());

		// Mapper연결
		MemberDto memberDto = memberMapper.loginSelect(mdto);

		return memberDto;
	}// loginSelect

	@Override //2. 회원 정보 리스트 가져오기
	public ArrayList<MemberDto> mSelectAll() {
		ArrayList<MemberDto> list = memberMapper.mSelectAll();
		return list;
	}// mSelectAll()

}// MServiceImpl
