package com.java.www.controller;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.java.www.dto.MemberDto;
import com.java.www.service.MService;

import jakarta.servlet.http.HttpSession;

@Controller
public class FController {

	@Autowired
	MService mService;
	@Autowired
	HttpSession session;

	@GetMapping({ "/", "index" })
	public String index(Model model, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "all") String gender, @RequestParam(defaultValue = "5") int viewColumnsCount,
			@RequestParam(defaultValue = "All") String SearchCategory,
			@RequestParam(required = false) String SearchWord) {

		// 확인용
		System.out.println("카테고리 : " + SearchCategory);
		System.out.println("검색어 : " + SearchWord);
		System.out.println("성별 : " + gender);

		if (gender.equals("male")) {
			gender = "남";
		} else if (gender.equals("female")) {
			gender = "여";
		}//if(남자 여자 변환)

		// service 연결
		Map<String, Object> map = mService.mSelectAll(page, gender, viewColumnsCount, SearchCategory, SearchWord); // ArrayList
		// → Map으로
		// 변경

		System.out.println("선택 갯수 : " + viewColumnsCount);

		// model 저장 후 전송
		model.addAttribute("map", map);

		return "index";
	}// index

	// 1.로그인 페이지
	@GetMapping("login")
	public String login() {
		return "login";
	}// login

	// 2.로그인 접속
	@PostMapping("doLogin")
	public String doLogin(MemberDto mdto, Model model) {
		int result = 0;
		System.out.println("id : " + mdto.getId());
		System.out.println("pw : " + mdto.getPw());

		// service연결
		MemberDto memberDto = mService.loginSelect(mdto);

		if (memberDto != null) {
			session.setAttribute("session_id", memberDto.getId());
			session.setAttribute("session_name", memberDto.getName());
			result = 1;
		} // 회원 있을경우 결과값 출력

		System.out.println("Result : " + result);

		// model 저장후 전송 연결
		model.addAttribute("result", result);

		return "doLogin";
	}// doLogin(로그인 접속)

	// 3. 로그아웃
	@RequestMapping("doLogout")
	public String doLogout(Model model) {
		session.invalidate();
		String result = "로그아웃";

		// model 저장 후 전송
		model.addAttribute("result", result);
		return "doLogout";
	}// doLogout(model)

	@GetMapping("memInfo")
	public String memInfo() {
		return "memInfo";
	}// memInfo

	@GetMapping("mInsert")
	public String mInsert() {
		return "mInsert";
	}// mInsert

}// FController(컨트롤러)
