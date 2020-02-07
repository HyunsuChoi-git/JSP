<%@page import="web.jspBoard1227.model.BoardDAO"%>
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
	int num = Integer.parseInt(request.getParameter("num"));
	String pw = request.getParameter("pw");

	BoardDAO dao = new BoardDAO();
	int x = dao.delete(num, pw);
	
	if(x == 1){
	%>	
		<script>
			alert("삭제되었습니다.");
			window.location.href="a_list.jsp";
		</script>
	<%	
	}else if(x == 0){
	%>	
		<script>
			alert("시스템오류. 다시 시도해주세요.");
			history.go(-1);
		</script>
	<%		
	}else{
	%>	
		<script>
			alert("비밀번호가 일치하지 않습니다.");
			history.go(-1);
		</script>
	<%		
	}
	
%>
<body>

</body>
</html>