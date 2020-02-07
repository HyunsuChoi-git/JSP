<%@page import="web.upload1230.model.ImageDTO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="web.upload1230.model.ImageDAO"%>
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

//MultipartRequest 5가지 매개변수 준비
//2.
String path = request.getRealPath("save");
//3.
int max = 1024*1024*5;
//4.
String enc = "UTF-8";
//5.
DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();

//MultipartRequest 객체 생성
MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);


//이미지파일인지 아닌지 검사
String sysName = mr.getFilesystemName("img");
String contentType = mr.getContentType("img");
String[] type = contentType.split("/");


File g = new File(sysName);
System.out.println(g.getPath());

if(!(contentType != null && type[0].equals("image"))){
	File f = new File(sysName);
	f.delete();
%>
	<script>
		alert("이미지 파일이 아닙니다. 이미지 파일을 업로드 해주세요.");
		history.go(-1);
	</script>
<%
}

//DTO에 담기 
ImageDTO user = new ImageDTO();
user.setId(sId);
user.setPw(mr.getParameter("pw"));
user.setEmail(mr.getParameter("email"));
user.setBirth(mr.getParameter("birth"));
user.setImg(sysName);

//db에 저장하기
ImageDAO dao = ImageDAO.getImageDAO();
dao.modify(user);

%>
<body>
<h1 align="center">회원 정보 수정</h1>
		<table>
			<tr>
				<td>수정이 완료되었습니다.<br/>
				<button onclick="window.location.href='main.jsp'">메인으로</button><br/>
				</td>

</body>
</html>