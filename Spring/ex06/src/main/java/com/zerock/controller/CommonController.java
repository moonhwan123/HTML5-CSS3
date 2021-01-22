package com.zerock.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class CommonController {

	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("At /customError -> access denied : " + auth);
		
		model.addAttribute("msg","access Denied");
	}
	
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		log.info("At /customLogin -> error : " + error);
		log.info("At /customLogin -> logout : " + logout);
		
		if(error != null) {
			model.addAttribute("error" , "Login Error Check Your Account");
		}
		
		if(logout != null) {
			model.addAttribute("logout" , "Logout!!");
		}
		
	}
	
	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("custom Logout");
	}
	
}
