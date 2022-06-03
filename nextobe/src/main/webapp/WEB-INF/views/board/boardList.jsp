<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- 필수, SheetJS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<!--필수, FileSaver savaAs 이용 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
<style>
.contentContainer > table{
	border-collapse: collapse;
	width: 1000px;
}
.boardRow:hover {
	background-color : rgba(0,0,0,0.3);
	opacity: 0.8;
	cursor: pointer;
}
th {
	border-bottom: 2px solid black;
}
th, td {
	padding: 5px 0 5px;
	width: auto;
}
	
#pageInfo{
    list-style : none;
    display: inline-block;
    margin: 50px 0 0 100px;      
}
#pageInfo li{
    float: left;
    font-size: 20px;
    margin-left: 18px;
    padding: 7px;
    font-weight: 500;
}
.active{
    background-color: #cdd5ec;
}
.hidden_btn{
	display: none;
}
a:link {color:black; text-decoration: none;}
a:visited {color:black; text-decoration: none;}
a:hover {color:black; text-decoration: underline;}
</style>
</head>
<body>
<h1>게시판 목록</h1>
<div class="mainContainer">
	<div class="topContainer">
		<c:choose>
			<c:when test="${!empty userInfo}">
				<button type="button" id="logout_btn">로그아웃</button>
			</c:when>
			<c:otherwise>
				<button type="button" id="login_btn">로그인</button>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="contentContainer">
	<button type="button" id="insertBoard">게시판 등록</button>
	<select class="change_amount">
	<!-- 
		<option value="5" <c:if test="${pageMaker.cri.amount eq 5}">selected</c:if>>5개씩 보기</option>
		<option value="10" <c:if test="${pageMaker.cri.amount eq 10}">selected</c:if>>10개씩 보기</option>
		<option value="15" <c:if test="${pageMaker.cri.amount eq 15}">selected</c:if>>15개씩 보기</option>
		<option value="20" <c:if test="${pageMaker.cri.amount eq 20}">selected</c:if>>20개씩 보기</option>
	 -->
	 <!-- 
		<option value="5" ${pageMaker.cri.amount == 5 ? "selected":""}>5개씩 보기</option>
		<option value="10" ${pageMaker.cri.amount == 10 ? "selected":""}>10개씩 보기</option>
		<option value="15" ${pageMaker.cri.amount == 15 ? "selected":""}>15개씩 보기</option>
		<option value="20" ${pageMaker.cri.amount == 20 ? "selected":""}>20개씩 보기</option>
	 -->
		<c:forEach var="selNum" begin="1" end="4">
			<option value="${selNum * 5}" ${pageMaker.cri.amount == selNum * 5 ? "selected":""}>${selNum * 5}개씩 보기</option>
		</c:forEach>
		
	</select>
		<table border="2" id="tableData">
			<tr>
				<th class="hidden_btn">체크</th>
				<th>순번</th>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			<c:forEach items="${bAllList}" var="bAllList">
				<tr class="boardRow" onclick="boardInfo(${bAllList.bno})">
					<td onclick="event.cancelBubble=true" class="hidden_btn"><input value="${bAllList.bno}" type="checkbox" id="excelChek" class="hidden_btn" style="border: none;"/></td>
				 	<td>${bAllList.rn}</td>
					<td>${bAllList.bno}</td>
					<td>${bAllList.title}</td>
					<td>${bAllList.writer}</td>
					<td>${bAllList.regdate}</td>
				</tr>
			</c:forEach>
		</table>
		<button type="button" id="excelFileExport">엑셀 저장</button>
	</div>
	<div class="bottomContainer">
	</div>
	<div class="pageInfo_wrap">
		<div class="pageInfo_area">
			<ul id="pageInfo">
			<!-- 기존 소스로 업데이트 가능할거 같은 기능 처음으로, 맨뒤로 -->
                <c:if test="${pageMaker.prev}">
                    <li class="pageInfo_btn previous"><a href="${pageMaker.startPage-1}">&lt;</a></li>
                </c:if>
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                    <li class="pageInfo_btn ${pageMaker.cri.pageNum == num ? "active":"" }"><a href="${num}">${num}</a></li>
                </c:forEach>
                <c:if test="${pageMaker.next}">
                    <li class="pageInfo_btn next"><a href="${pageMaker.endPage + 1 }">&gt;</a></li>
                </c:if>    
			</ul>
		</div>
	</div>
	<form id="moveForm" method="get">
		<input type="hidden" name="checkedData">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">   
	</form>
</div>
<script>
	$(document).ready(function() {
		let result = '<c:out value="${result}"/>';
		checkAlert(result);
		let saveExcel = false;
		
		
		/* 컨트롤러의 요청이 어떻게 처리되었는지 알려주는 함수 */
	    function checkAlert(result){
	        if(result === ''){
	            return;
	        }
	        if(result === "boardInsert success"){
	            alert("등록이 완료되었습니다.");
	        }
	        if(result === "boardDelete success"){
	            alert("삭제가 완료되었습니다.");
	        }
	    }
		$("#excelFileExport").on("click", function() {
			if (${userInfo ne null}) {
				if (saveExcel != false) {
					var checkedData = new Array();
					$('input:checkbox[id=excelChek]:checked').each(function() {
						checkedData.push($(this).val());
						console.log(checkedData);
						});
					if (checkedData.length != 0) {
						moveForm.find("input[name='checkedData']").val(checkedData);
						moveForm.attr("action", "./excelDownload");
						moveForm.attr("method", "post");
						moveForm.submit();
					} else {
						alert("다운 받을 게시물을 클릭해주세요.")
					}
					
				} else {
					$(".hidden_btn").show();	
					saveExcel = true;
				}
			} else{
				var conResult = confirm("로그인 먼저 해주시기 바합니다.");
				if (conResult) {
					moveForm.attr("action", "/user/signIn");
					moveForm.attr("method", "get");
					moveForm.submit();
				} else {
					return;
				}
			}
			
		});
	});
	
	window.onpageshow = (event) => {
		if (event.persisted) {
			window.location.reload();
		}
	};
	
	let moveForm = $("#moveForm");
	
	function boardInfo(bno) {
		moveForm.append("<input type='hidden' name='bno' value='"+bno+"' />");
		moveForm.attr("action", "./boardInfo");
		moveForm.submit();
	}
	
	$("#insertBoard").on("click", function() {
		moveForm.attr("action", "./boardInsert");
		moveForm.submit();
	});
	$("#pageInfo a").on("click", function(e) {
        e.preventDefault();
        moveForm.find("input[name='pageNum']").val($(this).attr("href"));
        moveForm.attr("action", "./boardList");
        moveForm.submit();
	});
	$(".change_amount").on("change", function() {
		moveForm.find("input[name='amount']").val($(this).val());
		moveForm.submit();
	});
	
	$("#login_btn").on("click", function() {
		moveForm.attr("action", "/user/signIn");
		moveForm.submit();
	});
	
	$("#logout_btn").on("click", function() {
		moveForm.attr("action", "/user/logout");
		moveForm.attr("method", "post");
		moveForm.submit();
	});
</script>
</body>
</html>