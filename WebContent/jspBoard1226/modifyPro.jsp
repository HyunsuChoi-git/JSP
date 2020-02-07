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
%>
<jsp:useBean id="article" class="web.jspBoard1226.model.BoardDTO" />
<jsp:setProperty property="*" name="article"/>

<%
	//페이지번호 
	String pageNum = request.getParameter("pageNum");
	
	
	//DB에 updateArticle() 로 작성 내용 수정하기
	BoardDAO dao = new BoardDAO();
	int x = dao.updateArticle(article);
	
	if(x == 1){ 
%>		
		<table>
			<tr>
				<td>수정이 완료되었습니다.</td>
			</tr>
			<tr>
				<td>
					<button onclick="window.location.href='list.jsp?pageNum=<%=pageNum%>'">목록으로</button>
					<button onclick="window.location.href='content.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">작성글 확인</button>
				</td>
			</tr>
		</table>
<%	
	}else if(x == -1){
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