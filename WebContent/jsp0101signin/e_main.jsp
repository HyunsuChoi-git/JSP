<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<br/>
	<h1>메인 페이지</h1>
<%
	//세션이 없으면 로그인 버튼
	//세션없지만 쿠키 있으면 loginPro.jsp로 이동
	//세션이 있으면 마이페이지, 로그아웃 버튼
	String sId = (String)session.getAttribute("sId");
	if(sId == null){
		Cookie[] coo = request.getCookies();
		for(Cookie c : coo){
			if(c.getName().equals("cId")) { %>
			<script>
				window.location.href="b_loginPro.jsp";
			</script>
		<%	}
		} %>
		<table>
			<tr>
				<td>
					로그인이 필요합니다.<br/>
					<button onclick="window.location.href='b_loginForm.jsp'">로그인</button>
				</td>
			</tr>
		
		</table>
<% 	}else{ %>
		<table>
			<tr>
				<td><%=sId %>님 환영합니다.</td>
			</tr>
			<tr>
				<td>
				<button onclick="window.location.href='e_mypage.jsp'">마이페이지</button>
				<button onclick="window.location.href='e_logout.jsp'">로그아웃</button>
				</td>
			</tr>
		</table>
		
<%	} %>

</body>
</html>