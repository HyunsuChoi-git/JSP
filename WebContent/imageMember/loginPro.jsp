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
<!--	세션이 존재하면 경고창 띄운 후 main.jsp로 넘기기
	세션은 없지만 쿠키가 존재하면 경고창 띄운 후 loginPro.jsp로 넘기기 -->
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