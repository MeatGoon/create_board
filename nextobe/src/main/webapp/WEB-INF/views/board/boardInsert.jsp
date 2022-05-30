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
input, textarea {
	font-family: "나눔 바른 고딕", "Nanum Barun Gothic", "나눔 고딕", "Nanum Gothic", "맑은 고딕", "Malgun Gothic", helvetica, sans-serif; 
	font-size:18px; line-height:1.7;
}

*{
    box-sizing:border-box; -webkit-box-sizing: border-box; -moz-box-sizing: border-box; color: black;
}

.infoBox {
	width: 500px;
	list-style: none;
    margin:0px;
    padding:4px 0 4px;
    border: 1px solid black;
}
.infoBox>label {
	padding: 0 0 0 8px;
}
.infoBox{
	border: 1px solid black;
}

.btn {
	cursor: pointer;
}

textarea { 
	vertical-align: top;
	resize: none;
}
</style>
<body>
<h1>게시판 입력 페이지</h1>
	<form id="boardInsertInfo" action="./boardInsert" method="post" enctype="multipart/form-data">
		<div class="infoBox">
			<label for="title">제목 : </label><input type="text" name="title"/>
		</div>
		<div class="infoBox">
            <input type="file" name="fileUp" multiple="multiple">
		</div>
		<div class="infoBox">
			<label for="content">내용 : </label><textarea rows="10" cols="30" name="content"></textarea>
		</div>
		<div class="infoBox">
			<!-- 로그인 구현후 작성자는 동적으로 바꿀예정 -->
			<label for="writer">작성자 : </label><input type="text" name="writer" readonly="readonly" value='<c:out value="${userInfo.nickname}"></c:out>'/>
		</div>
		<button type="button" id="insert_btn" class="btn">등록</button>
		<button type="button" id="cancel_btn" class="btn">취소</button>
	</form>
	<form id="moveForm">
	
	</form>
	<script>
		let moveForm = $("#moveForm");
		$(document).ready(function() {
			let result = '<c:out value="${result}"/>';
			checkAlert(result);
			
			/* 컨트롤러의 요청이 어떻게 처리되었는지 알려주는 함수 */
		    function checkAlert(result){
		        if(result === ''){
		            return;
		        }
		        if (result === "login first") {
					var conResult = confirm("로그인 후 이용 바랍니다.");
					if (conResult) {
						moveForm.attr("action", "/user/signIn");
						moveForm.attr("method", "get");
						moveForm.submit();
					} else {
						history.go(-1);
					}
				}
		    }
		});
		
		$("#insert_btn").on("click", function(e) {
			let replaceContent = $("textarea[name=content]").val().replace(/\n/g, "<br />");
			$("textarea[name=content]").val(replaceContent);
			$("#boardInsertInfo").submit();
		});
		
		$("#cancel_btn").on("click", function() {
			moveForm.attr("action", "./boardList");
			moveForm.attr("method", "get");
			moveForm.submit();
		});

	</script>
</body>
</html>