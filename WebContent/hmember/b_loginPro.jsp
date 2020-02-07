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
String id = request.getParameter("id");
String pw = request.getParameter("pw");
String auto = request.getParameter("auto");

//쿠키가 남아있는 경우에는 쿠키데이터를 위 변수에 올려주기
Cookie[] coo = request.getCookies();
	for(Cookie c : coo){
		if(c.getName().equals("cId")) id = c.getValue();
		if(c.getName().equals("cPw")) pw = c.getValue();
		if(c.getName().equals("cAt")) auto = c.getValue();
	}
//

HDAO dao = new HDAO();
boolean b = dao.login(id, pw);

if(b){
	session.setAttribute("sId", id);
	
	if(auto != null){
		Cookie c1 = new Cookie("cId", id);
		Cookie c2 = new Cookie("cPw", pw);
		Cookie c3 = new Cookie("cAt", auto);
		
		c1.setMaxAge(60*60*24);
		c2.setMaxAge(60*60*24);
		c3.setMaxAge(60*60*24);

		response.addCookie(c1);
		response.addCookie(c2);
		response.addCookie(c3);
	}
	
	response.sendRedirect("c_main.jsp");
}else{ 
	if(session.getAttribute("sId") != null){
		response.sendRedirect("c_main.jsp");		
	}else{ %>
	<script>
		alert("아이디와 비밀번호를 확인하세요");
		history.go(-1);
	</script>	
<%	}
}
%>
<body>
	
</body>
</html>