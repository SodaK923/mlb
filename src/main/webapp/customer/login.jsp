<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>로그인</title>
    <style>
	body { font-family: Arial, sans-serif; text-align: center; }
    form { width: 300px; margin: 0 auto; }
    input { display: block; width: 100%; margin-bottom: 10px; padding: 8px; }
    .btnLogin { width: 100%; padding: 10px; background-color: blue; color: white; border: none; }
    table {
        width: 50%;
        margin: 20px auto;
        border-collapse: collapse;
        font-size: 18px;
    }
    th, td {
        padding: 8px;
        border: 1px solid #ddd;
        text-align: center; /* 중앙 정렬 */
    }
    th {
        background-color: #f4f4f4;
</style>
</head>
<body>
	<jsp:include page="/topnavigator.jsp" /><br>
    <h2>로그인</h2><br>
    <% String error = request.getParameter("error"); %>
    <% if (error != null) { %>
        <p style="color:red;"><%= error %></p>
    <% } %>
    <form action="LoginServlet" method="post">       
        <input type="text" id="userId" name="userId" placeholder="User Id" required>
        <br>        
        <input type="password" id="password" name="password"  placeholder="Password" required>
        <br>
        <button class = "btnLogin" type="submit">Login</button>
    </form><br>
    <a href="find.jsp">아이디/비밀번호 찾기</a>
    <p>회원이 아니신가요? <a href="register.jsp">회원가입</a></p>
    <br>
    <!-- 사용자 정보 표시 -->
    <h3>테스트 계정 정보</h3>
    <table>
        <tr>
            <th>역할</th>
            <th>이름</th>
            <th>아이디</th>
            <th>비밀번호</th>
        </tr>
        <tr>
            <td>admin</td>
            <td>jdbcproj</td>
            <td>1234</td>
            <td>adminpass</td>
        </tr>
        <tr>
            <td>customer</td>
            <td>John Doe</td>
            <td>johndoe1</td>
            <td>password1</td>
        </tr>
    </table>
    
</body>
</html>