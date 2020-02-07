<%@page import="java.io.File"%>
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
	//pw 가 존재할 경우만 진행
	request.setCharacterEncoding("UTF-8");
	
	String sId = (String)session.getAttribute("sId");
	String pw = request.getParameter("pw");
	
	if(pw == null){ %>
		<script>
			alert("접근 오류");
			window.location.href='e_main.jsp';
		</script>
<%	}else{
		
		//회원탈퇴시 삭제할 회원 사진 변수에 담아놓기.
		M0101DAO dao = new M0101DAO();
		String img = dao.getImage(sId);
		
		
		int x = dao.delete(sId, pw);
		
		if(x == 1){
			//탈퇴완료. 세션, 쿠키 삭제
			session.invalidate();
			Cookie[] coo = request.getCookies();
			for(Cookie c : coo){
				if(c.getName().equals("cId")){
					c.setMaxAge(0);
					response.addCookie(c);
				}
			}
			
			//사진삭제
			if(img != null){
				File f = new File("D:\\hyunsu\\classclass\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\web\\save\\"+img);
				f.delete();
			}
			%>
			<script>
				alert("탈퇴가 완료되었습니다.");
				window.location.href='e_main.jsp';
			</script>
			
	<% 	}else if(x == 0){%>
			<script>
				alert("비밀번호가 일치하지 않습니다.");
				history.go(-1);
			</script>

	<%  }else {%>
			<script>
				alert("시스템 오류. 다시 시도해주세요.");
				history.go(-1);
			</script>	

	<%  }

	} %>	
<body>

</body>
</html>