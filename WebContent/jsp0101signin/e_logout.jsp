<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%
	//세션이 있는 경우
	//세션은 없지만 쿠키가 있는 경우 진행
	
	//세션 없으면 경고창 -->메인
	
	String sId = (String)session.getAttribute("sId");
	String cId = null;
	Cookie[] coo = request.getCookies();
	for(Cookie c : coo){
		if(c.getName().equals("cId")) cId = c.getValue(); 
	}
	if(sId == null && cId == null){ %>
		<script>
			alert("접근 오류.");
			window.location.href='b_loginPro.jsp';
		</script>
<%		
	}else{
		session.invalidate();
		if(cId != null){
			for(Cookie c : coo){
				if(c.getName().equals("cId")){
					c.setMaxAge(0);
					response.addCookie(c);
				}
			}
		} %>
		<script>
			alert("로그아웃 되었습니다.");
			window.location.href='e_main.jsp';
		</script>
		
<% 	}%>
<body>

</body>
</html>