<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.util.*"%>
<%@page import="com.mlb.store.dto.*"%>
<%
	String contextpath = request.getContextPath() + "/";
	String category = request.getParameter("ca_id"); // 카테고리(BallCap, Hat, ...)
	String[] teams = request.getParameterValues("team"); // 팀
	String sort = request.getParameter("sort"); // 최신순/기본순 정렬
	String items = request.getParameter("search"); // 검색
	
	com.mlb.store.dao.ProductsStocksDao dao = new com.mlb.store.dao.ProductsStocksDao(); // dao 호출
	ArrayList<ProductsStocksDto> dto = null; // ArrayList에 dto담아 초기화
	int count = 0; // count(상품개수) 초기화
	
	// 검색->팀별조회 없음
/* 	if(teams!=null){
 		dto = dao.selectByCaTeams(category, teams);
 	}else if(items!=null && !items.isEmpty()){
 		if("latest".equals(sort)){
 			dto = dao.searchProductsByDate(items);
 		}else{
 			dto = dao.searchProducts(items);
 		}
 		count = dao.countProducts(items);
 	}else if("latest".equals(sort)){
 		dto = dao.selectByCaDate(category);
 	}else{
 		dto = dao.selectAllByCategory(category);
 	} */


	// 검색(카테고리 분류 없음)
 	if(items != null && !items.isEmpty()) { 
	    if(teams != null) { // 팀 선택
	        dto = dao.searchProductsByTeams(items, teams); //검색+팀별 조회
	        count = dao.countProductsByTeams(items, teams); // 해당 상품 카운트
	    }else {
	    	dto = "latest".equals(sort) ? dao.searchProductsByDate(items)
	    			: dao.searchProducts(items); // 검색+최신정렬 ? 최신정렬 : 기본정렬
	    	count = dao.countProducts(items); // 해당 상품 카운트
	    }
 	// 검색X
	}else {
		if(teams != null) { // 팀 선택
	    	dto = dao.selectByCaTeams(category, teams);  // 팀별조회
		}else if("latest".equals(sort)) {  // 최신정렬
		    dto = dao.selectByCaDate(category); //최신정렬
		}else { // 검색x, 팀선택x, 최신정렬x -> 기본정렬
		    dto = dao.selectAllByCategory(category); 
		}
	}


	request.setAttribute("items", items); // 검색 단어
	request.setAttribute("count", count); // 상품 갯수
 	request.setAttribute("productsList", dto); // dto
 	request.setAttribute("category", category); // 카테고리
 	request.setAttribute("contextpath", contextpath);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Products</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<style>

*{
	margin: 0px;
	padding: 0px;
	list-style:none;
	font-family: 'Noto sans KR', sans-serif;
}

a{
	text-decoration: none;
	color: #000000;
}

.products {
    display: flex;
    flex-wrap: wrap;
    justify-content: flex-start;
    gap: 10px;
    padding: 20px;
    margin: 0 50px;
}

.products ul {
    width: calc(20% - 10px);
    box-sizing: border-box;
    text-align: center;
    margin-bottom: 50px;
}


@media screen and (max-width: 992px) {
    .products ul {
        width: calc(33.33% - 10px);
    }
}


@media screen and (max-width: 600px) {
    .products ul {
        width: calc(100% - 10px);
    }
}

.filter {
    display: flex; 
    justify-content: flex-start;
    align-items: center; /* 수직 정렬 */
    gap: 15px; /* 요소 간 간격 */
    padding: 15px;
    border-radius: 10px;
    background-color: white; /* 배경색 */
    margin:10px 70px 30px 70px;
}


.filter1, .filter2, .filter3 {
    display: flex;
    align-items: center;
    gap: 10px; /* 내부 요소 간격 */
}


.filter3{
	margin-left:auto;
}


.filter button {
    background-color: #000000;
    color: white;
    border: none;
    padding: 8px 12px;
    border-radius: 5px;
    cursor: pointer;
}


