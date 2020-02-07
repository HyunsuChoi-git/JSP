<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>회사소개  인재채용  제휴제안  이용약관  개인정보처리방침  고객센터</p>
	
	

		<% Calendar today = (Calendar)request.getAttribute("today"); %>
		오늘날짜 : <%= today.YEAR %>년 <%= today.MONTH %>월 <%=today.DATE %>일
		현재시간 : <%= today.HOUR %>시 <%= today.MINUTE %>분 <%=today.SECOND %>초

</body>
</html>