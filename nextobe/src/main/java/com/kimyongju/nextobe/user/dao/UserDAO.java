package com.kimyongju.nextobe.user.dao;

import com.kimyongju.nextobe.user.vo.UserVO;

public interface UserDAO {

	UserVO login(UserVO user);

	UserVO idOrNicknameCheck(UserVO user);

	int signUp(UserVO user);

}
