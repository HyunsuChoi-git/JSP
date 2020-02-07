<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%
	request.setAttribute("name", "피카츄"); //임의로 넣어놓은 것
%>
<body>
	<%--<h2>${ "10" + 10 }</h2>
	<h2>${ "하이" + 10 }</h2> 
	<h2>${ null + 10 }</h2>--%>


	요청 URI  :  ${ pageContext.request.requestURI } <br/>
	request의 속성  :  ${ requestScope.name }		   <br/>
	파라미터  :  ${ param.test }					   <br/>
	이름만 적어도 나오지롱  :  ${ name }
	
	
</body>
</html>