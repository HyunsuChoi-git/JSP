<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<body>

<br />
<%
	String id = (String)session.getAttribute("sId");
	String cId = null, cPw = null, cAuto = null;
	//세션이 존재하면 로그인 된 상태 
	if(id != null){ %>
		<h1 align="center">메인페이지</h1>
		<table>
			<tr>
				<td colspan="2" align="center"><%=id%>님 환영해요!!</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button onclick="window.location.href='c_mypage.jsp'">마이페이지</button>
					<button onclick="window.location.href='c_logout.jsp'">로그아웃</button>
				</td>
			</tr>
		</table>
	<%
	//세션이 존재하지 않을 때
	} else { 
		//쿠키가 존재하면 로그인 프로 페이지로 넘겨주기
		Cookie[] coo = request.getCookies();
		for(Cookie c : coo){
			if(c.getName().equals("cId")) cId = c.getValue();
			if(c.getName().equals("cPw")) cPw = c.getValue();
			if(c.getName().equals("cAuto")) cAuto = c.getValue();
		}
		if(cId != null && cPw != null && cAuto != null){
			response.sendRedirect("b_loginPro.jsp");
		}%>
		
			<h1 align="center">메인페이지</h1>
			<table>
				<tr>
					<td colspan="2" align="center">로그인이 필요합니다.</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button onclick="window.location.href='b_login.jsp'">로그인</button>
						<button onclick="window.location.href='a_signin.jsp'">회원가입</button>
					</td>
				</tr>
			</table>
<%	
	}
	%>
	<div align="center">
		<br/>
		<br/>
		<br/>
		<img src="img\aaaa1.jpg" width="400"/>
	</div>
</body>				

</head>
</html>