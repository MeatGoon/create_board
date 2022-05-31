package com.kimyongju.nextobe.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimyongju.nextobe.user.dao.UserDAO;
import com.kimyongju.nextobe.user.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO udao;

	@Override
	public UserVO login(UserVO user) {
		return udao.login(user);
	}

	@Override
	public UserVO idOrNicknameCheck(UserVO user) {
		return udao.idOrNicknameCheck(user);
	}

	@Override
	public int signUp(UserVO user) {
		return udao.signUp(user);
	}
}
