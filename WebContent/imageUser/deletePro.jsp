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
String sId = (String)session.getAttribute("sId");
String pw = request.getParameter("pw");

ImageDAO dao = ImageDAO.getImageDAO();
dao.deleteUser(sId, pw);


%>
<body>

</body>
</html>