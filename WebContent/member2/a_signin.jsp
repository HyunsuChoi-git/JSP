<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />
    <script>
        //유효성 검사
        function check(){
            if(!document.signIn.id.value){
                alert("ID를 입력하세요.");
                return false;
            }
             if(!document.signIn.pw.value){
                alert("비밀번호를 입력하세요.");
                return false;
            }
            if(!document.signIn.pw2.value){
                alert("비밀번호 확인을 입력하세요.");
                return false;
            }
            if(!document.signIn.name.value){
                alert("이름을 입력하세요.");
                return false;
            }
            var inputs = document.signIn;
            if(inputs.pw.value != inputs.pw2.value){
               alert("비밀번호가 일치하지 않습니다.")
                return false;
            }
        }
        
        //아이디 중복검사
        //스크립트에서는 타입이 필요 없으니 그냥 매개변수 이름만 지정해주면 된다.)
        //위 유효성 검사는, 변수에 form태그를 담은 것이고 
        // 얘는 매개변수로 직접 받은 것. 두가지 방법이 있다~!
        function confirmIdPopup(signIn){
        	if(signIn.id.value == ""){ //아이디를 기입했는 지 확인
        		alert("아이디를 입력하세요.");
        		return;  //현재메소드 종료 //submit형태의 input폼이 아니기때문에 false nono
        	}
        	
        	//팝업 띄워 아이디만 DB에 존재하는 지 확인한 후 돌아오게 만들기.
        	var url = "f_confirmId.jsp?id="+signIn.id.value;
        	//url에 팝업창 주소와 입력받은 id(name속성값이 id인 값) 넘겨주기. (get방식 느낌)
        	
        	//팝업창 메소드
        	//open(url,"팝업창이름","옵션");   옵션 : toolbar, status, menubar, scrollbars, resizalbe, width, height
        	open(url, "아이디 중복검사" , "toolbar=no, status=no, menubar=no, scrollbars=no, resizalbe=no, width=300px, height==200px");
        	
        }
    </script>

</head>
<%
	String id = (String)session.getAttribute("sId");
	String cId = null, cPw = null, cAuto = null;
	//새션이 존재하면 메인페이지로 이동
	if(id != null){ %>
	<script>
		alert("로그인이 되어있는 상태입니다.");
		window.location.href="c_main.jsp";
	</script>
<% 	}else{
		//새션이 존재하지 않으나 쿠키가 존재하면 로그인프로페이지로 이동하여 새션생성
		Cookie[] coo = request.getCookies();
		for(Cookie c : coo){
			if(c.getName().equals("cId")) cId = c.getValue();
			if(c.getName().equals("cPw")) cPw = c.getValue();
			if(c.getName().equals("cAuto")) cAuto = c.getValue();
		}
		if(cId != null && cPw != null && cAuto != null){ %>
			<script>
				alert("로그인이 되어있는 상태입니다.");
				window.location.href="b_loginPro.jsp";
			</script>		
<%		}
	}	
%>
<body>
	<br />
	<h1 align="center">회원가입</h1>
	<form name="signIn" action="a_signinPro.jsp" onsubmit="return check()" method="post">
	<table>
		<tr>
			<td>아이디 * </td>
			<td><input type="text" name="id" autofocus/>
			<%-- 아이디 중복검사 this.form -> 폼 전체를 매개변수로 던져주는 것.--%>
			<input type="button" value="중복검사" onclick="confirmIdPopup(this.form)"/>
			</td>
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
			<td>이름 * </td>
			<td><input type="text" name="name" /></td>
		</tr>
		<tr>
			<td>생년월일 </td>
			<td><input type="text" name="birth" placeholder="YYYY-MM-DD" /></td>
		</tr>
		<tr>
			<td>Email </td>
			<td><input type="text" name="email" /></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit"  value="가입" />
				<input type="reset"  value="재입력" />
			</td>
		</tr>
	</table>
	</form>
</body>
</html>