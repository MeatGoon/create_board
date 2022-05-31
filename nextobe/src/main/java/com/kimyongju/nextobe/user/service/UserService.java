package com.kimyongju.nextobe.user.service;

import com.kimyongju.nextobe.user.vo.UserVO;

public interface UserService {

	UserVO login(UserVO user);

	UserVO idOrNicknameCheck(UserVO user);

	int signUp(UserVO user);

}
