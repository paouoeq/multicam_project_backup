package com.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.MemberDTO;
import com.service.MemberService;

@Controller
public class LogInController {

	@Autowired
	MemberService service;
	
	@GetMapping("/loginForm")
	public String loginForm(HttpSession session) {
		// 중복 로그인 방지
		if(session.getAttribute("loginInfo")!=null) {
			return "member/duplicateLoginWarning";
		}
		return "loginForm";
	}
	
	@PostMapping("/login")
	public String login(@RequestParam HashMap<String, String> map, HttpSession session) throws Exception {
		
		MemberDTO dto = service.login(map);
		
		if(dto!=null) { // 로그인 성공
			if(service.emailAuthFail(dto.getUserID()) != 1) { // 인증이 안된 경우
				return "member/emailAuthFail";
			}
			session.setAttribute("loginInfo", dto); // 로그인정보 저장
			return "redirect:main";	
		}
		else {
			return "member/loginFail";
		}
	}
	
	@GetMapping("/loginCheck/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		return "redirect:/main";
	}
	
	// 아이디 찾기 폼
	@GetMapping("/findIdForm")
	public String findIdForm() {
		return "findIdForm";
	}
	
	// 아이디 찾기
	@PostMapping("/findId")
    public String findId(MemberDTO dto, Model model) throws Exception{
        List<MemberDTO> idList = service.findId(dto);
        model.addAttribute("idList", idList);
        return "/member/findIdResult";
    }
	
	// 비밀번호 찾기 폼
	@GetMapping("/findPwForm")
	public String findPwForm() {
		return "findPwForm";
	}
	
	// 비밀번호 재설정
	@PostMapping("/findPw")
	public String findPw(MemberDTO dto, Model model) throws Exception{
//		List<MemberDTO> idList = service.findId(dto);
//		model.addAttribute("idList", idList);
		return "/member/findPwResult";
	}
	
	// 비밀번호 재설정 완료
	@PostMapping("/findPwSuccess")
	public String findPwSuccess() {
		
		
		return "/member/findPwSuccess";
	}
	

}
