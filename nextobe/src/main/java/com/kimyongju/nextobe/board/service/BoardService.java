package com.kimyongju.nextobe.board.service;

import java.util.List;

import com.kimyongju.nextobe.board.vo.BoardVO;
import com.kimyongju.nextobe.board.vo.Criteria;
import com.kimyongju.nextobe.board.vo.FileVO;

public interface BoardService {

	List<BoardVO> getBoardList(Criteria cri);

	int getTotal();

	BoardVO boardInfo(int bno);

	List<FileVO> fileInfo(int bno);

	int boardModify(BoardVO board);

}
