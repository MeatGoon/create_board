package com.kimyongju.nextobe.board.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kimyongju.nextobe.board.service.BoardService;
import com.kimyongju.nextobe.board.vo.BoardVO;
import com.kimyongju.nextobe.board.vo.Criteria;
import com.kimyongju.nextobe.board.vo.FileVO;
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

		return "redirect:/board/boardInfo?bno=" + board.getBno() + "&pageNum=" + cri.getPageNum() + "&amount="
				+ cri.getAmount();
	}

	@GetMapping("/boardInsert")
	public void boardInsert() {
		log.info("boardInsert 페이지 이동");
	}

	@PostMapping("/boardDelete")
	public void boardDelete(int bno, RedirectAttributes rttr) {
		bservice.boardDelete(bno);
		rttr.addFlashAttribute("result", "boardDelete success");
	}

	@PostMapping("/boardInsert")
	public String boardInsert(BoardVO boardVo, FileVO file, RedirectAttributes rttr, MultipartFile[] fileUp)
			throws IllegalStateException, IOException {

		bservice.boardInsert(boardVo);

		System.out.println("실행함");
		String upPath = "D:\\workspace\\upload";
		// 경로가 없을경우 새로 생성
		File target = new File(upPath);
		if (!target.exists())
			target.mkdirs();
		System.out.println(fileUp.length);
		System.out.println(fileUp);
		for (int i = 0; i < fileUp.length; i++) {
			if (!fileUp[i].isEmpty()) {
				System.out.println(i);
				String orgFileName = fileUp[i].getOriginalFilename();
				String orgFileExtension = orgFileName.substring(orgFileName.lastIndexOf("."));
				String saveFileName = UUID.randomUUID().toString().replaceAll("-", "") + orgFileExtension;
				Long saveFileSize = fileUp[i].getSize();
				log.info("================== file start ==================");
				log.info("파일 실제 이름: " + orgFileName);
				log.info("파일 저장 이름: " + saveFileName);
				log.info("파일 크기: " + saveFileSize);
				log.info("content type: " + fileUp[i].getContentType());
				log.info("================== file   END ==================");

				file.setOrg_file_name(orgFileName);
				file.setSave_file_name(saveFileName);
				file.setFile_size(saveFileSize);

				bservice.fileInsert(file);

				// 파일 등록
				target = new File(upPath, saveFileName);
				fileUp[i].transferTo(target);
			} else {
				break;
			}
		}

		rttr.addFlashAttribute("result", "boardInsert success");
		return "redirect:/board/boardList";
	}

	@GetMapping("/fileDownload")
	public void fileDownload(int fno, HttpServletResponse response) throws IOException {
		String upPath = "D:\\workspace\\upload\\";
		FileVO file = bservice.downloadFileInfo(fno);

		String saveFileName = file.getSave_file_name();
		String originalFileName = file.getOrg_file_name();

		File downloadFile = new File(upPath + saveFileName);

		byte fileByte[] = FileUtils.readFileToByteArray(downloadFile);

		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);

		response.setHeader("Content-Disposition",
				"attachment; fileName=\"" + URLEncoder.encode(originalFileName, "UTF-8") + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");

		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();

	}

	@PostMapping("/excelDownload")
	public void excelDownload(HttpServletResponse response, String[] checkedData) throws IOException {
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("첫번째 시트");
		Row row = null;
		Cell cell = null;
		int rowNum = 0;
		int checkLen = 0;
		String[] header = {"게시판 제목", "게시판 내용", "게시판 작성자", "작성일", "업로드 파일 갯수", "파일 총 크기"};

		row = sheet.createRow(rowNum++);
		for (int i = 0; i < header.length; i++) {
            cell = row.createCell(i);
            cell.setCellValue(header[i]);
		}
		for (int i = 0; i < checkedData.length; i++) {
			row = sheet.createRow(rowNum++);
            cell = row.createCell(0);
            cell.setCellValue(i);
            cell = row.createCell(1);
            cell.setCellValue(i+"_name");
            cell = row.createCell(2);
            cell.setCellValue(i+"_title");
		}

		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename=example.xlsx");

		wb.write(response.getOutputStream());
		wb.close();
	}

}
