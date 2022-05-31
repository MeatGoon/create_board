package com.kimyongju.nextobe.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kimyongju.nextobe.board.service.BoardService;
import com.kimyongju.nextobe.board.vo.Criteria;
import com.kimyongju.nextobe.board.vo.PageMakerDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@Log4j
@AllArgsConstructor
public class BoardController {

	@Autowired
	private BoardService bservice;
	
	@GetMapping("/boardList")
	public void boardList(Model model, Criteria cri) {
		log.info("BoardList 페이지 이동");
		model.addAttribute("bAllList", bservice.getBoardList(cri));
		
		int total = bservice.getTotal();
        PageMakerDTO pageMake = new PageMakerDTO(cri, total);
        model.addAttribute("pageMaker", pageMake);
	}
}
