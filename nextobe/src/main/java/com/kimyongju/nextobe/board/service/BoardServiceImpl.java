package com.kimyongju.nextobe.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimyongju.nextobe.board.dao.BoardDAO;
import com.kimyongju.nextobe.board.vo.BoardVO;
import com.kimyongju.nextobe.board.vo.Criteria;
import com.kimyongju.nextobe.board.vo.FileVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO bdao;

	@Override
	public List<BoardVO> getBoardList(Criteria cri) {
		return bdao.getBoardList(cri);
	}

	@Override
	public int getTotal() {
		return bdao.getTotal();
	}

	@Override
	public BoardVO boardInfo(int bno) {
		return bdao.boardInfo(bno);
	}

	@Override
	public List<FileVO> fileInfo(int bno) {
		return bdao.fileInfo(bno);
	}

	@Override
	public int boardModify(BoardVO board) {
		return bdao.boardModify(board);
	}
}
