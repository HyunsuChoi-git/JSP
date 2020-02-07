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
//1. 수기로 넘겨줄 데이터 생성 및 초기화
int num = 0, ref = 1, re_step = 0, re_level = 0;

if(request.getParameter("num") != null ){
	num = Integer.parseInt(request.getParameter("num"));
	ref = Integer.parseInt(request.getParameter("ref"));
	re_step = Integer.parseInt(request.getParameter("re_step"));
	re_level = Integer.parseInt(request.getParameter("re_level"));
}

%>
<body>
<h1>작성하기</h1>
<form action="b_writePro.jsp" method="post">
	<input type="hidden" name="num" value="num"/>
	<input type="hidden" name="ref" value="ref"/>
	<input type="hidden" name="re_step" value="re_step"/>
	<input type="hidden" name="re_level" value="re_level"/>
	
	<table>
		<tr>
			<td>제목</td>
			<td align="left">
			<input type="text" name="subject" /></td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td align="left"><input type="text" name="writer" /></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td align="left"><input type="text" name="email" /></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td align="left"><input type="password" name="pw" /></td>
		</tr>
		<tr>
			<td colspan="2">내용</td>
		</tr>
		<tr>
			<td colspan="2"><textarea rows="20" cols="80"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="submit" value="등록" /> 
				<input type="reset" value="다시쓰기" /> 
				<input type="button" value="뒤로가기" onclick="history.go(-1)"/> 
			</td>
		</tr>
	</table>
</form>

</body>
</html>