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
    <title>MLB - AdminProductStockInsertDB</title>
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
    String colorId = request.getParameter("colorId");
    String sizeId = request.getParameter("sizeId");
    String priceString = request.getParameter("price");
    String quantityString = request.getParameter("quantity");
    Long productId = null;
    Long price = null;
    Long quantity = null;
    try {
        productId = Long.parseLong(productIdString);
        price = Long.parseLong(priceString);
        quantity = Long.parseLong(quantityString);
    } catch(Exception e){
        response.sendRedirect(request.getContextPath() + "/product/AdminProductList.jsp");
        return;
    }
    ProductStockDao productStockDao = new ProductStockDao();
    ProductStockDto productStock = new ProductStockDto(
        null,
        productId,
        colorId,
        sizeId,
        null,
        null
    );
    ArrayList<ProductStockDto> productStockList = productStockDao.searchWithoutProductStockId(productStock);
    productStock = new ProductStockDto(
        null,
        productId,
        colorId,
        sizeId,
        quantity,
        price
    );
    if(productStockList.size() > 0){
        response.sendRedirect(request.getContextPath() + "/product/AdminProductEdit.jsp?productId=" + productId + "&error=exist");
        return;
    }
    productStockDao.insert(productStock);

    response.sendRedirect(request.getContextPath() + "/product/AdminProductEdit.jsp?productId=" + productId);
%>

</body>
</html>
