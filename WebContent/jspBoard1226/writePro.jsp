<%@page import="web.jspBoard1226.model.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
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
	//글 작성 form 페이지에서 넘어오는 데이터를 받아서 DB에 저장
	//작성자, 제목, email, 글내용, 비밀번호
		
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="article" class="web.jspBoard1226.model.BoardDTO"/>
<jsp:setProperty property="*" name="article"/>

<%
	//form에서 넘어오지 않는 데이터 수동으로 채우기
	//시스템 클래스에 있는 현재시간을 가져와 Timestamp에 저장하기
	article.setReg(new Timestamp(System.currentTimeMillis()));
	article.setIp(request.getRemoteAddr());
	
	
	//DB에 저장
	BoardDAO dao = new BoardDAO();
	int num = dao.insertArticle(article);
%>
<body>
	<h1 align="center">글 저장 완료</h1>
	<table>
		<tr>
			<td>
				<input type="button" value="목록으로" onclick="window.location.href='list.jsp'"/>
				<input type="button" value="작성글 확인" onclick="window.location.href='content.jsp?num=<%=num%>'"/>
			</td>
		</tr>
	</table>
	
</body>
</html>