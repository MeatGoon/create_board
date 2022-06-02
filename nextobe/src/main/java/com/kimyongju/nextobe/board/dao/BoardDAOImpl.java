package com.kimyongju.nextobe.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimyongju.nextobe.board.vo.BoardVO;
import com.kimyongju.nextobe.board.vo.Criteria;
import com.kimyongju.nextobe.board.vo.FileVO;

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

	@Override
	public BoardVO boardInfo(int bno) {
		return session.selectOne("getBoardInfo", bno);
	}

	@Override
	public List<FileVO> fileInfo(int bno) {
		return session.selectList("fileInfo", bno);
	}

	@Override
	public int boardModify(BoardVO board) {
		return session.update("boardModify", board);
	}

	@Override
	public int boardInsert(BoardVO boardVo) {
		return session.insert("boardInsert", boardVo);
	}

	@Override
	public int fileInsert(FileVO file) {
		return session.insert("fileInsert", file);
	}

	@Override
	public FileVO downloadFileInfo(int fno) {
		return session.selectOne("downloadFileInfo", fno);
	}

	@Override
	public int boardDelete(int bno) {
		return session.delete("boardDelete", bno);
	}
}
