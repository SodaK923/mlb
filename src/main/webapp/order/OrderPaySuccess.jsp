<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="com.mlb.order.pay.dao.*" %>
<%@ page import="com.mlb.order.pay.dto.*" %>
<%@ page import="com.mlb.utils.*" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/Font.css" type="text/css" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/OrderPaySuccess.css" type="text/css" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>MLB - 주문 완료</title>
    <%
    request.setCharacterEncoding("UTF-8");
    String userIdString = (String) session.getAttribute("user_id");
    Long userId = null;
    String grade = (String) session.getAttribute("grade");
    if(userIdString == null || grade == null ||!grade.equals("customer")){
        response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
        return;
    }
    try {
        userId = Long.parseLong(userIdString);
    } catch(Exception e){
        response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
        return;
    }
    String order_id_string = request.getParameter("order_id");
    Long orderId = null;
    if(order_id_string == null){
        response.sendRedirect(request.getContextPath() + "/order/orderList.jsp");
        return;
    }
    try {
        orderId = Long.parseLong(order_id_string);
    } catch(Exception e){
        response.sendRedirect(request.getContextPath() + "/order/orderList.jsp");
        return;
    }
    OrderDao orderDao = new OrderDao();
    OrderDto orderDto = orderDao.selectByOrderId(orderId);
    if(orderDto == null || orderDto.getUserId()!= userId){
        response.sendRedirect(request.getContextPath() + "/order/orderList.jsp");
        return;
    }
    OrderDetailDao orderDetailDao = new OrderDetailDao();
    ArrayList<OrderDetailDto> orderDetailList = orderDetailDao.selectByOrderId(orderId);
    pageContext.setAttribute("orderDetailList", orderDetailList);
    pageContext.setAttribute("orderDto", orderDto);
    %>
</head>
<body>
    <div class="order">
        <h1>주문 완료</h1>
        <div class="order-info">
            <div class="order-number">주문번호 : <%= orderDto.getOrderId() %></div>
            <div class="order-date">주문일시 <%= UserInput.dateToString(orderDto.getOrderDate()) %></div>
            <div class="order-pay-id">결제수단 : <%
                String payId = orderDto.getPayId();
                if(payId.equals("card")){
                    out.print("신용카드");
                } else if(payId.equals("kakao")){
                    out.print("카카오 페이");
                } else if(payId.equals("naverpay")){
                    out.print("네이버 페이");
                }
            %></div>
            <div class="address">배송지 주소 : <%= orderDto.getShippingAddress() %></div>
        </div>
        <div class="order-details">
            <h2>주문한 상품</h2>
            <c:forEach var="orderDetail" items="${orderDetailList}">
                <div class="item">
                    <input type="hidden" name="order_detail_id" value="${orderDetail.getOrderDetailId()}">
                    <img class="product-image" src="<%= request.getContextPath() %>/primg/thum/${orderDetail.getPr_thum_img()}" alt="${orderDetail.getPr_name()}">
                    <div class="info">
                        <label class="product-name">${orderDetail.getPr_name()}</label>
                        <label class="product-team">팀: ${orderDetail.getTm_name()}</label>
                        <label class="product-color">색상: ${orderDetail.getCl_name()}</label>
                        <label class="product-size">사이즈: ${orderDetail.getSz_id()}</label>
                        <label class="product-quantity">수량: ${orderDetail.getOrderQuantity()}</label>
                        <label class="product-price"><fmt:formatNumber value="${orderDetail.getOrderPrice()}" pattern="#,###" />원/수량</label>
                        <label class="product-option-price"><fmt:formatNumber value="${orderDetail.getOrderPrice() * orderDetail.getOrderQuantity()}" pattern="#,###" />원</label>
                    </div>
                </div>
            </c:forEach>
            <h3>
                <%
                    if(orderDetailList.size() != 0){
                        Long totalPrice = 0l;
                        for(OrderDetailDto orderDetail : orderDetailList){
                            totalPrice += orderDetail.getCurrentTotalPrice();
                        }
                        pageContext.setAttribute("totalPrice", totalPrice);
                    }
                %>
                <label class="total-price"><fmt:formatNumber value="${totalPrice}" type="number"></fmt:formatNumber>원</label>
            </h3>
        </div>
    </div>
    <a href="<%= request.getContextPath() %>/index.jsp">
        <button class="main-button">메인으로 가기</button>
    </a>
</html>