.filter input[type="text"] {
    padding: 5px;
    border: 1px solid #ddd;
    border-radius: 5px;
}

@media screen and (max-width: 1000px) {
    .filter {
        flex-direction: column;
        align-items: flex-start;
    }
    
    .filter1, .filter2, .filter3 {
        width: 100%;
        justify-content: flex-start;
    }
    
    .filter3 {
        margin-left: 0;
    }
}

.noProduct{
	text-align:center;
}

.productName{
	margin-bottom: 5px;
	white-space: nowrap; 
    overflow: hidden;    
    text-overflow: ellipsis;
}
.productPrice{
	font-weight: bold;
}

.category{
	font-size: 30px;
	margin-left: 70px;
	font-weight: bold;
}

.productImg{
	background-color:#F8F8F8;
	margin-bottom: 15px;
}

</style>
</head>
<body>
<jsp:include page="/topnavigator.jsp"></jsp:include>



<!-- 카테고리 별 팀 선택 -->
<div class="filter">
	<form action="productcategory.jsp" method="get" class="filter1">
		<label for="team"></label>
		<c:if test="${not empty category }">
		<input type="hidden" name="ca_id" value="${category }">
		</c:if>
		<c:if test="${not empty items }">
			<input type="hidden" name="search" value="${items }">
		</c:if>
	    <input type="checkbox" name="team" value="LaDodgers"> LA 다저스
	    <input type="checkbox" name="team" value="Boston"> 보스턴 레드삭스
	    <input type="checkbox" name="team" value="Cleveland"> 클리블랜드 가디언스
	    <input type="checkbox" name="team" value="NYKees"> 뉴욕 양키스
	    <input type="checkbox" name="team" value="SanGiants"> 샌프란시스코 자이언츠
	    <button type="submit">조회</button>
	</form>
	
	
	<!-- 카테고리 별 최신상품순 조회 -->
	<form action="productcategory.jsp" method="get" class="filter2">
		<c:if test="${not empty category }">
			<input type="hidden" name="ca_id" value="${category }">
		</c:if>
		<c:if test="${not empty items }">
			<input type="hidden" name="search" value="${items }">
		</c:if>
		<input type="hidden" name="sort" value="latest">
		<button type="submit">최신상품순</button>
	</form>
	
	
	<!-- 전체 상품 내 검색 -->
	<form action="productcategory.jsp" method="get" class="filter3">
		상품검색: <input type="text" name="search">
		<input type="hidden" name="sort" value="default">
		<button type="submit">검색</button>
	</form>
</div>


<!-- 카테고리/검색 시 상품개수 조회 -->
<c:choose>
	<%-- 카테고리별 조회(검색 x) --%>
	<c:when test="${not empty category }">
		<p class="category">${category }</p>
	</c:when>
	
	<%-- 카테고리 무시 조회(검색) --%> 
	<c:when test="${not empty count }">
		<p class="category">전체상품(${count })</p>
	</c:when>
</c:choose>


<c:choose>
	<%-- dto가 비어있으면 --%>
	<c:when test="${empty productsList }">
		<p class="noProduct">상품을 찾을 수 없습니다.</p>
	</c:when>
	
	<%-- dto가 있으면 --%>
	<c:otherwise>
	<div class="products">
		<!-- dto를 product 변수에 담아 반복 -->
		<c:forEach var="product" items="${productsList }">
			<ul>
				<li>
					<div class="productImg">
						<a href="${contextpath }store/productDetail.jsp?pr_id=${product.prID }">
							<img src="${thumImgDir }${product.prThumImg }" width="200px">
						</a>
					</div>
				</li>
				<li>
					<div class="productName">
						<a href="${contextpath }store/productDetail.jsp?pr_id=${product.prID}">
							${product.prName }
						</a>
					</div>
				</li>
				<li>
					<div class="productPrice">${product.price }</div>
				</li>
			</ul>
		</c:forEach>
	</div>
	</c:otherwise>
</c:choose>
</body>
</html>