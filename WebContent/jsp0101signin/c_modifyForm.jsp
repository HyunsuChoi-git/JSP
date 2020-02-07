<%@page import="web.jsp0101.model.M0101DTO"%>
<%@page import="web.jsp0101.model.M0101DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<script>
	function check(){
		var sign = document.signin;
		
	}
</script>
</head>
<%
	//세션이 있는 경우에만 진행
	//세션이 없고 쿠키가 있는 경우에 세션 생성 후 진행
	//세션없고 쿠키도 없으면 경고창 -->메인
	
	
	String sId = (String)session.getAttribute("sId");
	String cId = null;
	Cookie[] coo = request.getCookies();
	for(Cookie c : coo){
		if(c.getName().equals("cId")) cId = c.getValue(); 
	}

	if(sId == null && cId == null){
%>
		<script>
			alert("로그인 후 이용하능한 페이지입니다.");
			window.location.href='e_main.jsp';
		</script>
<%  }else if(sId == null && cId != null){
		session.setAttribute("sId", cId);
		System.out.println(cId);
		response.sendRedirect("c_modifyForm.jsp");
	}else{
	
		M0101DAO dao = new M0101DAO();
		M0101DTO user = dao.getUser(sId);
%>
		
<body>
	<br/>
	<h1>회원 정보 수정</h1>
	<form name="action" action="c_modifyPro.jsp" method="post" encType="multipart/form-data">
		<table>
			<tr>
				<td>아이디 *</td>
				<td><%= user.getId() %></td>
			</tr>
			<tr>
				<td>비밀번호 *</td>
				<td><input type="password" name="pw" value="<%=user.getPw() %>"/></td>
			</tr>
			<tr>
				<td>비밀번호 확인*</td>
				<td><input type="password" name="pw2" /></td>
			</tr>
			<tr>
				<td>이름 *</td>
				<td><%=user.getName() %></td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td><input type="text" name="birth" value="<%=user.getBirth() %>" /></td>
			</tr>
			<tr>
				<td>Email</td>
				<td><input type="text" name="email" value="<%=user.getEmail() %>"/></td>
			</tr>
			<tr>
				<td>프로필사진</td>
				<% //프로필 사진이 존재하면 보여주고 아니면 기본 이미지
				if(user.getImg() != null){ %>
					<td><img src="<%=user.getImg() %>" width="200"/> <br/>
				<% }else{ %>
					<td><img src="/web/save/defaultimg.jpg" width="200"/> <br/>
				<% } %>
				<input type="file" name="img"/></td>
			</tr>
			<tr>
				<td>가입일</td>
				<td><%=user.getReg() %></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="수정" /> <input
					type="button" value="취소" onclick="window.location.href='e_mypage.jsp'"/></td>
			</tr>
		
		</table>
	</form>
</body>

<%		
	}
%>
</html>