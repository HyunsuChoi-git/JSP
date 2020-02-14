<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(document).ready(function(){
		$("li:nth-child(2)").css("color","red");
		$(".a").attr("class", "test");
	});
</script>
</head> 
<body>
	<ul>
		<li class="a">1.text 1.text 1.text 1.text</li>
		<li class="a">2.text 2.text 2.text 2.text</li>
		<li class="a">3.text 3.text 3.text 3.text</li>
		<li class="a">4.text 4.text 4.text 4.text</li>
	</ul>

</body>
</html>