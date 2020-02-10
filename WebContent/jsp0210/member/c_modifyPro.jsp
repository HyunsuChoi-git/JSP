<%@page import="java.io.File"%>
<%@page import="web.jsp0101.model.M0101DTO"%>
<%@page import="web.jsp0101.model.M0101DAO"%>
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
	//세션이 있는 경우에만 진행
	//세션이 없고 쿠키가 있는 경우에 세션 생성 후 진행
	//세션없고 쿠키도 없으면 경고창 -->메인
	
	
	String sId = (String)session.getAttribute("sId");
	String cId = null;
	Cookie[] coo = request.getCookies();
	for(Cookie c : coo){
		if(c.getName().equals("cId")) cId = c.getValue(); 
	}
	if(sId == null){
%>
		<script>
			alert("접근 오류.");
			window.location.href='b_loginPro.jsp';
		</script>
<%  }else{	
		request.setCharacterEncoding("UTF-8");
	
		String path = request.getRealPath("save");
		int max = 1024*1024*5;
		String enc = "UTF-8";
		DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
		MultipartRequest mr = null;
		
		try{
		
			mr = new MultipartRequest(request, path, max, enc, dp);
		}catch(Exception e){%>
			<script>
				alert("접근 오류.");
				window.location.href='b_loginPro.jsp';
			</script>
	 <% }
		String sysName = mr.getFilesystemName("img");
		String contentType = mr.getContentType("img");
		String[] ct = contentType.split("/");
		if(!(sysName != null && ct[0].equals("image"))){%>
			<script>
				alert("파일 업로드 실패. 이미지 파일을 업로드해주세요.");
				history.go(-1);
			</script>
    <%  }
		M0101DTO user = new M0101DTO();
		user.setId(sId);
		user.setPw(mr.getParameter("pw"));
		user.setBirth(mr.getParameter("birth"));
		user.setEmail(mr.getParameter("email"));
		user.setImg(sysName);
		
		M0101DAO dao = new M0101DAO();
		//사진삭제
		if(sysName != null){
			String img = dao.getImage(sId);
			File f = new File("D:\\hyunsu\\classclass\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\web\\save\\"+img);
			f.delete();
		}
		//업데이트
		dao.modify(user);
	%>
	<script>
		alert("정보가 수정되었습니다.");
		window.location.href="e_mypage.jsp";
	</script>

<%	} %>

<body>

</body>
</html>