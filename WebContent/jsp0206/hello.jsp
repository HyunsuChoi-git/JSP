<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1> hello VIEW page </h1>
	
	<h3><%=request.getAttribute("num") %></h3>
	<h3><%=request.getAttribute("name") %></h3>
	
	<h2><%=session.getAttribute("memId") %></h2>
	
</body>
</html>