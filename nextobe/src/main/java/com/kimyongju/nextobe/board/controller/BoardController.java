package com.kimyongju.nextobe.board.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kimyongju.nextobe.board.service.BoardService;
import com.kimyongju.nextobe.board.vo.BoardVO;
import com.kimyongju.nextobe.board.vo.Criteria;
import com.kimyongju.nextobe.board.vo.FileVO;
import com.kimyongju.nextobe.board.vo.PageMakerDTO;
import com.kimyongju.nextobe.user.vo.UserVO;

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
	
	@GetMapping("/boardInfo")
	public void BoardInfo(Model model, Criteria cri, int bno) {
		log.info("BoardInfo 페이지 이동");
		model.addAttribute("boardInfo", bservice.boardInfo(bno));
		model.addAttribute("cri", cri);
		List<FileVO> fileInfo = bservice.fileInfo(bno);
		if (!fileInfo.isEmpty()) {
			model.addAttribute("fileInfo", fileInfo);
		}
	}
	
	@GetMapping("/boardModify")
	public void boardModify(Model model, Criteria cri, int bno) {
		log.info("boardModify 페이지 이동");
		model.addAttribute("boardInfo", bservice.boardInfo(bno));
		model.addAttribute("cri", cri);
		List<FileVO> fileInfo = bservice.fileInfo(bno);
		if (!fileInfo.isEmpty()) {
			model.addAttribute("fileInfo", fileInfo);
		}
	}
	
	@PostMapping("/boardModify")
	public String boardModify(BoardVO board, Criteria cri, RedirectAttributes rttr) {
		bservice.boardModify(board);
		
		// 업로드 파일 삭제, 수정 기능 구현
		// 기존의 정보와 다를경우 수정? 전체 삭제후 재생성?

		rttr.addFlashAttribute("result", "boardModify success");
		
		return "redirect:/board/boardInfo?bno=" + board.getBno() + "&pageNum=" + cri.getPageNum() + "&amount=" + cri.getAmount();
	}
	
	@GetMapping("/boardInsert")
	public void boardInsert() {
		log.info("boardInsert 페이지 이동");
	}
	
	@PostMapping("/boardInsert")
	public String boardInsert(BoardVO boardVo, @RequestParam("fileUp") MultipartFile[] file) {
		System.out.println(boardVo);
		if (file != null) {
			for (int i = 0; i < file.length; i++) {
				System.out.println(file[i].getOriginalFilename());
				System.out.println(file[i].getName());
				System.out.println(file[i].getSize());
				System.out.println(file[i].getContentType());
			}
		}
		return "redirect:/board/boardInsert";
	}
	
}
