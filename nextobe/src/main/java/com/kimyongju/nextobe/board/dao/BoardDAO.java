package com.kimyongju.nextobe.board.dao;

import java.util.List;

import com.kimyongju.nextobe.board.vo.BoardVO;
import com.kimyongju.nextobe.board.vo.Criteria;

public interface BoardDAO {

	List<BoardVO> getBoardList(Criteria cri);

	int getTotal();

}
