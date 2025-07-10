<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="com.mlb.product.dao.*" %>
<%@ page import="com.mlb.product.dto.*" %>
<%@ page import="com.mlb.order.pay.dao.*" %>
<%@ page import="com.mlb.order.pay.dto.*" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>MLB - OrderInsertDB</title>
    <%
    request.setCharacterEncoding("UTF-8");
    String userIdString = (String) session.getAttribute("user_id");
    Long userId = null;
    String grade = (String) session.getAttribute("grade");
    if(userIdString == null || grade == null || !grade.equals("customer")){
        response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
        return;
    }
    try {
        userId = Long.parseLong(userIdString);
    } catch(Exception e){
        response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
        return;
    }
    String pay_id = request.getParameter("pay_id");
    String shippingAddress = request.getParameter("shipping_address");
    String[] order_detail_ids_string = request.getParameterValues("order_detail_id");
    String params = "";
    Long totalPrice = 0l;
    ProductStockDao productStockDao = new ProductStockDao();
    OrderDetailDao orderDetailDao = new OrderDetailDao();
    ArrayList<OrderDetailDto> orderDetailList = new ArrayList<OrderDetailDto>();
    for(String order_detail_id_string : order_detail_ids_string){
        params += "&order_detail_id=" + order_detail_id_string;
        Long order_detail_id = null;
        try {
            order_detail_id = Long.parseLong(order_detail_id_string);
        } catch(Exception e){
            response.sendRedirect(request.getContextPath() + "/order/payments.jsp?error=invalid_order_detail_id" + params);
            return;
        }
        OrderDetailDto orderDetailDto = orderDetailDao.selectByOrderDetailId(order_detail_id);
        if(orderDetailDto == null){
            response.sendRedirect(request.getContextPath() + "/order/payments.jsp?error=invalid_order_detail_id" + params);
            return;
        }
        if(userId!= orderDetailDto.getUserId()){
            response.sendRedirect(request.getContextPath() + "/order/payments.jsp?error=invalid_order_detail_id" + params);
            return;
        }
        if(orderDetailDto.getOrderId() != 0){
            response.sendRedirect(request.getContextPath() + "/order/payments.jsp?error=invalid_order_detail_id" + params);
            return;
        }
        if(orderDetailDto.getOrderQuantity() <= 0){
            response.sendRedirect(request.getContextPath() + "/order/payments.jsp?error=invalid_order_detail_id" + params);
            return;
        }
        if(orderDetailDto.getOrderQuantity() > productStockDao.selectByProductStockId(orderDetailDto.getPrStId()).getQuantity()){
            response.sendRedirect(request.getContextPath() + "/order/payments.jsp?error=invalid_order_detail_id" + params);
            return;
        }
        orderDetailList.add(orderDetailDto);
        totalPrice += orderDetailDto.getCurrentTotalPrice();
    }
    if(!("naverpay".equals(pay_id) || "kakao".equals(pay_id) || "card".equals(pay_id))) {
        response.sendRedirect(request.getContextPath() + "/order/payments.jsp?error=invalid_pay_id" + params);
        return;
    }
    OrderDao orderDao = new OrderDao();
    OrderDto orderDto = new OrderDto();
    orderDto.setUserId(userId);
    orderDto.setOrderDate(LocalDateTime.now());
    orderDto.setTotalPrice(totalPrice);
    orderDto.setPayId(pay_id);
    orderDto.setShippingAddress(shippingAddress);
    Long orderId = orderDao.insert(orderDto);
    for(OrderDetailDto orderDetailDto : orderDetailList){
        orderDetailDto.setOrderId(orderId);
        orderDetailDto.setOrderPrice(orderDetailDto.getCurrentPrice());
        ProductStockDto productStockDto = productStockDao.selectByProductStockId(orderDetailDto.getPrStId());
        System.out.println(productStockDto);
        if(productStockDto.getQuantity() - orderDetailDto.getOrderQuantity() < 0){
            continue;
        }
        productStockDto.setQuantity(productStockDto.getQuantity() - orderDetailDto.getOrderQuantity());
        productStockDao.update(productStockDto);
        orderDetailDao.update(orderDetailDto);
    }
    response.sendRedirect(request.getContextPath() + "/order/OrderPaySuccess.jsp?order_id=" + orderId);
    %>
</head>
<body>

</body>
</html>
