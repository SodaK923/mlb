<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mlb.customer.UserDao" %>
<%@ page import="com.mlb.customer.UserDto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 목록</title>
    <style>
    body { font-family: Arial, sans-serif; text-align: center; }

        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .success {
            color: green;
        }
        .failure {
            color: red;
        }
    </style>
</head>
<body>
<jsp:include page="/topnavigator.jsp" />
<br>
<h2>사용자 목록</h2>

	<%
		if(!"admin".equals(session.getAttribute("grade"))){
			response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
		}
	%>
<%
    // 삭제 성공/실패 메시지 출력
    String msg = request.getParameter("msg");
    if ("success".equals(msg)) {
%>
    <p class="success">사용자가 성공적으로 삭제되었습니다.</p>
<%
    } else if ("failure".equals(msg)) {
%>
    <p class="failure">사용자 삭제에 실패했습니다.</p>
<%
    }
%>

<table>
    <tr>
        <th>사용자 ID</th>
        <th>이름</th>
        <th>등급</th>
        <th>이메일</th>
        <th>주소</th>
        <th>전화번호</th>
        <th>가입 날짜</th>
        <th>삭제</th>
    </tr>

<%
    List<UserDto> userList = UserDao.getAllUsers(); // UserDao에서 사용자 목록 가져오기
    for (UserDto user : userList) {
    	System.out.println(user);
%>
    <tr>
        <td><%= user.getUserId() %></td>
        <td><%= user.getName() %></td>
        <td><%= user.getGrade() %></td>
        <td><%= user.getEmail() %></td>
        <td><%= user.getAddress() %></td>
        <td><%= user.getHp() %></td>
        <td><%= user.getRegdate() %></td>
        <td>
            <form action="DeleteServlet" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                <input type="submit" value="삭제">
            </form>
        </td>
    </tr>
<%
    }
%>
</table>

</body>
</html>
