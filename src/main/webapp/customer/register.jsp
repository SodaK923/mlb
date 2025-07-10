<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
	body { font-family: Arial, sans-serif; }
    form { width: 300px; margin: 0 auto; }
    input { display: block; width: 100%; margin-bottom: 10px; padding: 8px; }
    .btnRegister { width: 100%; padding: 10px; background-color: blue; color: white; border: none; }
</style>
</head>
<body>
	<jsp:include page="/topnavigator.jsp" /><br>
	<h2 style="text-align:center;">회원가입</h2><br>
	<form action="RegisterServlet" method="post">
		<input type="text" name="id" placeholder="아이디" required>
		<input type="password" name="password" placeholder="비밀번호" required>
		<input type="text" name="name" placeholder="이름" required>
		<input type="email" name="email" placeholder="이메일" required>
		<input type="text" name="grade" placeholder="등급">
		<input type="text" name="address" placeholder="주소">
		<input type="text" name="hp" placeholder="전화번호">
		<button class = "btnRegister" type="submit">회원가입</button>
	</form>
    
</body>
</html>