<%@page import="com.mlb.order.dao.OrderListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
	//request.getParameter("user_id");

	if( session.getAttribute("user_id") != null )
	{
		
		Long userId = Long.parseLong( (String)session.getAttribute("user_id") );
		
		System.out.println("user_id : " + userId );
		
		if( request.getParameter("pr_st_id") != null )
		{
			String ssss = request.getParameter("pr_st_id");
			Long prstId = Long.parseLong( ssss );
			
			System.out.println("prstId : " + prstId );
			
			if( request.getParameter("quantity") != null )
			{
				int quantity = Integer.parseInt( (String)request.getParameter("quantity") );
				
				System.out.println("quantity : " + quantity );
				
				OrderListDao odDAO = new OrderListDao();
				odDAO.insertCart( userId, prstId, quantity);
				
				String cartListUrl = request.getContextPath()+"/order/orderList.jsp?view=cart";
				response.sendRedirect(cartListUrl);
				return;
			}
		}
	}
	
    

%>