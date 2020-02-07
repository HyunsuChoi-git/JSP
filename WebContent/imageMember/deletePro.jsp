<%@page import="web.upload1230.model.ImageDAO"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	String sId = (String)session.getAttribute("sId");
	String pw = request.getParameter("pw");
	
	ImageDAO dao = ImageDAO.getImageDAO();
	String img = dao.deleteUser(sId, pw);
	if(img.equals("pw")){
	%>
		<script type="text/javascript">
			alert("비밀번호가 일치하지 않습니다..");
			history.go(-1);
		</script>		
	<%
	}else{
		//세션삭제
		//쿠키있으면 쿠키삭제
		//이미지 있으면 이미지 삭제
		
		session.invalidate();
		
		Cookie[] coo = request.getCookies();
		for(Cookie c : coo){
			if(c.getName().equals("cId")){
				c.setMaxAge(0);
				response.addCookie(c);
			}
		}
		
		if(img != null){
			File f = new File("D:\\hyunsu\\classclass\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\web\\save\\"+img);
			System.out.println(f.getPath());
			f.delete();
		}
%>
		<h1 align="center">회원탈퇴</h1>	
		<table>
			<tr>
				<td>
					탈퇴가 완료되었습니다. <br/>
					<button onclick="window.location.href='main.jsp'">메인으로</button>
				</td>
			</tr>
		</table>
		
<%
	}
%>


</body>
</html>