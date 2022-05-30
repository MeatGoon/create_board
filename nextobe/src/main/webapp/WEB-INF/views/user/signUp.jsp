<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<style>
.contentContainer table {
	border-collapse: collapse;
	border: 1px solid black;
}
th{
	border-bottom: 1px solid black;
}
</style>
<body>
<h1>회원가입 페이지</h1>
<div class="contentContainer">
	<form id="signUp" action="./signUp" method="post">
		<table id="signUp_tb">
			<tr>
				<th colspan="2">회원 정보 입력란</th>
			</tr>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="userid" maxlength="10" placeholder="5~10 영문, 숫자 아이디 입력"/><button type="button" id="idCheck_btn" onclick="">중복확인</button></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="userpwd" id="userpwd" maxlength="20" placeholder="5~20 특수문자 제외 비밀번호 입력"/></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td><input type="password" name="userpwd_check" id="userpwd" maxlength="20" placeholder="비밀번호 확인"/><span class="pwdMessage"></span><br />
					<input type="checkbox" id="showPassword"/><label for="#">표시</label>
				</td>
			</tr>
			<tr>
				<td>닉네임</td>
				<td><input type="text" name="nickname" placeholder="영문 5~20자  한글  최대 8자"/><button type="button" id="nicknameCheck_btn" onclick="">중복확인</button></td>
			</tr>
			<tr>
				<td>성함</td>
				<td><input type="text" name="username" maxlength="3" placeholder="세자리의 성함 입력"/></td>
			</tr>
			<tr>
				<td>성별</td>
				<td>
					<input type="radio" name="gender" value="남"/><label for="gender">남</label>
					<input type="radio" name="gender" value="여"/><label for="gender">여</label>
				</td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="text" name="userphone" id="phoneNum" placeholder="01X-0000-0000"/></td>
			</tr>
		</table>
		<button type="button" id="signUp_btn">회원가입</button>
		<button type="button" id="cancel_signUp">가입취소</button>
	</form>
