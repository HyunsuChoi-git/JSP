<%@page import="web.bmember.model.HDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="hmemberStyle.css" rel="stylesheet" type="text/css" />
</head>
<%
String id = (String)session.getAttribute("sId");
String pw = request.getParameter("pw");
if(pw != null){
	HDAO dao = new HDAO();
	boolean b = dao.delete(id, pw);
	
	if(b){
		session.invalidate();
		
		Cookie[] coo = request.getCookies();
		for(Cookie c : coo){
			if(c.getName().equals("cId")){
				c.setMaxAge(0);
				response.addCookie(c);
			}
			if(c.getName().equals("cPw")){
				c.setMaxAge(0);
				response.addCookie(c);
			}
			if(c.getName().equals("cAt")){
				c.setMaxAge(0);
				response.addCookie(c);
			}
		}
%>		
<body>
	<h1>회원탈퇴</h1>
	<table>
		<form action="c_main.jsp" method="post">
			<tr>
				<td colspan="2">탈퇴가 완료되었습니다.</td>
			</tr>
			<tr>
				<td>
				<input type="submit" value="메인으로"/>
				</td>
			</tr>
		</form>
	</table>
</body>
<% 	
	}else{
%>
<script type="text/javascript">
	alert("비밀번호가 일치하지 않습니다.");
	history.go(-1);
</script>
<%		
	}
}else{
%>
	<script>
		alert("비정상적인 접근입니다.");
		window.location.href="c_main.jsp";
	</script>
<%	
}
%>
</html>