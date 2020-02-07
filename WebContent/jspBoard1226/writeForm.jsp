<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<%
	// 글번호, 그룹, 정렬순서, 답글 레벨 선언 -> 초기화
	// DB에 들어가야 할 데이터들 초기화해서 변수에 담아 데이터 보내기
	
	int num = 0, ref = 1, re_step = 0, re_level = 0;
	//num(새글 작성일 때 0, 답글 1이상), ref는 기본 그룹 1
	
	//답글 작성인 경우 로직 (num, ref, re_step, re_level 가져옴)
	if(request.getParameter("num") != null){
		//정보 담기
		num = Integer.parseInt(request.getParameter("num"));
		ref = Integer.parseInt(request.getParameter("ref"));
		re_step = Integer.parseInt(request.getParameter("re_step"));
		re_level = Integer.parseInt(request.getParameter("re_level"));
		
	}
%>
<body>
	<br/>
	<h1 align="center">글 작성</h1>
	
	<form action="writePro.jsp" method="post">
		<%-- 위 초기화한 데이터 hidden타입으로 넘겨주기--%>
		<input type="hidden" name="num" value="<%= num %>"/>
		<input type="hidden" name="ref" value="<%= ref %>"/>
		<input type="hidden" name="re_step" value="<%= re_step %>"/>
		<input type="hidden" name="re+level" value="<%= re_level %>"/>
		
		<table>
			<tr>
				<td> 작성자 </td>
				<td align="left"><input type="text" name="writer"/></td>
			</tr>
			<tr>
				<td> 제  목 </td>
				<td align="left">
				<% if(request.getParameter("num") == null){ %>
						<input type="text" name="subject"/>
				<% }else{ %>		
						<input type="text" name="subject" value="[답글]"/>
				<% } %>
				</td>
			</tr>
			<tr>
				<td> 이메일 </td>
				<td align="left"><input type="text" name="email"/></td>
			</tr>
			<tr>
				<td colspan="2"> 내  용 </td>
			</tr>
			<tr>
				<td colspan="2" align="justify"><textarea rows="20" cols="70" name="content"></textarea></td>
			</tr>
			<tr>
				<td> 비밀번호 </td>
				<td align="left"><input type="password" name="pw"/></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="저장"/>
					<input type="reset" value="재작성"/>
					<input type="button" value="돌아가기" onclick="window.location.href='list.jsp'"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>