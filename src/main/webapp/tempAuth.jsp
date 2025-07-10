<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 파라미터로 동작 구분
    String action = request.getParameter("action");
	System.out.println("action: " + action);

    if ("login".equals(action)) { 
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        
        /*
        1	admin	  jdbcproj	  1234	 adminpass
        2	customer	John Doe	johndoe1	password1
        */
        
        if ("1234".equals(userId) && "adminpass".equals(password)) {
        	// 로그인 세션 정보저장
        	session.setAttribute("user_id", "1");
        	session.setAttribute("grade", "admin");
        	session.setAttribute("name", "jdbcproj");
            response.getWriter().write("login-success");
        } else if ("johndoe1".equals(userId) && "password1".equals(password)) {
        	// 일반사용자 저장
        	session.setAttribute("user_id", "2");
        	session.setAttribute("grade", "customer");
        	session.setAttribute("name", "John Doe");
            response.getWriter().write("login-success");
        	
        }else {
            response.getWriter().write("login-fail");
        }
        
    } else if ("logout".equals(action)) {
    	// 로그아웃 처리
    	System.out.println("logout");
        if (session != null) {
        	session.removeAttribute("user_id");
        	session.removeAttribute("grade");
        	session.removeAttribute("name");
        }
        response.getWriter().write("logout-success");
    }
    
    
%>


