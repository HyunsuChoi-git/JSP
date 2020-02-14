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
		$("#s").click(function(){
			//$("img").show();
			//$("img").fadeIn();
			$("img").fadeIn(2000);
		});
		$("#h").click(function(){
			//$("img").hide();
			//$("img").fadeOut();
			$("img").fadeOut(2000);
		});
	});
</script>
</head> 
<body>
	<button id="s">show</button>
	<button id="h">hide</button>
	<br/><br/>
	<img src="main2.jpg" width="500" />
</body>
</html>