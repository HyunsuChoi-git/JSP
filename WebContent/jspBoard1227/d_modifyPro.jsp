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
	request.setCharacterEncoding("UTF-8");	
	String pageNum = request.getParameter("pageNum");
%>
<jsp:useBean id="article" class="web.jspBoard1227.model.BoardDTO"></jsp:useBean>
<jsp:setProperty property="*" name="article"/>
<body>
<h1>수정하기</h1>

<%
	BoardDAO dao = new BoardDAO();
	int x = dao.modify(article);
	
	switch(x){
	case 1 : 
%>		
		<table>
			<tr>
				<td>글이 수정되었습니다. <br/>
				<button onclick="window.location.href='c_content.jsp?num=<%=article.getNum()%>'">작성글 확인</button>
				<button onclick="window.location.href='a_list.jsp?pageNum=<%=pageNum%>'">목록으로</button>
				</td>
			</tr>
		</table>
	
<% 		
	case 0 :
		%>
		<script>
			alert("시스템오류. 다시 시도해주세요.");
			history.go(-1);
		</script>
		<% 
	case -1 :
		%>
		<script>
			alert("비밀번호가 일치하지 않습니다.");
			history.go(-1);
		</script>
		<% 
	
	}
	
%>

</body>
</html>