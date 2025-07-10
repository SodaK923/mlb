<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.mlb.store.dao.StoreProductWithStocksDao"%>
<%@ page import="com.mlb.store.dto.StoreProductWithStocksDto"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<%
String contextPath = request.getContextPath(); 
//contextPath 갖고오기 (프로젝트 경로, 예: /mlbstore 이런 거)

String prIDParam = request.getParameter("pr_id"); 
//요청에서 전달받은 pr_id 파라미터(String)를 가져옴 → prIDParam에 저장

Long prID = (prIDParam != null) ? Long.parseLong(prIDParam) : 1; 
//prIDParam이 null이 아니면 Long으로 파싱, null이면 1번 상품 기본으로 보여줌 (예외 방지 목적)

HttpSession sessionObj = request.getSession(); 
//세션 객체 생성 또는 기존 세션 가져오기

String userID = (String) sessionObj.getAttribute("user_id"); 
//세션에서 로그인된 유저의 ID 가져오기 (현재는 예제용)

StoreProductWithStocksDao dao = new StoreProductWithStocksDao(); 
//DAO 객체 생성 (DB 작업하려고)

StoreProductWithStocksDto product = dao.selectByPrID(prID); 
//prID에 해당하는 상품 + 재고 정보 DB에서 가져와서 product에 저장

String selectedColor = request.getParameter("color"); 
//사용자가 선택한 색상 가져오기

String selectedSize = request.getParameter("size"); 
//사용자가 선택한 사이즈 가져오기

request.setAttribute("contextPath", contextPath); 
//contextPath를 request 영역에 저장 → JSP에서 ${contextPath}로 사용 가능

request.setAttribute("product", product); 
//상품 객체를 request 영역에 저장

request.setAttribute("selectedColor", selectedColor); 
request.setAttribute("selectedSize", selectedSize); 
//선택된 색상, 사이즈도 request 영역에 저장 → 화면에 선택값 유지

request.setAttribute("sizeList", (selectedColor != null) ? dao.getSizesByColor(prID, selectedColor) : new ArrayList<>()); 
//색상 선택되어 있으면 해당 색상의 사이즈 리스트 가져오고, 없으면 빈 리스트 반환

request.setAttribute("stockQuantity", (selectedColor != null && selectedSize != null)  ? dao.getStockByColorAndSize(prID, selectedColor, selectedSize)  : 0); 
//색상+사이즈가 다 선택되었으면 해당 조합의 재고 수량 가져오고, 아니면 0

Long prStId = null; 
if (selectedColor != null && selectedSize != null) {
 prStId = dao.getPrStIdByColorAndSize(prID, selectedColor, selectedSize); 
 // 선택된 조건에 해당하는 재고(pr_st_id) 찾아서 저장
 request.setAttribute("prStId", prStId); 
 // 재고 ID도 request에 저장 → 장바구니 담기 같은 기능에서 사용
}



System.out.println(" pr_st_id: " + request.getAttribute("prStId"));
System.out.println(" color: " + request.getParameter("color"));
System.out.println(" size: " + request.getParameter("size"));
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품 상세 페이지</title>
<style>
.container {
	max-width: 1200px;
	width: 90%;
	margin: 0 auto;
	display: flex;
	flex-wrap: wrap;
	align-items: flex-start;
	justify-content: space-between;
}

.left-section {
	width: 55%;
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-bottom: 20px;
}

.right-wrapper {
	width: 35%;
	display: flex;
	flex-direction: column;
	gap: 20px;
	position: sticky;
	top: 100px;
	padding-top: 100px;
}

.details-image img {
	width: 100%;
	height: auto;
	max-width: 100%;
}

.tab-menu {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 20px;
	flex-wrap: wrap;
}

.tab-menu button {
	padding: 12px 18px;
	border: 2px solid #007bff;
	border-radius: 25px;
	background-color: white;
	color: #007bff;
	font-weight: bold;
	cursor: pointer;
	transition: 0.3s;
	font-size: 14px;
}

.tab-menu button:hover {
	background-color: #007bff;
	color: white;
}

.product-title {
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 10px;
	display: block;
}

.stock-quantity {
	margin-bottom: 20px;
}

.buttons {
	display: flex;
	gap: 10px;
	margin-top: 20px;
}

.buttons button {
	flex: 1;
	padding: 12px 18px;
	font-size: 16px;
	font-weight: bold;
	border: none;
	cursor: pointer;
	border-radius: 5px;
	transition: 0.3s;
	width: 120px;
	height: 40px;
}

.cart-button {
	background-color: #ddd; /* 회색 */
	color: black;
}

.buy-button {
	background-color: #007bff; /* 파란색 */
	color: white;
}

.buttons button:hover {
	opacity: 0.8;
}

@media screen and (max-width: 1024px) {
	.container {
		flex-direction: column;
		align-items: center;
	}
	.right-wrapper {
		width: 100%;
		position: static;
	}
	.right-wrapper {
		order: 2;
		margin-top: 20px;
	}
	.left-section {
		width: 100%;
		margin-bottom: 20px;
	}
	.left-section {
		order: 1;
	}
}

