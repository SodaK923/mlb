<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*" %>
<%@ page import="com.mlb.order.pay.dao.*" %>
<%@ page import="com.mlb.order.pay.dto.*" %>
<%@ page import="com.mlb.product.dao.*" %>
<%@ page import="com.mlb.product.dto.*" %>
<%@ page import="com.mlb.order.dto.option.*" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/Font.css" />
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/OrderPay.css" />
    <title>MLB - Pay</title>
    <%
    request.setCharacterEncoding("UTF-8");
    String grade = (String) session.getAttribute("grade");
    if(grade == null ||!grade.equals("customer")){
        response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
        return;
    }
    String userIdString = (String) session.getAttribute("user_id");
    Long userId = null;
    try {
        userId = Long.parseLong(userIdString);
    } catch(Exception e){
        response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
        return;
    }
    UserDao userDao = new UserDao();
    UserDto userDto = userDao.selectByUserId(userId);
    if(userDto == null){
        response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
        return;
    }
    String address = userDto.getAddress();
    pageContext.setAttribute("address", address);
    String[] order_detail_ids_string = request.getParameterValues("order_detail_id");
    String pr_st_id_string = request.getParameter("pr_st_id");
    String quantity_string = request.getParameter("quantity");
    OrderDetailDao orderDetailDao = new OrderDetailDao();
    ArrayList<OrderDetailDto> orderDetailList = new ArrayList<OrderDetailDto>();
    ProductStockDao productStockDao = new ProductStockDao();
    ProductStockDto productStock = null;
    if((order_detail_ids_string == null || order_detail_ids_string.length == 0) && (pr_st_id_string == null || quantity_string == null)){
        response.sendRedirect(request.getContextPath() + "/cart/cart.jsp");
        return;
    }
    if((order_detail_ids_string != null && order_detail_ids_string.length > 0) && (pr_st_id_string != null && quantity_string != null)){
        response.sendRedirect(request.getContextPath() + "/cart/cart.jsp");
        return;
    }
    if(order_detail_ids_string != null && order_detail_ids_string.length > 0) {
        for(String order_detail_id_string : order_detail_ids_string){
            Long order_detail_id = null;
            try {
                order_detail_id = Long.parseLong(order_detail_id_string);
            } catch(Exception e){
                response.sendRedirect(request.getContextPath() + "/cart/cart.jsp");
                return;
            }
            OrderDetailDto orderDetailDto = orderDetailDao.selectByOrderDetailId(order_detail_id);
            if(userId != orderDetailDto.getUserId()){
                response.sendRedirect(request.getContextPath() + "/cart/cart.jsp");
                return;
            }
            if(orderDetailDto.getOrderId() != 0){
                response.sendRedirect(request.getContextPath() + "/cart/cart.jsp");
                return;
            }
            productStock = productStockDao.selectByProductStockId(orderDetailDto.getPrStId());
            if(productStock == null || productStock.getQuantity() < orderDetailDto.getOrderQuantity()) {
                response.sendRedirect(request.getContextPath() + "/cart/cart.jsp");
                return;
            }
            if(orderDetailDto!= null){
                orderDetailList.add(orderDetailDto);
            }
        }
        pageContext.setAttribute("orderDetailList", orderDetailList);
    }
    Long pr_st_id = null;
    Long quantity = null;
    if(pr_st_id_string != null && quantity_string != null) {
        try {
            pr_st_id = Long.parseLong(pr_st_id_string);
            quantity = Long.parseLong(quantity_string);
        } catch(Exception e){
            response.sendRedirect(request.getContextPath() + "/cart/cart.jsp");
            return;
        }
        productStock = productStockDao.selectByProductStockId(pr_st_id);
        OrderDetailDto orderDetailDto = new OrderDetailDto();
        orderDetailDto.setPrStId(pr_st_id);
        orderDetailDto.setOrderQuantity(quantity);
        orderDetailDto.setUserId(userId);
        orderDetailDto.setOrderPrice(productStock.getPrice());
        Long orderDetailId = orderDetailDao.insert(orderDetailDto);
        response.sendRedirect(request.getContextPath() + "/order/payments.jsp?order_detail_id=" + orderDetailId);
        return;
    }
    String error = request.getParameter("error");
    if("invalid_pay_id".equals(error)){
        out.println("<script>alert(\"결제수단이 올바르지 않습니다.\");</script>");
    }
    if("invalid_order_detail_id".equals(error)){
        out.println("<script>alert(\"주문상세ID가 올바르지 않습니다.\");</script>");
    }
    %>
</head>
<body>
    <h1>주문</h1>
    <form action="<%= request.getContextPath() %>/order/OrderInsertDB.jsp">
        <div class="address">
            <label for="address">주소</label>
            <input type="text" name="shipping_address" value="${address}" required>
        </div>
        <div class="item-list">
            <h2>상품목록</h2>
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
                        <label class="product-price"><fmt:formatNumber value="${orderDetail.getCurrentPrice()}" pattern="#,###" />원/수량</label>
                        <label class="product-option-price"><fmt:formatNumber value="${orderDetail.getCurrentTotalPrice()}" pattern="#,###" />원</label>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="payment">
            <label for="payment">결제수단</label>
            <select name="pay_id" required>
                <option value="card">신용카드</option>
                <option value="naverpay">네이버 페이</option>
                <option value="kakao">카카오 페이</option>
            </select>
        </div>
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
        <div class="submit">
            <button type="submit">결제</button>
        </div>
    </div>
    </form>

</body>
</html>
