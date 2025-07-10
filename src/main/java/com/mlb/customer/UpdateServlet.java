package com.mlb.customer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class UpdateServlet
 */
@WebServlet("/customer/UpdateServlet")
public class UpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public UpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        // 세션에서 사용자 정보 가져오기
        HttpSession session = request.getSession();
        UserDto user = (UserDto) session.getAttribute("user");

        // 사용자 정보가 없으면 로그인 페이지로 리디렉션
        if (user == null) {
            response.sendRedirect("login.jsp?error=Please login first");
            return;
        }

        // 폼 데이터 가져오기
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String hp = request.getParameter("hp");
        String address = request.getParameter("address");

        // 비밀번호 변경 여부 체크
        String currentPw = request.getParameter("currentPw");
        String newPw = request.getParameter("newPw");
        String confirmPw = request.getParameter("confirmPw");

        // 비밀번호 변경을 요청한 경우
        boolean updatePassword = false;
        if (newPw != null && !newPw.isEmpty() && newPw.equals(confirmPw)) {
            if (user.getPw().equals(currentPw)) {
                // 비밀번호가 맞으면 비밀번호 변경
                user.setPw(newPw);
                updatePassword = true;
            } else {
                // 비밀번호 불일치 시 처리
                request.setAttribute("errorMessage", "Current password is incorrect.");
                request.getRequestDispatcher("update.jsp").forward(request, response);
                return;
            }
        }

        // 사용자 정보 업데이트
        user.setName(name);
        user.setEmail(email);
        user.setHp(hp);
        user.setAddress(address);

        // 데이터베이스에 업데이트 요청
        boolean updateSuccess = UserDao.updateUser(user, updatePassword);

        if (updateSuccess) {
            // 업데이트 성공 시 세션에 변경된 정보 업데이트
            session.setAttribute("user", user);
            response.sendRedirect("../index.jsp");  // 업데이트 완료 후 welcome 페이지로 리디렉션
        } else {
            // 업데이트 실패 시 처리
            request.setAttribute("errorMessage", "Update failed. Please try again.");
            request.getRequestDispatcher("update.jsp").forward(request, response);
        }
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}
}
