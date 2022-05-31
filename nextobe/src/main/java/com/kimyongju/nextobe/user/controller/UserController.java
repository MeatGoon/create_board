package com.kimyongju.nextobe.user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kimyongju.nextobe.board.vo.Criteria;
import com.kimyongju.nextobe.user.service.UserService;
import com.kimyongju.nextobe.user.vo.UserVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/user/*")
@Log4j
@AllArgsConstructor
public class UserController {

	@Autowired
	private UserService uservice;
	
	@GetMapping("/signIn")
	public void signIn() {
		log.info("로그인 페이지 이동");
	}
	
	@PostMapping("/signIn")
	public String signIn(HttpSession session, UserVO user, RedirectAttributes rttr) {
		
		UserVO userInfo = uservice.login(user);
		if (userInfo != null) {
			session.setAttribute("userInfo", userInfo);
			return "redirect:/board/boardList";
		}else {
			rttr.addFlashAttribute("result", "loginFail");
			return "redirect:/user/signIn";
		}
		
		
	}
	
	@GetMapping("signUp")
	public void signUp() {
		
	}
	
	@PostMapping(value = "/idOrNicknameCheck", consumes = "application/json")
	public ResponseEntity<String> check(@RequestBody UserVO user){
		log.info("check: " + user);
		return uservice.idOrNicknameCheck(user) == null 
				?  new ResponseEntity<String>("success", HttpStatus.OK)
				:  new ResponseEntity<String>("false", HttpStatus.OK);
	}
	
	@PostMapping("signUp")
	public String signUp(UserVO user, RedirectAttributes rttr) {
		
		uservice.signUp(user);
		return "redirect:/user/signIn";
	}
	
	
	@PostMapping("logout")
	public String logout(HttpSession session, Criteria cri) {
		session.invalidate();
		return "redirect:/board/boardList?pageNum=" + cri.getPageNum() + "&amount=" + cri.getAmount();
	}
}
