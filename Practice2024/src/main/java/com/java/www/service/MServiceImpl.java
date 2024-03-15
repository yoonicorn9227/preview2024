package com.java.www.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.www.dto.MemberDto;
import com.java.www.mapper.MemberMapper;

@Service
public class MServiceImpl implements MService {
	@Autowired
	MemberMapper memberMapper;

	@Override // 1. 로그인 접속
	public MemberDto loginSelect(MemberDto mdto) {

		System.out.println("mimp id : " + mdto.getId());
		System.out.println("mimp pw : " + mdto.getPw());

		// ▽ Mapper연결(1. 로그인 접속)
		MemberDto memberDto = memberMapper.loginSelect(mdto);

		// 1-a. 회원 로그인 최근 접속시간
		memberMapper.loginTime(mdto.getId());
		// 1-b. 회원 로그인 횟수
		memberMapper.loginCount(mdto.getId());

		return memberDto;
	}// loginSelect

	@Override // 2. 회원 정보 리스트 가져오기
	public Map<String, Object> mSelectAll(int page, int viewColumnsCount, String SearchCategory, String SearchWord) {

		System.out.println("MServiceImpl viewColumnsCount : "+viewColumnsCount);
		System.out.println("MServiceImpl 카테고리 : "+SearchCategory);
		System.out.println("MServiceImpl 검색어 : "+SearchWord);
		
		// 2-1.페이지 넘버링 - ②번째
		if (page <= 0)
			page = 1; // 페이지가 0과 같거나 작을경우.
		int contentCount = viewColumnsCount; // 1pg당 게시글 갯수
		int bottomNum = 5; // 하단 페이징 넘버링 갯수
		int countAll = memberMapper.mSelectCountAll(SearchCategory,SearchWord); // 2-a. 회원정보 리스트 총갯수
		System.out.println("ds:"+countAll);
		int maxPage = (int) Math.ceil((double) (countAll / contentCount));
		int startPageNum = ((page - 1) / bottomNum) * bottomNum + 1;
		int endPageNum = (startPageNum + bottomNum) - 1;
		if (endPageNum > maxPage)
			endPageNum = maxPage; // 페이지 넘버링 최대페이지가 끝페이지보다 작을경우
		int startContRowNum = (page - 1) * contentCount + 1;
		int endContRowNum = startContRowNum + contentCount - 1;

		// 2. 회원 정보 리스트 가져오기 - ①번째
		ArrayList<MemberDto> list = memberMapper.mSelectAll(startContRowNum, endContRowNum, SearchCategory,SearchWord);

		// ③번째- Return타입을 ArrayList에서 Map으로 변경 → Map태워서 jsp로 보내기

		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("page", page);
		map.put("maxPage", maxPage);
		map.put("startPageNum", startPageNum);
		map.put("endPageNum", endPageNum);
		
		map.put("viewColumnsCount", viewColumnsCount);

		map.put("SearchCategory", SearchCategory);
		map.put("SearchWord", SearchWord);
		
		
		
		System.out.println("maxPage : "+maxPage);
		System.out.println("startPage : "+startPageNum);
		System.out.println("endPage : "+endPageNum);
		System.out.println("page : "+page);
		
		
		return map;
	}// mSelectAll()

	@Override
	public void mDelete(int[] selectArr) {
		
		//Mapper연결
		memberMapper.mDelete(selectArr);
		
		
	}

}// MServiceImpl
