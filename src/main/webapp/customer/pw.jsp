<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 초기화 결과</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin: 50px; }
        .container { max-width: 400px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; }
        .message { font-size: 18px; color: #333; }
        .home-link { display: block; margin-top: 20px; text-decoration: none; color: blue; }
    </style>
</head>
<body>
    <div class="container">
        <h2>비밀번호 초기화</h2>
        <p class="message">${message}</p>
        <a href="login.jsp" class="home-link">로그인 페이지로 이동</a>
    </div>
</body>
</html>