<%@page import="web.jsp0101.model.M0101DAO"%>
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
	//세션이 존재하면 접근오류/ 메인
	//세션이 존재하지 않으나 쿠키가 존재하면 세션 생성 후/ 메인
	String sId = (String)session.getAttribute("sId");
	Cookie[] coo = request.getCookies();
	if(sId != null && coo == null){ %>
 		<script>
 			alert("접근오류");
 			window.location.href="e_main.jsp";
 		</script>	
<%	}else{ //세션이 없거나, 쿠키가 존재할 때 
		String cId = null;
		if(coo != null){
			for(Cookie c : coo){
				if(c.getName().equals("cId")){ 
					cId = c.getValue();
					c.setMaxAge(60*60*24);
					response.addCookie(c);
					
					session.setAttribute("sId", cId);
					response.sendRedirect("e_main.jsp");
				}
			}               
		}
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String auto = request.getParameter("auto");
		
		if(id != null && pw != null){
		
		
			M0101DAO dao = new M0101DAO();
			boolean b = dao.login(id, pw);
			
			if(b){ 
				session.setAttribute("sId", id);
				if(auto != null){
					Cookie c = new Cookie("cId", id);
					c.setMaxAge(60*60*24);
					response.addCookie(c);
				}
				
				response.sendRedirect("e_main.jsp");
			}else{ %>
				<script>
					alret("아이디와 패스워드를 확인하세요.");
					history.go(-1);
				</script>
	<% 		} 
	
		}else{ %>
 			<script>
				alert("접근오류");
				window.location.href="e_main.jsp";
			</script>	
<%		}			
	}
%>
<body>

</body>
</html>