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

import com.java.www.dto.MemberDto;
import com.java.www.service.MService;

import jakarta.servlet.http.HttpSession;

@Controller
public class FController {

	@Autowired
	MService mService;
	@Autowired
	HttpSession session;

	@GetMapping({"/","index"})
	public String index(Model model, @RequestParam(defaultValue = "1") int page) {

		// service 연결
		Map<String, Object> map = mService.mSelectAll(page); //ArrayList → Map으로 변경

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
