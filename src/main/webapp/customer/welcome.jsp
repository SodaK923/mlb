<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mlb.customer.UserDto" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession(false);
    UserDto user = (sessionObj != null) ? (UserDto) sessionObj.getAttribute("user") : null;
    String error = request.getParameter("error");

   if (user == null) {
        response.sendRedirect("login.jsp?error=Please login first");
        return;
    }
//    if (error != null && "grade".equals(error)){
//    	out.println("<script>alert(\"잘못된 접근 입니다.\");</script>");
//    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>
</head>
<body>
    <h2>Welcome, <%= user.getUserId() %>!</h2>
    <p>Your email: <%= user.getEmail() %></p>
    <p>Your grade: <%= user.getGrade() %></p>
    <a href ="LogoutServlet">Logout</a> |
    <%
    	if("admin".equals(session.getAttribute("grade"))){
    		out.println("<a href=\"userList.jsp\">userList</a> |");
    	}
    	
    %>
    <a href="update.jsp">Edit Profile</a> |
    <a href="delete.jsp">delete</a> |
    <a href ="../topnavigator.jsp">main</a>
</body>
</html>
