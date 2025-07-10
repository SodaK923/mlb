<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*" %>
<%@ page import="com.mlb.product.dao.*" %>
<%@ page import="com.mlb.product.dto.*" %>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/Font.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/AdminProductAdd.css">

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%
        request.setCharacterEncoding("UTF-8");
        String grade = (String) session.getAttribute("grade");
        if(grade == null || !grade.equals("admin")){
            response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
            return;
        } else {
            System.out.println("grade: " + grade);
        }
        String error = request.getParameter("error");
        if(error != null && error.equals("exist")){
            out.println("<script>alert('이미 존재하는 상품입니다.');</script>");
        }
        ProductDao productDao = new ProductDao();
        TeamDao teamDao = new TeamDao();
        ArrayList<TeamDto> teamList = teamDao.selectAll();
        ColorDao colorDao = new ColorDao();
        ArrayList<ColorDto> colorList = colorDao.selectAll();
        pageContext.setAttribute("teamList", teamList);
        pageContext.setAttribute("colorList", colorList);
    %>
    <title>MLB - AdminProductAdd</title>
</head>
<body>
<jsp:include page="/topnavigator.jsp"></jsp:include>
    <div class="product">
    <form action="" method="post">
        <h1>상품 수정</h1>
        <table>
            <tr>
                <th>상품명</th>
                <th>팀</th>
                <th>카테고리</th>
                <th>제품 이미지</th>
                <th>설명 이미지</th>
            </tr>
            <tr>
                <td><input class="product-name" type="text" name="productName" value="" required></td>
                <td>
                    <select class="product-team" name="teamId" required>
                    <c:forEach var="team" items="${teamList}">
                        <option value="${team.getTm_id()}">${team.getTm_name()}</option>
                    </c:forEach>
                    </select>
                </td>
                <td>
                    <select class="product-category" name="categoryId" required>
                        <option value="Season">Season</option>
                        <option value="BallCap">BallCap</option>
                        <option value="Hat">Hat</option>
                        <option value="Beanie">Beanie</option>
                    </select>
                </td>
                <td><input class="product-thumbnail-image" type="text" name="productThumbnailImage" value="" required></td>
                <td><input class="product-detail-image" type="text" name="productDetailImage" value="" required></td>
            </tr>
            <tr>
                <td colspan="8">
                    <input type="submit" value="상품 정보 추가" formaction="<%= request.getContextPath() %>/product/AdminProductInsertDB.jsp">
                </td>
        </table>
    </form>
    </div>
</body>
</html>
