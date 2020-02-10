<%@page import="web.jsp0101.model.M0101DAO"%>
<%@page import="java.io.File"%>
<%@page import="web.jsp0101.model.M0101DTO"%>
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
	//세션이 있으면 바로 메인
	//세션없지만 쿠키 있으면 세션 생성 후 메인
	//세션과 쿠키 둘 다 없을 경우만 진행
	
	String sId = (String)session.getAttribute("sId");
	if(sId != null){ %>
 		<script>
 			alert("접근오류");
 			window.location.href="e_main.jsp";
 		</script>	
<%	}else{
		Cookie[] coo = request.getCookies();
		for(Cookie c : coo){
			if(c.getName().equals("cId")){ %>
 			<script>
 				alert("접근오류");			
 				window.location.href="b_loginPro.jsp";
 			</script>	
<%
			}else{
				
				request.setCharacterEncoding("UTF-8");
				//form 데이터 를 가져오기 위한 변수 준비
				//2
				String path = request.getRealPath("save");
				//3
				int max = 1024*1025*5;
				//4
				String enc = "UTF-8";
				//5
				DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
				MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
				//파일 검사
				String sysName = mr.getFilesystemName("img");
				if(sysName != null){
					String contentType = mr.getContentType("img");
					String[] ct = contentType.split("/");
					if(!(sysName != null && ct[0].equals("image"))){
						File f = new File(sysName);
						f.delete();
						%>
						<script type="text/javascript">
							alert("파일업로드 오류. 이미지파일을 업로드해주세요.");
							history.go(-1);
						</script>
						<%
					}
				}
				//데이터 DTO에 저장
				M0101DTO user = new M0101DTO();
				user.setId(mr.getParameter("id"));
				user.setPw(mr.getParameter("pw"));
				user.setName(mr.getParameter("name"));
				user.setBirth(mr.getParameter("birth"));
				user.setEmail(mr.getParameter("email"));
				user.setImg(sysName);
				//DB에 데이터 저장
				M0101DAO dao = new M0101DAO();
				dao.insertUser(user);
			
%>
<body>
<br/>
<h1>회원가입</h1>
<table>
	<tr>
		<td>
			회원가입이 완료되었습니다. <br/>
			<button onclick="window.location.href='e_main.jsp'">메인으로</button>
		</td>
	</tr>
</table>

</body>
			
<%			
			}
		}

  } %>
</html>