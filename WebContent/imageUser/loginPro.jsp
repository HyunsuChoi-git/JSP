<%@page import="web.upload1230.model.ImageDAO"%>
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

	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String auto = request.getParameter("auto");
	
	ImageDAO dao = ImageDAO.getImageDAO();
	boolean b = dao.login(id, pw);
	System.out.println(b);

	if(b){
		if(auto != null){
			Cookie c = new Cookie("cId", id);
			c.setMaxAge(60*60*24);
			response.addCookie(c);
		}
		
		session.setAttribute("sId", id);	
		response.sendRedirect("main.jsp");
	}else{
	%>
		<script type="text/javascript">
			alert("아이디와 패스워드를 확인하세요.");
			history.go(-1);
		</script>
	<%
	}
%>
<body>
</body>
</html>