<%@page import="web.member.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<%
	String id = (String)session.getAttribute("sId");
	String cId = null, cPw = null, cAuto = null;
	//새션이 존재하면 메인페이지로 이동
	if(id != null){ %>
	<script>
		alert("로그인이 되어있는 상태입니다.");
		window.location.href="c_main.jsp";
	</script>
<% 	}else{
		//새션이 존재하지 않으나 쿠키가 존재하면 로그인프로페이지로 이동하여 새션생성
		Cookie[] coo = request.getCookies();
		for(Cookie c : coo){
			if(c.getName().equals("cId")) cId = c.getValue();
			if(c.getName().equals("cPw")) cPw = c.getValue();
			if(c.getName().equals("cAuto")) cAuto = c.getValue();
		}
		if(cId != null && cPw != null && cAuto != null){ %>
			<script>
				alert("로그인이 되어있는 상태입니다.");
				window.location.href="b_loginPro.jsp";
			</script>		
<%		}
	}	
//////////////////////////////////////////////////////////////
request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dto" class="web.member.model.MemberDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%
	MemberDAO dao = new MemberDAO();
	dao.signin(dto);
%>

<body>
<br />
	<h2 align="center">회원가입</h2>
	<table>
		<tr>
			<td colspan="2" align="center"> 회원가입이 완료되었습니다.</td>
		</tr>
		<tr>
			<td><button onclick="window.location.href='c_main.jsp'">메인으로</button></td>
		</tr>
	</table>

</body>
</html>