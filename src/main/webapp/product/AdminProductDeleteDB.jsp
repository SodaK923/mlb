<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="com.mlb.product.dao.*" %>
<%@ page import="com.mlb.product.dto.*" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>MLB - AdminProductDeleteDB</title>
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
    Long productId = null;
    try {
        productId = Long.parseLong(productIdString);
    } catch(Exception e){
        response.sendRedirect(request.getContextPath() + "/product/AdminProductList.jsp");
        return;
    }
    ProductDao productDao = new ProductDao();
    ProductStockDao productStockDao = new ProductStockDao();
    ArrayList<ProductStockDto> productStockList = productStockDao.selectByProductId(productId);
    for(ProductStockDto productStock : productStockList){
        productStockDao.delete(productStock.getPr_st_id());
    }
    productDao.delete(productId);
    response.sendRedirect(request.getContextPath() + "/product/AdminProductList.jsp");
%>

</body>
</html>
