<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
        <h2>아이디 찾기 결과</h2>
        
        <div class="message">
            <% 
                // FindServlet에서 설정한 "message"를 가져옵니다.
                String message = (String) request.getAttribute("message");

                if (message != null) {
                    // message에 따라 결과를 표시합니다.
                    out.println("<p>" + message + "</p>");
                } else {
                    out.println("<p>예기치 않은 오류가 발생했습니다.</p>");
                }
            %>
        </div>

        <!-- 뒤로 가기 링크 -->
        <a class="back-link" href="find.jsp">아이디/비밀번호 찾기 페이지로 돌아가기</a>
    </div>
</body>
</html>