<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />

</head>
<%
	String id = (String)session.getAttribute("sId");
	//새션이 존재하지않으면 메인페이지로 이동
	String pw = null, auto = null;
	if(id == null) { 
		Cookie[] coo = request.getCookies();
		for(Cookie c : coo){
			if(c.getName().equals("cId")) id = c.getValue();
			if(c.getName().equals("cPw")) pw = c.getValue();
			if(c.getName().equals("cAuto")) auto = c.getValue();
			if(id == null || pw == null || auto == null) {%>
				<script>
				alert("로그인이 필요한 페이지입니다.");
				window.location.href="b_login.jsp";			
				</script>
			<% }else{
				session.setAttribute("sId", id);
			}
		}
	}else{
%>
<body>
	<br />
	<h1 align="center">회원탈퇴</h1>
	<table>
		<form  action="e_deletePro.jsp" method="post">
			<tr>
				<td colspan="2" align="center">
				비밀번호를 입력해주세요.<br/>
				<input type="password" name="pw" />
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="submit" value="탈퇴" />
				<input type="button" value="돌아가기" onclick="window.location.href='c_main.jsp'"/>
				</td>
			</tr>
		</form>
	</table>
	<%} %>
</body>
</html>