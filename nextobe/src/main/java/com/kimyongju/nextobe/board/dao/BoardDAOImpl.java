package com.kimyongju.nextobe.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimyongju.nextobe.board.vo.BoardVO;
import com.kimyongju.nextobe.board.vo.Criteria;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired
	private SqlSession session;

	@Override
	public List<BoardVO> getBoardList(Criteria cri) {
		return session.selectList("boardAllList", cri);
	}

	@Override
	public int getTotal() {
		return session.selectOne("getTotal");
	}
}
