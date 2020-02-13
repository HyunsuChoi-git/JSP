<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/JSP/jsp0211/style.css" rel="stylesheet" type="text/css">
</head>
<c:if test="${admCheck == false}">
	<script>
		alert("접근 오류.")
		window.location.href="/JSP/member/main.win";
	</script>
</c:if>
<c:if test="${admCheck == true}">
<body>
	<br />
	<h1 align="center"> 관리자 페이지 </h1>
	<table>
		<tr>
			<td>관리자님 환영합니다.<br />
				<button onclick="window.location.href='/JSP/member/logout.win'" >로그아웃</button>
			</td>
		</tr>
	</table>
	<br /><br />
	<div align="center">
	<button onclick="window.location.href='/JSP/member/admin_member.win'" >회원 리스트</button>
	<button onclick="window.location.href='/JSP/board/list.be'" >게시판</button>
	</div>
	<br /><br />
	<div align="center">
		<img src="/JSP/jsp0211/img/beach.jpg" width="700" />
	</div>
</body>
</body>
</c:if>
</body>
</html>