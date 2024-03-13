package com.java.www.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.java.www.service.MService;

@Controller
@RequestMapping("member")
public class MController {

	@Autowired MService mService;
	
	
    // 1. 회원정보 삭제
    @PostMapping("mDelete")
    @ResponseBody
    public String MDelete(@RequestBody int[] selectArr) {
        // 받은 배열 값 출력
        for (int i = 0; i < selectArr.length; i++) {
            System.out.println("배열 값 : " + selectArr[i]);
        }//for
        
        mService.mDelete(selectArr);

        // 삭제 작업 등의 결과에 따라 적절한 응답을 반환
        // 예를 들어, 삭제 작업이 성공했을 경우 "success" 반환
        return "성공";
    }

}// MController