@media screen and (max-width: 768px) {
	.details-image img {
		width: 80%;
	}
}
</style>
<script>
    function showSection(sectionId) {
        document.querySelectorAll('.details-section').forEach(section => {
            section.style.display = 'none';
        });
        document.getElementById(sectionId).style.display = 'block';
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }


    window.onload = function() {
        showSection('details'); // 'details' 섹션을 기본적으로 펼쳐지게 함
    };
</script>
</head>
<body>
	<jsp:include page="/topnavigator.jsp"></jsp:include>
	<div class="container">
		<div class="left-section">
			<div class="product-image">
				<!-- 썸네일 이미지 가져옴.. request.setAttribute("product", product); << 여기서 가져온건가?  -->
				<img src="${contextPath}/primg/thum/${product.prThumImg}" width="400px"> 
			</div>

			<div class="tab-menu-wrapper">
				<div class="tab-menu">
					<button onclick="showSection('details')">상세정보</button>
					<button onclick="showSection('review')">리뷰</button>
					<button onclick="showSection('qna')">Q&A</button>
					<button onclick="showSection('return')">반품, 교환</button>
				</div>

				<div id="details" class="details-section">
					<h2>상세정보</h2>
					<div class="details-image">
						<img src="${contextPath}/primg/detail/${product.prDetailImg}" alt="" /> <!-- 디테일 이미지 가져옴 -->
					</div>
				</div>
				<div id="review" class="details-section">
					<h2>리뷰</h2>
					<p>사용자 리뷰 목록이 들어갑니다.</p>
				</div>
				<div id="qna" class="details-section">
					<h2>Q&A</h2>
					<p>자주 묻는 질문과 답변이 들어갑니다.</p>
				</div>
				<div id="return" class="details-section">
					<h2>반품, 교환</h2>
					<p>반품 및 교환 정책이 들어갑니다.</p>
				</div>
			</div>
		</div>
	</div>

		<div class="right-wrapper">
			<div class="product-info-section">
				<c:if test="${not empty product}"> <!-- 상품이 있으면 -->
					<div class="product-title">${product.prName}</div> <!-- 상품명 가져옴 -->
					<br>
					<p>카테고리: ${product.caID}</p>
					<br>
					<p>팀: ${product.tmID}</p>
					<br>
					<p>가격: ${product.price}원</p>
					<br>
				</c:if>
				<c:if test="${empty product}">
					<p>상품 정보를 불러오는 중 오류가 발생했습니다.</p>
				</c:if>

				<form action="${contextPath}/store/productDetail.jsp" method="get">
					<input type="hidden" name="pr_id" value="${product.prID}">
					<label for="color">색상 선택:</label> <select id="color" name="color" onchange="this.form.submit()"> <!-- onchange 가 뭐지? -->
						<option value="">색상 선택</option>
						<c:set var="checkedColors" value="" /> <!-- checkedColors 변수 선언 -->
						<c:forEach var="stock" items="${product.productStocks}"> <!-- 상품재고를 stock 변수에 담아 반복 -->
							<c:if test="${not fn:contains(checkedColors, stock.clID)}"> <!-- 함수? -->
								<option value="${stock.clID}" ${selectedColor == stock.clID ? "selected" : ""}>
									${stock.clID}
								</option>
								<c:set var="checkedColors" value="${checkedColors},${stock.clID}" />
							</c:if>
						</c:forEach>
					</select>
				</form>

				<br>
				<p class="stock-quantity">재고수량: ${selectedColor == null || selectedSize == null ? "색상 사이즈 선택 시 확인 가능" : stockQuantity}(개)</p>

				<div class="buttons">
					<!-- 장바구니 버튼 -->
					<form action="" method="post">
						<input type="hidden" name="user_id" value="${user_id}"> 
						<input type="hidden" name="pr_st_id" value="${prStId}"> 
						<input type="hidden" name="quantity" value="1">
						<button class="cart-button" formaction="<%= selectedColor != null && selectedSize != null ? (contextPath + "/cart/cart.jsp") : "" %>" onclick="<%
							if(session.getAttribute("user_id") == null) {
								out.println("alert('로그인 후 이용 가능합니다.'); location.href='" + contextPath + "/customer/login.jsp'; return false;");
							} else if(selectedColor == null || selectedSize == null) {
								out.println("alert('옵션을 선택해 주세요'); return false;");
							} else {
								out.println("this.form.submit();");
							}
						%>" >장바구니</button>
					</form>

					<!-- 구매하기 버튼 -->
					<form action="" method="post">
						<input type="hidden" name="user_id" value="${user_id}"> 
						<input type="hidden" name="pr_st_id" value="${prStId}">
						<input type="hidden" name="quantity" value="1">
						<button class="buy-button" formaction="<%= selectedColor != null && selectedSize != null ? (contextPath + "/order/payments.jsp") : "" %>" 
						onclick="<%
							if(session.getAttribute("user_id") == null) {
								out.println("alert('로그인 후 이용 가능합니다.'); location.href='" + contextPath + "/customer/login.jsp'; return false;");
							} else if(selectedColor == null || selectedSize == null) {
								out.println("alert('옵션을 선택해 주세요'); return false;");
							} else {
								out.println("this.form.submit();");
							}
						%>" >구매하기</button>
					</form>
				</div>
			</div>
		</div>
</body>
</html>