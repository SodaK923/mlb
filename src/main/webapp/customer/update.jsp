<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
    <style>
	body { font-family: Arial, sans-serif; text-align: center; }
    form { width: 300px; margin: 0 auto; }
    input { display: block; width: 100%; margin-bottom: 10px; padding: 8px; }
    .btnUpdate { width: 100%; padding: 10px; background-color: blue; color: white; border: none; }
</style>
</head>
<body>
	<jsp:include page="/topnavigator.jsp" />
    <h2>회원정보 수정</h2>
    <form action="UpdateServlet" method="post">
        <label>이름: <input type="text" name="name" value="${user.name}" required></label><br>
        <label>이메일: <input type="email" name="email" value="${user.email}" required></label><br>
        <label>전화번호: <input type="text" name="hp" value="${user.hp}"></label><br>
        <label>주소: <input type="text" name="address" value="${user.address}"></label><br>
        
        <h2>비밀번호 변경 (선택 사항)</h2>
        <label>현재 비밀번호: <input type="password" name="currentPw"></label><br>
        <label>새 비밀번호: <input type="password" name="newPw"></label><br>
        <label>새 비밀번호 확인: <input type="password" name="confirmPw"></label><br>
        
        <input type="submit" value="수정하기">
        
    </form>
    
    <h2>회원 탈퇴</h2>
    <form action="DeleteServlet" method="post">
        <input type="hidden" id="userId" name="userId" value=<% 
        	out.println(session.getAttribute("user_id")); 
        %> >
        <button class= "btnUpdate" type = "submit">회원 탈퇴하기</button>
    </form>
    <br>
    <%
    	if(session.getAttribute("grade").equals("admin")){
    		out.println("<a href=\"userList.jsp\">회원 목록</a>");	
    	}
    %>
</body>
</html>
