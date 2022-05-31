package com.kimyongju.nextobe.user.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kimyongju.nextobe.user.vo.UserVO;

@Repository
public class UserDAOImpl implements UserDAO {

	@Autowired
	private SqlSession session;

	@Override
	public UserVO login(UserVO user) {
		return session.selectOne("signIn", user);
	}

	@Override
	public UserVO idOrNicknameCheck(UserVO user) {
		return session.selectOne("idOrNicknameCheck", user);
	}

	@Override
	public int signUp(UserVO user) {
		return session.insert("signUp", user);
	}
}
