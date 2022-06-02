package com.kimyongju.nextobe.board.dao;

import java.util.List;

import com.kimyongju.nextobe.board.vo.BoardVO;
import com.kimyongju.nextobe.board.vo.Criteria;
import com.kimyongju.nextobe.board.vo.FileVO;

public interface BoardDAO {

	List<BoardVO> getBoardList(Criteria cri);

	int getTotal();

	BoardVO boardInfo(int bno);

	List<FileVO> fileInfo(int bno);

	int boardModify(BoardVO board);

	int boardInsert(BoardVO boardVo);

	int fileInsert(FileVO file);

	FileVO downloadFileInfo(int fno);

	int boardDelete(int bno);

}