</div>
<script>
	$(document).ready(function() {
		var signUpForm = $("#signUp");
		var pwd;
		var pwdCheck;
		var pwd_check_flag = false; // 비밀번호 일치 여부 확인
		
		signUpForm.on("input", "input[id='userpwd']", function() {
			pwd = signUpForm.find("input[name='userpwd']").val();
			pwdCheck = signUpForm.find("input[name='userpwd_check']").val();
			if(pwd === pwdCheck){
				signUpForm.find(".pwdMessage").html("비밀번호가 일치합니다.");
				console.log("비밀번호가 일치합니다.");
				pwd_check_flag = true;
			}else {
				signUpForm.find(".pwdMessage").html("일치하지 않습니다.");
				console.log("비밀번호가 일치하지 않습니다.");
				pwd_check_flag = false;;
			}
		});
		
		/* 이전 학원 팀 프로젝트에서 참고한 부분 시작 */
		$('#idCheck_btn').on("click", function(e) {
			e.preventDefault();
			if(!checkData(regId,userId,"아이디")){
		    	return false;
			}
			var data={userid : $('input[name=userid]').val()};
			idOrNicknameCheck(data, function(result) {
				console.log(result);
				if(result == 'success'){
					id_check_flag = true;
					alert("사용 가능한 아이디 입니다.");
				}else{
					id_check_flag = false;
					alert("사용 불가능한 아이디 입니다..");
 					$('input[name=userid]').focus();
					$('input[name=userid]').val('');
				}
			});
		});
		
		$('#nicknameCheck_btn').on("click", function(e) {
			e.preventDefault();
			if(!checkData(regNickName,nickname,"닉네임")){
		    	return false;
			}
			var data={nickname : $('input[name=nickname]').val()};
			idOrNicknameCheck(data, function(result) {
				console.log(result);
				if(result == 'success'){
					nick_check_flag = true;
					alert("사용 가능한 닉네임 입니다.");
				}else{
					nick_check_flag = false;
					alert("사용 불가능한 닉네임 입니다..");
 					$('input[name=nickname]').focus();
					$('input[name=nickname]').val('');
				}
			});
		});
		
		var id_check_flag = false;
		var nick_check_flag = false;
		var userId = signUpForm.find("input[name='userid']");
		var userPwd = signUpForm.find("input[name='userpwd']");
		var userName = signUpForm.find("input[name='username']");
		var nickname = signUpForm.find("input[name='nickname']");
		var userPhone = signUpForm.find("input[name='userphone']");
		
		// 정규식
		var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		var regId = /^[a-zA-Z0-9]{5,20}$/;
		var regPwd = /^[a-zA-Z0-9]{5,20}$/;
		var regNickName = /^[a-zA-z0-9]{5,20}$/;
		var redName = /^[가-힣]{2,3}$/;
		
		$("#signUp_btn").on("click" , function(e) {
			e.preventDefault();
			
			if(!checkData(regId,userId,"아이디")){
		    	return false;
			}
			if(id_check_flag == false){
				alert("아이디 중복 확인을 하세요.");
				return false;
			}
			if (pwd_check_flag == false) {
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}
			if(!checkData(regPwd,userPwd,"비밀번호")){
		    	return false;
			}
			if (!checkData(regNickName, nickname, "닉네임")) {
				return false;	
			}
			if (nick_check_flag == false) {
				alert("닉네임 중복 확인을 하세요.");
				return false;
			}
			if (!checkData(redName,userName,"성함")) {
		    	return false;
		    }
		    if (!checkData(regPhone,userPhone,"휴대전화 번호")) {
		    	return false;
		    }
		    signUpForm.attr("action", "./signUp");
		    signUpForm.attr("method", "post");
		    signUpForm.submit();
		    
		});
		
		function checkData(reg,data,message) {
			if(reg.test(data.val())){
				return true;
			}else{
				alert(message+" 을(를) 양식에 맞춰 작성해주세요.");
				data.val('');
				data.focus();				
			}
		}
		
		function idOrNicknameCheck(checkData, callback, error) {
			$.ajax({
				url : "./idOrNicknameCheck",
				type : "post",
				data : JSON.stringify(checkData),
				contentType : "application/json; charset=utf-8",
				success : function(result, status, error) {
					console.log(callback);
					if(callback){
						callback(result);
					}
				}
			});
		}
		/* 이전 학원 팀 프로젝트에서 참고한 부분 끝 */
		
		$("#showPassword").on("click", function() {
			var checked = $("#showPassword").is(":checked");
			if (checked) {
				$("input[name=userpwd]").attr("type", "text");
				$("input[name=userpwd_check]").attr("type", "text");
			}else {
				$("input[name=userpwd]").attr("type", "password");
				$("input[name=userpwd_check]").attr("type", "password");
			}
			
		});
		
		$("input[name=userid]").change(function() {
			id_check_flag = false;
		});
		$("input[name=nickname]").change(function() {
			nick_check_flag = false;
		});
		
		/* 자동 약식 생성 이벤트 참고한 자료 */
		var phoneNum = document.getElementById("phoneNum");
		phoneNum.onkeyup = function(){
		  this.value = autoHypenPhone( this.value ) ;  
		}
		var autoHypenPhone = function(str){
		      str = str.replace(/[^0-9]/g, '');
		      var tmp = '';
		      if( str.length < 4){
		          return str;
		      }else if(str.length < 7){
		          tmp += str.substr(0, 3);
		          tmp += '-';
		          tmp += str.substr(3);
		          return tmp;
		      }else if(str.length < 11){
		          tmp += str.substr(0, 3);
		          tmp += '-';
		          tmp += str.substr(3, 3);
		          tmp += '-';
		          tmp += str.substr(6);
		          return tmp;
		      }else{              
		          tmp += str.substr(0, 3);
		          tmp += '-';
		          tmp += str.substr(3, 4);
		          tmp += '-';
		          tmp += str.substr(7);
		          return tmp;
		      }
		      return str;
		}
		
		$("#cancel_signUp").on("click", function(e) {
			e.preventDefault();
			history.go(-1);
		});
	});
</script>

</body>
</html>