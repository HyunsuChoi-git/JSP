<%@page import="java.io.File"%>
<%@page import="web.upload1230.model.ImageDAO"%>
<%@page import="web.upload1230.model.ImageDTO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
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
	request.setCharacterEncoding("UTF-8");
	String sId = (String)session.getAttribute("sId");


	String path = request.getRealPath("save");
	int max = 1024*1024*5;		//5M
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	String contentType = mr.getContentType("img");
	String sysName = mr.getFilesystemName("img");
	//이미지파일인지 아닌지 검사
	String[] type = contentType.split("/");
	if( !(contentType != null && type[0].equals("image")) ){
		File f = mr.getFile("img");
		f.delete();
	%>
		<script type="text/javascript">
			alert("이미지 파일이 아닙니다. 다시 업로드해주세요.");
			history.go(-1);
		</script>	
	<% 
	}
	
	
	ImageDTO user = new ImageDTO();
	ImageDAO dao = ImageDAO.getImageDAO();
	
	user.setId(sId);
	user.setPw(mr.getParameter("pw"));
	user.setBirth(mr.getParameter("birth"));
	user.setEmail(mr.getParameter("email"));
	user.setImg(sysName);
	dao.modify(user);
	
%>
<body>
	<h1 align="center">회원정보 수정</h1>
	<table>
		<tr>
			<td>회원정보 수정이 완료되었습니다.</td>
		</tr>
		<tr>
			<td><button onclick="window.location.href='main.jsp'">메인으로</button></td>
		</tr>
	</table>

</body>
</html>