<%@page import="web.upload1230.model.ImageDAO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="web.upload1230.model.ImageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />

<!-- 세션이 존재하면 경고창 띄운 후 메인으로, 
	쿠키가 존재할 경우 세션을 만들어준 후 메인으로 넘기기 -->
</head>
<%
	request.setCharacterEncoding("UTF-8");
	
	//2.파일 저장 경로
	String path = request.getRealPath("save");
	//3.파일 최대 크기
	int max = 1023*1024*5;
	//4.인코딩 타입
	String enc = "UTF-8";
	//5.덮어쓰기 방지
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();

	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
	
	
	String id = mr.getParameter("id");
	String pw = mr.getParameter("pw");
	String name = mr.getParameter("name");
	String birth = mr.getParameter("birth");
	String email = mr.getParameter("email");
	String sysName = mr.getFilesystemName("img"); //업로드파일면
	String contentType = mr.getContentType("img"); //파일종류
	
	if(contentType != null) {
		String[] imageType = contentType.split("/");
		if(!(contentType != null && imageType[0].equals("image"))){
			File file = mr.getFile("img");
			sysName = null;
			file.delete();
			%>
			<script>
				alert("이미지 파일이 아닙니다. 이미지를 다시 등록하세요.");
				history.go(-1);
			</script>
			<%
		}
	}
	ImageDTO dto = new ImageDTO();
	dto.setId(id);
	dto.setPw(pw);
	dto.setName(name);
	dto.setBirth(birth);
	dto.setEmail(email);
	dto.setImg(sysName);
	
	ImageDAO dao = ImageDAO.getImageDAO();
	dao.insertMember(dto);
	
%>
<body>
	<h1 align="center">회원가입</h1>
	<table>
		<tr>
			<td>
				회원가입이 완료되었습니다. <br/>
				<button onclick="window.location.href='main.jsp'">메인으로</button>
			</td>
		</tr>
	</table>
</body>
</html>