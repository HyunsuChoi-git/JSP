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
	//세션이 있거나 
	//세션은 없지만 쿠키가 있는 경우에만 진행 (세션 생성)
	
	//세션 없으면 경고창-->메인
	String sId = (String)session.getAttribute("sId");
	if(sId == null){
		Cookie[] coo = request.getCookies();
		for(Cookie c : coo){
			if(c.getName().equals("cId")){
				sId = c.getValue();
				session.setAttribute("sId", sId);
			}else{
				%>
				<script>
					alert("로그인 후 이용하능한 페이지입니다.");
					window.location.href='e_main.jsp';
				</script>
				<%
			}
		}
	}
%>
<body>
	<br/>
	<h1>마이페이지</h1>
	<table>
		<tr>
			<td><%=sId %>님의 마이페이지 입니다. <br/>
				<button onclick="window.location.href='c_modifyForm.jsp'">회원정보수정</button>
				<button onclick="window.location.href='d_deleteForm.jsp'">회원탈퇴</button>
			</td>
		</tr>
		<tr>
			<td>
				<button onclick="window.location.href='e_main.jsp'">메인으로</button> 
			</td>
		</tr>
	</table>

</body>
</html>