<%@page import="web.member.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dto" class="web.member.model.MemberDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%
	String id = (String)session.getAttribute("sId");
	dto.setId(id);
	
	MemberDAO dao = new MemberDAO();
	dao.modify(dto);
%>
<body>
<% 
	String pw = null, auto = null;
	if(id == null) { 
		Cookie[] coo = request.getCookies();
		for(Cookie c : coo){
			if(c.getName().equals("cId")) id = c.getValue();
			if(c.getName().equals("cPw")) pw = c.getValue();
			if(c.getName().equals("cAuto")) auto = c.getValue();
			if(id == null || pw == null || auto == null) {%>
				<script>
				alert("로그인이 필요한 페이지입니다.");
				window.location.href="b_login.jsp";			
				</script>
			<% }else{
				session.setAttribute("sId", id);
			}
		}
	}else{ %>
	<br />
	<h1 align="center">회원 정보 수정</h1>
		<table>
			<tr>
				<td colspan="2" align="center"><%=id%>의 정보가 수정되었습니다.</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button onclick="window.location.href='c_main.jsp'">메인으로</button>
				</td>
			</tr>
		</table>
<%} %>
</body>
</html>