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

textarea { 
	vertical-align: top;
	resize: none;
}


.btn {
	cursor: pointer;
}
</style>
<body>
<div>
	<h1>상세보기 페이지</h1>
	<button type="button" id="moveList_btn" class="btn">목록이동</button>
	<form id="boardInfo" action="./boardModify" method="post">
		<input type="hidden" name="bno" value="${boardInfo.bno}"/>
		<div class="infoBox">
			<label for="title">제목 : </label><input type="text" name="title" value="${boardInfo.title}"/>
		</div>
		<div class="infoBox">
			<label for="content">내용 : </label><textarea rows="10" cols="30" name="content">${boardInfo.content}</textarea>
		</div>
		<div class="infoBox">
			<label for="writer">작성자 : </label><input style="border: none" type="text" name="writer" readonly="readonly" value="${boardInfo.writer}"/>
		</div>
		<div class="infoBox">
			<label for="regdate">작성일 : </label><input type="text" name="regdate" disabled="disabled" value="${boardInfo.regdate}">
		</div>
		<div class="infoBox">
			<label for="updatedate">마지막 수정일 : </label><input type="text" name="updatedate" disabled="disabled" value="${boardInfo.updatedate}" />
		</div>
		<button type="button" id="modify_btn" class="btn">수정완료</button>
		<button type="button" id="cancel_btn" class="btn">수정취소</button>
		<button type="button" id="delete_btn" class="btn">삭제</button>
		
		<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"></c:out>' />
		<input type="hidden" name="amount" value='<c:out value="${cri.amount}"></c:out>' />
	</form>
</div>
<form id="moveForm">
	<input type="hidden" name="bno" value="${boardInfo.bno}"/>
	<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"></c:out>' />
	<input type="hidden" name="amount" value='<c:out value="${cri.amount}"></c:out>' />
</form>
<script>
	let moveForm = $("#moveForm");
	
	$(document).ready(function() {
		let content = "${boardInfo.content}".replaceAll("<br />", "\r\n");
		$("textarea[name=content]").val(content);
		
		let result = '<c:out value="${result}"/>';
		checkAlert(result);
        if (${userInfo.nickname ne boardInfo.writer}) {
        	alert(${userInfo.nickname});
        	alert("잘못된 접근입니다.");
        	history.go(-1);
		}
		
		/* 컨트롤러의 요청이 어떻게 처리되었는지 알려주는 함수 */
	    function checkAlert(result){
	        if(result === ''){
	            return;
	        }
	        if (result === "login first") {
				alert("잘못된 접근입니다.");
				history.go(-1);
			}
	    } 
	});
	
	// 페이징 처리된 목록으로 이동
	$("#moveList_btn").on("click", function(){
		moveForm.attr("action", "./boardList");
		moveForm.attr("methid", "get");
		moveForm.submit();
	});
	// update 실행
	$("#modify_btn").on("click", function(){
		let replaceContent = $("textarea[name=content]").val().replace(/\n/g, "<br />");
		$("textarea[name=content]").val(replaceContent);
		$("#boardInfo").submit();
	});
	// 페이징 정보와 같이 상세 정보로 이동
	$("#cancel_btn").on("click", function(){
		moveForm.attr("action", "./boardInfo");
		moveForm.attr("methid", "get");
		moveForm.submit();
	});
	// delete 실행후 목록으로 이동
	$("#delete_btn").on("click", function(){
		moveForm.attr("action", "./boardDelete");
		moveForm.attr("method", "post");
		moveForm.submit();
	});

</script>
</body>
</html>