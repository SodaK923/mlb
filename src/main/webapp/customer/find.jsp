<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
<style>
   body { font-family: Arial, sans-serif; }
   form { width: 300px; margin: 0 auto; }
   input { display: block; width: 100%; margin-bottom: 10px; padding: 8px; }
   .btnFind { width: 100%; padding: 10px; background-color: blue; color: white; border: none; }
</style>
</head>
<body>
	<jsp:include page="/topnavigator.jsp" /><br>
	
	<h2 style="text-align:center;">아이디/비밀번호 찾기</h2><br>
	
		<form action="FindServlet" method="post">
			<input type="text" name="name" placeholder="이름" required>
			<input type="email" name="email" placeholder="이메일" required>
			<button class = "btnFind" type="submit">아이디 찾기</button>
		</form><br>
		
		<form action="ResetServlet" method="post">
			<input type="text" name="id" placeholder="아이디" required>
			<input type="email" name="email" placeholder="이메일" required>
			<button class = "btnFind" type="submit">비밀번호 재설정</button>
		</form>
</body>
</html>