package com.java.www.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("email")
public class EController {

	@GetMapping("mailList")
	public String getEmailList() {
		return "/email/mailList";
	}//getEmailList() ◀받은 이메일
	
	@GetMapping("sendList")
	public String sendEmailList() {
		return "/email/sendList";
	}//sendEmailList() ◀보낸 이메일
}//EController
