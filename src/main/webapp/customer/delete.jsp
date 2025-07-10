<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
</head>
<body>
<h2>회원 삭제</h2>
    <form action="DeleteServlet" method="post">
        <input type="hidden" id="userId" name="userId" value=<% 
        	out.println(session.getAttribute("user_id")); 
        %> >
        <button type="submit">삭제</button>
    </form>
    <br>
    <%
    	if(session.getAttribute("grade").equals("admin")){
    		out.println("<a href=\"userList.jsp\">회원 목록</a>");	
    	}
    %>
    
</body>
</html>