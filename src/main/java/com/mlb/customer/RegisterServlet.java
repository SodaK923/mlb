package com.mlb.customer;

import java.io.IOException;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/customer/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public RegisterServlet() {
        super();
    }

		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			request.setCharacterEncoding("UTF-8");
			
			String userId = request.getParameter("userId");			
			String grade = request.getParameter("grade");
			String name = request.getParameter("name");
			String id = request.getParameter("id");
			String Password = request.getParameter("password");
			String address = request.getParameter("address");
			String hp = request.getParameter("hp");
			String email = request.getParameter("email");
			LocalDateTime regdate = LocalDateTime.now();
			
			UserDto user = new UserDto(0l ,grade, name, id, Password, address, hp, email, regdate);
			boolean success = UserDao.registerUser(user);
			
			if(success) {
				response.sendRedirect("success.jsp");
			}else {
				response.sendRedirect("register.jsp?error=Registration Failed");
			}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
}
