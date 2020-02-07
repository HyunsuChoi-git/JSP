<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<script>
	//아이디 중복검사
	function idCheck(signin){
		if(signin.id.value == ""){
			alert("아이디를 입력하세요.");
			return;
		}
		var url = "f_popup.jsp?id="+signin.id.value;
		open(url, "아이디 중복검사", "toolbar=no, status=no, menubar=no, scrollbars=no, resizalbe=no, width=300px, height==200px");
	}
	
	//유효성 검사
	function check(){
		var sign = document.signin;
		if(!sign.id.value){
			alert("아이디를 입력하세요.");
			return false;
		}
		if(!sign.pw.value){
			alert("비밀번호를 입력하세요.");
			return false;
		}
		if(!sign.pw2.value){
			alert("비밀번호 확인을 입력하세요.");
			return false;
		}
		if(!sign.name.value){
			alert("이름을 입력하세요.");
			return false;
		}
		if(sign.pw.value != sign.pw2.value){
			alert("비밀번호가 일치하지 않습니다..");
			return false;
		}
	}
</script>
</head>
<%
 		//세션과 쿠키가 없는 경우만 진행.
 		//세션이 있으면 '이미 회원이다' -> loginPro.jsp
 		//쿠키가 있으면 ''이미 회원이다' -> loginPro.jsp
 		
 	String sId = (String)session.getAttribute("sId");
 	if(sId != null){ %>
 		<script>
 			alert("이미 회원가입이 되어있습니다.");
 			window.location.href="e_main.jsp";
 		</script>	
<%  }else{
		Cookie[] coo = request.getCookies();
		if(coo != null){
			for(Cookie c : coo){
				if(c.getName().equals("cId")){%>
	 			<script>
	 				alert("이미 회원가입이 되어있습니다.");
	 				window.location.href="b_loginPro.jsp";
	 			</script>	
	<%			}
			}
		}
	} 
%>

<body>
	<br/>
	<h1>회원가입</h1>
	<form name="signin" action="a_signinPro.jsp" onsubmit="return check()" method="post" encType="multipart/form-data">
		<table>
			<tr>
				<td>아이디 *</td>
				<td><input type="text" name="id" autofocus /> <input
					type="button" value="중복검사" onclick="idCheck(this.form)" /></td>
			</tr>
			<tr>
				<td>비밀번호 *</td>
				<td><input type="password" name="pw" /></td>
			</tr>
			<tr>
				<td>비밀번호 확인*</td>
				<td><input type="password" name="pw2" /></td>
			</tr>
			<tr>
				<td>이름 *</td>
				<td><input type="text" name="name" /></td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td><input type="text" name="birth" placeholder="YYYY-MM-DD" /></td>
			</tr>
			<tr>
				<td>Email</td>
				<td><input type="text" name="email" /></td>
			</tr>
			<tr>
				<td>프로필사진</td>
				<td><input type="file" name="img" /></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="submit" value="가입" /> 
				<input type="reset" value="재입력" /></td>
			</tr>
		</table>
	</form>

</body>
</html>