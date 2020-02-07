<%@page import="web.member.model.MemberDAO"%>
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
if(session.getAttribute("sId") != null){ %>
	alert("이미 로그인 상태입니다.");
	window.location.href="c_main.jsp";

<%}else{



String id = request.getParameter("id");
String pw = request.getParameter("pw");
String auto = request.getParameter("auto");

//---쿠키가 존재할 때 자동로그인 처리
	Cookie[] coo = request.getCookies();
	for(Cookie c : coo){
		if(c.getName().equals("cId")) id = c.getValue();
		if(c.getName().equals("cPw")) pw = c.getValue();
		if(c.getName().equals("cAuto")) auto = c.getValue();			
	}
//---
MemberDAO dao = new MemberDAO();
boolean r = dao.login(id, pw);

	if(r){
		session.setAttribute("sId", id);
		
		if(auto != null){
			Cookie c1 = new Cookie("cId", id);
			Cookie c2 = new Cookie("cPw", pw);
			Cookie c3 = new Cookie("cAuto", auto);
			
			c1.setMaxAge(60*60*24);
			c2.setMaxAge(60*60*24);
			c3.setMaxAge(60*60*24);
			
			response.addCookie(c1);
			response.addCookie(c2);
			response.addCookie(c3);
			
		}
		response.sendRedirect("c_main.jsp");
	}else{ %>
		<script>
			alert("아이디와 비밀번호를 다시 확인하세요");
			history.go(-1);
		</script>
	<%}
}
%>

<body>

</body>
</html>