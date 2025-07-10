<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mlb.product.dao.*" %>
<%@ page import="com.mlb.product.dto.*" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>MLB - AdminProductStockUpdateDB</title>
</head>
<body>
<jsp:include page="/topnavigator.jsp"></jsp:include>
<%
    request.setCharacterEncoding("UTF-8");
    String grade = (String) session.getAttribute("grade");
    if(grade == null || !grade.equals("admin")){
        response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
        return;
    } else {
        System.out.println("grade: " + grade);
    }
    String productIdString = request.getParameter("productId");
    String productStockIdString = request.getParameter("productStockId");
    String colorId = request.getParameter("colorId");
    String sizeId = request.getParameter("sizeId");
    String priceString = request.getParameter("price");
    String quantityString = request.getParameter("quantity");
    Long productId = null;
    Long productStockId = null;
    Long price = null;
    Long quantity = null;
    try {
        productId = Long.parseLong(productIdString);
        productStockId = Long.parseLong(productStockIdString);
        price = Long.parseLong(priceString);
        quantity = Long.parseLong(quantityString);
    } catch(Exception e){
        response.sendRedirect(request.getContextPath() + "/product/AdminProductEdit.jsp?productId=" + productId + "&error=invalid_input");
        return;
    }
    ProductStockDao productStockDao = new ProductStockDao();
    ProductStockDto productStock = new ProductStockDto(
        productStockId,
        productId,
        colorId,
        sizeId,
        null,
        null
    );
    ArrayList<ProductStockDto> productStockList = productStockDao.searchWithoutProductStockId(productStock);
    for(ProductStockDto ps : productStockList){
        if(ps.getQuantity() == quantity && ps.getPrice() == price){
            response.sendRedirect(request.getContextPath() + "/product/AdminProductEdit.jsp?productId=" + productId + "&error=exist");
            return;
        }
    }
    productStock = new ProductStockDto(
        productStockId,
        productId,
        colorId,
        sizeId,
        quantity,
        price
    );

    productStockDao.update(productStock);

    response.sendRedirect(request.getContextPath() + "/product/AdminProductEdit.jsp?productId=" + productId);
%>

</body>
</html>
