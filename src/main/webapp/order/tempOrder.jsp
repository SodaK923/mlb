<%@page import="com.mlb.order.dao.OrderListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");

	if( request.getParameter("action") != null )
	{
		String action = request.getParameter("action");
		if( action.equals( "del_detail_id" )  )
		{
			if( request.getParameter("orderDetailId") != null)
			{
				OrderListDao old = new OrderListDao();
				
				Long id = Long.parseLong( (String)request.getParameter("orderDetailId") );
				int result = old.deleteOrderDetail( id );
				if( result > 0 ){
					response.getWriter().write("delete-success");
					return;
				}
				
			}
			
		}
		
	}
	
	response.getWriter().write("delete-fail");
	
	/*
	String[] values = request.getParameterValues("order_detail_id");
	
	for( String value : values )
	{
		System.out.println("order_detail_id: " + value);
	}
	*/

%>
