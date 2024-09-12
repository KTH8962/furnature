package com.example.furnature.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	// 메인 페이지
	@RequestMapping("/main.do")
	public String main(Model model) throws Exception{
		return "/main/main";
	}
	
	
}
