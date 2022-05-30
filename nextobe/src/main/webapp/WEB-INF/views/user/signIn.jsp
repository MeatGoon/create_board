<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<style>
.contentContainer > table{
	border-collapse: collapse;
}
.text_btn{
	text-align: center;
	display: block;
}
</style>
<body>
<h1>로그인 페이지</h1>
<div class="contentContainer">
	<form id="signIn" action="./signIn" method="post">
		<table border="1">
			<tr>
				<th colspan="2">로그인 입력창</th>
				<th rowspan="3"><button id="signIn_btn" type="button">로그인</button></th>
			</tr>
			<tr>
				<td><label for="userid">아이디</label></td>
				<td><input type="text" name="userid" placeholder="아이디 혹은 이메일"/></td>
			</tr>
			<tr>
				<td><label for="userpwd">비밀번호</label></td>
				<td><input type="password" name="userpwd" placeholder="비밀번호 입력"/></td>
			</tr>
			<tr>
				<td colspan="3"><a href="./signUp" class="signUp text_btn">회원가입</a></td>
			</tr>
		</table>
	</form>
	<button onclick="window.location.href='/board/boardList'">게시판 이동</button>
</div>
<script>
	$(document).ready(function() {
		let result = '<c:out value="${result}"/>';
		checkAlert(result);
		
		/* 컨트롤러의 요청이 어떻게 처리되었는지 알려주는 함수 */
	    function checkAlert(result){
	        if(result === ''){
	            return;
	        }
	        if(result === "loginFail"){
	            alert("아이디 비밀번호가 일치하지 않습니다");
	        }
	    } 
		
		$("#signIn_btn").on("click", function() {
			let idCheck = $("#signIn").find("input[name='userid']").val();
			let pwdCheck = $("#signIn").find("input[name='userpwd']").val();
			if (idCheck === "") {
				alert("아이디를 입력 해주시기 바랍니다");
			}else {
				if (pwdCheck === "") {
					alert("비밀번호를 입력 해주시기 바랍니다");
				}else {
					$("#signIn").submit();
				}
			}
		});
		
		$("input").on("keydown", function(e) {
			if (e.keyCode == 13) {
				$("#signIn_btn").click();
			}
		});
	});
</script>
</body>
</html>