<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Main</title>
	<link href="/JSP/jsp0211/style.css" rel="stylesheet" type="text/css">
</head>

<c:if test="${check == false }">
<body>
	<br />
	<h1 align="center"> 메인페이지 </h1>
	<table>
		<tr>
			<td> 로그인 원하시면 버튼을 누르세요 <br />
				<button onclick="window.location.href='/JSP/member/loginForm.win'" >로그인</button>
			</td>
		</tr>
		<tr>
			<td>
				<a href="/JSP/member/signupForm.win" > 회원가입 </a>
			</td>
		</tr>
	</table>
	<br /><br /><br /><br />
	<div align="center">
		<img src="/JSP/jsp0211/img/beach.jpg" width="700" />
	</div>
</body>
</c:if>
	

	
<c:if test="${check == true }">
<body>
	<br />
	<h1 align="center"> 메인페이지 </h1>
	<table>
		<tr>
			<td>${sessionScope.memId }님 환영합니다.<br />
				<button onclick="window.location.href='/JSP/member/logout.win'" >로그아웃</button>
				<button onclick="window.location.href='/JSP/member/modify.win'" >회원정보 변경</button>
			</td>
		</tr>
	</table>
	<br /><br /><br /><br />
	<div align="center">
		<img src="/JSP/jsp0211/img/beach.jpg" width="700" />
	</div>
</body>
</c:if>
	


</html>