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
    <title>MLB - AdminProductStockDeleteDB</title>
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
    Long productId = null;
    Long productStockId = null;
    try {
        productId = Long.parseLong(productIdString);
        productStockId = Long.parseLong(productStockIdString);
    } catch(Exception e){
        response.sendRedirect(request.getContextPath() + "/product/AdminProductEdit.jsp?productId=" + productId + "&error=invalid_input");
        return;
    }
    ProductStockDao productStockDao = new ProductStockDao();

    productStockDao.delete(productStockId);

    response.sendRedirect(request.getContextPath() + "/product/AdminProductEdit.jsp?productId=" + productId);
%>

</body>
</html>
