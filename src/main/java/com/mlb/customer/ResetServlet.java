package com.mlb.customer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ResetServlet
 */
@WebServlet("/customer/ResetServlet")
public class ResetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResetServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		
		UserDao userDao = new UserDao();
	    String newPassword = userDao.resetPassword(id, email); // 새로운 비밀번호를 반환받음

	    if (newPassword != null) {
	        request.setAttribute("message", "비밀번호가 초기화되었습니다. 새로운 비밀번호: " + newPassword);
	        request.setAttribute("newPassword", newPassword); // JSP에서 사용하기 위해 저장
	    } else {
	        request.setAttribute("message", "일치하는 계정이 없습니다.");
	    }
	    
	    request.getRequestDispatcher("pw.jsp").forward(request, response);
	}
}