<%@page import="java.util.HashMap"%>
<%@page import="com.mlb.order.dto.ProductDto"%>
<%@page import="com.mlb.order.dao.ProductListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>MLB cap shopping Mall</title>
<style>

.contentsbody{
	display:block;
	margin:0 auto;
}

.productListContainer{
	max-width:1000px;
	min-width:700px;
	display:flex;
	justify-content: center;
	text-align: center;
	margin: 0 auto;
}

.productTileBar{
	max-width:1000px;
	min-width:700px;
	height: 50px;
	margin: 0 auto;
	margin-bottom: 20px;
	padding-top:20px;
	border-bottom: 2px solid #000000;
	color: #6fa8dc;
	font-size: 1.5em;
	text-decoration: none;
	font-family: "Kanit", sans-serif;
	font-weight: 600;
}

.productContainer{
	display:block;
	width:25%;
	margin:0px 10px;
	/*border:1px solid black;*/
	
	color:#444444;
	font-size: 0.9em;
	text-decoration: none;
	font-family: "Kanit", sans-serif;
	font-weight: 400;
}

.productPrice{
	color:#e215a3;
	font-size: 1.1em;
	text-decoration: none;
	font-family: "Kanit", sans-serif;
	font-weight: 600;
	margin:20px 0px;
}

.productColorChip{
	display: block;
	justify-content: center;
}


<%-- 사용안함 
.colorchip{
	width:12px;
	height:12px;
	border-radius: 6px;
	margin:4px 4px;
	border:1px dashed #999999;
}--%>

.sizechip{
	border-radius: 5px;
	margin:10px 1px;
	padding:1px 5px;
	border:1px solid #DDDDDD;
	
	color:#EEEEEE;
	font-size: 0.4em;
	text-decoration: none;
	font-family: "Kanit", sans-serif;
	font-weight: 300;
	
	position: relative;
  	display: inline;
}

.sizechip .tooltiptext {
	
    visibility: hidden;
 	width: 80px;
 	background-color: black;
 	color: #fff;
 	text-align: center;
 	border-radius: 6px;
 	padding: 5px 0;
  
    /* Position the tooltip */
 	position: absolute;
 	z-index: 1;
 	bottom: 100%;
 	left: 50%;
 	margin-left: -40px; 
}

.sizechip:hover {
	cursor: n-resize;
}
.sizechip:hover .tooltiptext {
    visibility: visible;
}


@media screen and (max-width: 700px) {
	.productTileBar{
		width:100vw;
		padding-left:5vw;
		background-color: #6fa8dc;
		color: #FFFFFF;
		border-bottom:0px;
		font-size: 2.5em;

	}
	
	.productListContainer{
		width:100vw;
		display:inline-block;
		justify-content: center;
		text-align: center;
		margin: 0 auto;
	}

	.productContainer{
		justify-content: center;
		width:50vw;
		margin:0% 25vw;
		font-size: 2.0em;
	}
	
	.productPrice{
		font-size: 1.2em;
	}

}

</style>

</head>
<body>



<%
	//root 디렉토리 
	String approot = application.getContextPath() +"/";
	application.setAttribute("approot", approot);
	
	//'BallCap' , 'Hat'  , 'Season' ,'Beanie'
	// 최근등록 카테고리 별 4개 상품 SELECT //
	ProductListDao productDao = new ProductListDao();
	ArrayList<ProductDto> ballCap = productDao.selectByCategoryProductList("BallCap", 1, 4);	
	ArrayList<ProductDto> hat     = productDao.selectByCategoryProductList("Hat", 1, 4);
	ArrayList<ProductDto> season  = productDao.selectByCategoryProductList("Season", 1, 4);
	ArrayList<ProductDto> beanie  = productDao.selectByCategoryProductList("Beanie", 1, 4);
	
	// 메인 디스플레이 될 모든 상품 리스트 =
	ArrayList<ArrayList<ProductDto>> displayProducts = new ArrayList<>();
	displayProducts.add( ballCap );
	displayProducts.add( hat );
	displayProducts.add( season );
	displayProducts.add( beanie );
	
	pageContext.setAttribute("displayProducts" , displayProducts);
	
%>

<%!
	// Declare 선언부
    // 헥스코드를 RGB 값으로 변환 후 밝기 판단
    boolean isBrightColor(String hexcode) {
	
        int code = Integer.parseInt(hexcode.replace("#", ""), 16);
        int r = (code >> 16) & 0xFF;
        int g = (code >> 8) & 0xFF;
        int b = code & 0xFF;
        int brightness = (r * 299 + g * 587 + b * 114) / 1000;
        //System.out.println("Brightness: " + brightness);
        return brightness > 127; // 0~255 기준 
        
    }
%>

<jsp:include page="./topnavigator.jsp" />

<div class="contentsbody">

<c:forEach var="pdList" items="${displayProducts}">

	<!-- 상품리스트 4개 -->
	<c:set var="pdtitle" value="${pdList.get(0).caId}" />
	<div class="productTileBar">${pdtitle}</div>
	<c:remove var="pdtitle" />
	
	
	<div class="productListContainer">

	<c:forEach var="productDto" items="${pdList}" varStatus="loop">
    
    
    
    <div class="productContainer"><%-- 1개상품 Start --%>
    
        <div class="productThum"><%-- 상품 ThumNail --%>
        	<a href="${approot}store/productDetail.jsp?pr_id=${productDto.prId}" alt="${productDto.prName} / ${productDto.prId}">
            	<img width="100%" src="${thumImgDir}${productDto.prThumImg}" />
            </a>
        </div>
        
        
        <%--<div class="productPrID">${productDto.prId}</div>
        <div class="productTmID">${productDto.tmId}</div>
        <div class="productCaID">${productDto.caId}</div> --%>
        
        
        <div class="productName"><%-- 상품명 --%>
        
        	<c:choose>
        
        		<c:when test="${fn:length(productDto.prName) > 19}">
        			${fn:substring(productDto.prName, 0, 17)}...
        		</c:when>
        
        		<c:otherwise>
        			${productDto.prName}
        		</c:otherwise>
        
        	</c:choose>
        
        </div>
        
        <%--제고 보유한 컬러 & 사이즈 표기 --%>
        <div class="productColorChip">
        
			<c:forEach var="stockcolor" items="${productDto.stockColors}">
			
			    <c:set var="hexcode" value="${stockcolor.hexcode}" />
			    <%
 			       boolean isBright = isBrightColor((String) pageContext.getAttribute("hexcode"));
 			       pageContext.setAttribute("isBright", isBright);
 			    %>
    
 			  	<p>
  			      <c:forEach var="stocksize" items="${productDto.getStockSize(stockcolor.id)}">
  			          <span class="sizechip" style="background-color:${hexcode}; color:${isBright ? '#000000' : '#FFFFFF'};" >
  			              ${stocksize} 
  			              <span class="tooltiptext" >
  			              	quantity: <fmt:formatNumber value="${productDto.getStockQuantity(stockcolor.id,stocksize)}" />
  			              </span> 
   			         </span>
	    		  </c:forEach>
				</p>
				
			</c:forEach>
			
			<%-- 변수 제거 --%>
			<c:remove var="hexcode"/>
			<c:remove var="isBright"/>
			
        </div>
        
        
        <div class="productPrice"> <%--가격 표기 --%>
            <c:if test="${not empty productDto.price}">
                <fmt:formatNumber value="${productDto.price}" type="currency" />
            </c:if>
        </div>
        
    </div> <%-- 1개상품 End --%>
    
	</c:forEach>

	</div>
	
</c:forEach>

</div>


<div style="height:100px;">

</div>

</body>
</html>