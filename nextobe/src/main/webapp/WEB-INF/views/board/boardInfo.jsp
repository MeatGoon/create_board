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
input{
	border: none;
}
*{
    box-sizing:border-box; -webkit-box-sizing: border-box; -moz-box-sizing: border-box; color: black;
}


.infoBox {
	width: 500px;
	list-style: none;
    margin:0px;
    padding: 6px 0 6px;
    border: 1px solid black;
}
.infoBox>label {
	padding: 0 0 0 8px;
}
.infoBox{
	border: 1px solid black;
}
textarea { 
	vertical-align: top;
	resize: none;
}

.btn {
	cursor: pointer;
}
.file_size{
	color: blue;
}

</style>
<body>
<div>
	<h1>상세보기 페이지</h1>
	<button type="button" id="moveList_btn" class="btn">목록이동</button>
	<form id="boardInfo" action="/board/boardModify" method="post">
		<input type="hidden" name="bno" value="${boardInfo.bno}"/>
		<div class="infoBox">
			<label for="title">제목 : </label><input type="text" disabled="disabled" name="title" value="${boardInfo.title}"/>
		</div>
		<c:if test="${!empty fileInfo}">
			<div class="infoBox">
				<c:forEach var="fileInfo" items="${fileInfo}">
					<a href="./fileDownload?fno=${fileInfo.fno}">${fileInfo.org_file_name}</a>&nbsp;<span class="file_size">${fileInfo.file_size}kb</span><br />				
				</c:forEach>
			</div>
		</c:if>
		<div class="infoBox">
			<label for="content">내용 : </label><textarea rows="10" cols="30" name="content">${boardInfo.content}</textarea>
		</div>
		<div class="infoBox">
			<label for="writer">작성자 : </label><input type="text" disabled="disabled" name="writer" value="${boardInfo.writer}"/>
		</div>
		<div class="infoBox">
			<label for="regdate">작성일 : </label><input type="text" name="regdate" disabled="disabled" value="${boardInfo.regdate}">
		</div>
		<div class="infoBox">
			<label for="updatedate">마지막 수정일 : </label><input type="text" name="updatedate" disabled="disabled" value="${boardInfo.updatedate}" />
		</div>
		<c:if test="${userInfo.nickname eq boardInfo.writer}">
			<button type="button" id="modify_btn" class="btn">수정</button>
		</c:if>
		
	</form>
</div>
<form id="moveForm">
	<input type="hidden" name="bno" value="${boardInfo.bno}"/>
	<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"></c:out>' />
	<input type="hidden" name="amount" value='<c:out value="${cri.amount}"></c:out>' />
	${sessionScope.userid}
</form>
<script>
	let moveForm = $("#moveForm");
	$(document).ready(function() {
		let content = "${boardInfo.content}".replaceAll("<br />", "\r\n");
		$("textarea[name=content]").val(content);
		let result = '<c:out value="${result}"/>';
		checkAlert(result);
		
		/* 컨트롤러의 요청이 어떻게 처리되었는지 알려주는 함수 */
	    function checkAlert(result){
	        if(result === ''){
	            return;
	        }
	        if (result === "login first") {
				var conResult = confirm("로그인 먼저 해주시기 바합니다.");
				if (conResult) {
					moveForm.attr("action", "/user/signIn");
					moveForm.attr("method", "get");
					moveForm.submit();
				} else {
					history.go(-1);
				}
			}
	        if(result === "boardModify success"){
	            alert("수정이 완료되었습니다.");
	        }
	    } 
	});
	
	
	$("#modify_btn").on("click", function(){
		moveForm.attr("action", "./boardModify");
		moveForm.attr("method", "get");
		moveForm.submit();
	});
	$("#moveList_btn").on("click", function(){
		moveForm.attr("action", "./boardList");
		moveForm.attr("methid", "get");
		moveForm.submit();
	});
</script>
</body>
</html>