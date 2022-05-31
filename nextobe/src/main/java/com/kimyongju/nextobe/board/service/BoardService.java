package com.kimyongju.nextobe.board.service;

import java.util.List;

import com.kimyongju.nextobe.board.vo.BoardVO;
import com.kimyongju.nextobe.board.vo.Criteria;

public interface BoardService {

	List<BoardVO> getBoardList(Criteria cri);

	int getTotal();

}
