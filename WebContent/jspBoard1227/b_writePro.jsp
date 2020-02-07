<%@page import="java.sql.Timestamp"%>
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
%>
<jsp:useBean id="article" class="web.jspBoard1227.model.BoardDTO" />
<jsp:setProperty property="*" name="article" />
<%
	BoardDAO dao = new BoardDAO();
	article.setReg(new Timestamp(System.currentTimeMillis()));
	article.setIp(request.getRemoteAddr());

	dao.insertArticle(article);

	//내맘대로 num 받아와서 작성글 보기 버튼 성공시키기 !!
	int num = dao.articleNum(article);
	System.out.println(num);
%>
<body>
	<table>
		<tr>
			<td>게시글이 등록되었습니다.</td>
		</tr>
		<tr>
			<td>
				<button onclick="window.location.href='c_content.jsp?num=<%=num%>'">작성글 보기</button>
				<button onclick="window.location.href='a_list.jsp'">목록으로</button>
			</td>
		</tr>
	</table>
</body>
</html>