<%@page import="web.upload1230.model.ImageDAO"%>
<%@page import="java.io.File"%>
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
	
	//2. 업로드파일 저장경로
	String path = request.getRealPath("save");
	//3. 파일 인코딩
	String enc = "UTF-8";
	//4. 파일크기
	int max = 1024*1024*5; 
	//5. 중복이름처리
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	
	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
	ImageDTO user = new ImageDTO();
	
	String ct = mr.getContentType("img");
	String sysName = mr.getFilesystemName("img");
	if(sysName != null){
		String[] file = ct.split("/");
		if(!(ct != null && file[0].equals("image"))){
			File f = new File(sysName);
			f.delete();
		%>
		<script type="text/javascript">
			alert("이미지파일이 아닙니다. 이미지파일을 업로드해주세요.");
			history.go(-1);
		</script>
		<%
		}
	}
	
	user.setId(mr.getParameter("id"));
	user.setPw(mr.getParameter("pw"));
	user.setName(mr.getParameter("name"));
	user.setBirth(mr.getParameter("birth"));
	user.setEmail(mr.getParameter("email"));
	user.setImg(sysName);
	
	//db에 저장
	
	ImageDAO dao = ImageDAO.getImageDAO();
	dao.insertMember(user);
	
%>
<body>
	<br/>
	<table>
		<tr>
			<td>가입완료!!<br/>
			<button onclick="window.location.href='main.jsp'">메인으로</button>
			</td>
		</tr>
	</table>

</body>
</html>