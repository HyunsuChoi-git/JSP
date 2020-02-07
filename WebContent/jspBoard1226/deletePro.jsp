<%@page import="web.jspBoard1226.model.BoardDAO"%>
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

	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String pw = request.getParameter("pw");

	//db 접속해서 글 삭제
	BoardDAO dao = new BoardDAO();
	int x = dao.deleteArticle(num, pw);
	
	if(x == 1){
%>
		<table>
			<tr>
				<td>삭제가 완료되었습니다.</td>
			</tr>
			<tr>
				<td>
					<button onclick="window.location.href='list.jsp'">목록으로</button>
				</td>
			</tr>
		</table>
<%		
	}else if(x == 0){
%>		
		<script>
			alert("수정시 오류가 발생하였습니다.");
			history.go(-1);
		</script>		
<%	}else{
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