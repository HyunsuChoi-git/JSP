<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    
    <style>
        form{
            margin: 0 auto;
            width: 960px;
            height: 580px;
            background-color: #e5e5ff;
        } 
                  
        h1 {
            box-sizing: border-box;
            height: 70px;
            text-align: center;
            font-feature-settings: normal;
            font-weight: bolder;
            margin-top: 170px;
            margin-bottom: 60px;
            background-color:#aebdea ; 
            color: azure;
            font-size: 40px;

        }
        li {    list-style: none;    }

        .reg {
            width: 370px;
            float: left;
            text-align: right;            
            font-weight: bold;
            margin-right: 30px;
            font-size: 15px;
            color: 	#292b2c;

        }
        input { 
            margin-bottom: 7px;
    		background-color: azure;
			border : 1px solid azure; 
			border-radius: 3px;
			font-size : 15px; 
			color: #77878F; 
			FONT-FAMILY: 맑은 고딕,verdana; 
        }
 
    </style>
	<script>
		//유효성 검사 메소드
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
		
		//아이디 중복확인 검사 메소드
		function checkID(signIn){
			if(signIn.id.value == ""){
				alert("아이디를 작성하세요");
				return;
			}
	       	var url = "f_checkId.jsp?id="+signIn.id.value;
			open(url, "아이디 중복검사", "toolbar=no, status=no, menubar=no, scrollbars=no, resizalbe=no, width=350px, height==200px");
		}
	</script>
</head>
<%
String sId = (String)session.getAttribute("sId");
String cId = null;
Cookie[] coo = request.getCookies();
for(Cookie c : coo){
	if(c.getName().equals("cId")) cId = c.getValue();
}
if(sId != null || cId != null){ %>
	<script>
		alert("이미 회원가입이 되어있는 상태입니다.");
		window.location.href="c_main.jsp";
	</script>
<% }%>

<body>
    
   <form name="signIn" action="a_signinPro.jsp" onsubmit="return check()" method="post" />
      <h1>Sign In</h1>
       <filedset>
           <ul>
               <li>
                   <label class="reg" for="id">*아이디 :</label>
                   <input type="text" name="id" size="12" autofocus />
                   <input type="button" name="checkId" value="중복검사" onclick="checkID(this.form)"/>
               </li>
               <li>
                   <label class="reg" for="pw">*비밀번호 :</label>
                   <input type="password" name="pw" size="16" />
               </li>
               <li>
                   <label class="reg" for="pw2">*비밀번호 확인 :</label>
                   <input type="password" name="pw2" size="16" />

               </li>
           </ul>
       </filedset>
       <filedset>
           <ul>
               <li>
                  <label class="reg" for="name">*이름 :</label>
                  <input type="text" name="name" size="8" />
               </li>
               <li>
                   <label class="reg" for="gender">성별 :</label>
                   <input type="radio" name="gender" value="남자" checked/>남자
                   <input type="radio" name="gender" value="여자"/>여자
               </li>
               <li>
                   <label class="reg" for="birth">생년월일 :</label>
                   <input type="text" name="birth" size="16" placeholder="yyyy-mm-dd"/>

               </li>
               <li>
                   <label class="reg" for="addr">주소 : </label>
                   <input type="text" name="addr" size="40" />
               </li>
               <li>
                   <label class="reg" for="phon">전화번호 :</label>
                    <input type="text" name="phon" size="16" placeholder="000-0000-0000"/>
               </li>
               <li>
                   <label class="reg" for="email">이메일 주소</label>
                   <input type="text" name="email" size="20"/>
               </li>
           </ul>
       </filedset>
       <filedset>
           <ul>
               <li>
                   <label class="reg" for="sns">SNS 수신동의 여부</label>
                   <input type="checkbox" name="sns1" value="e-mail"/> e-mail
                   <input type="checkbox" name="sns2" value="SMS"/> SNS 
                   
               </li>
           </ul>
       </filedset>
       <table width="960px">
           <tr>
               <td align="center">       
                   <input type="reset" value="RESET" style="margin: 10px"/>
                   <input type="submit" value="Sign in" style="margin: 10px"/>
               </td>
            </tr>
        </table>
   </form>
   
    
	</body>
</html>