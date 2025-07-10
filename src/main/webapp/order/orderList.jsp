<%@page import="java.util.ArrayList"%>
<%@page import="com.mlb.order.dto.OrderDto"%>
<%@page import="com.mlb.order.dao.OrderListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%

	request.setCharacterEncoding("UTF-8");
	String viewMode = "cart";
	
	if( request.getParameter("view") != null )
	{
		viewMode = request.getParameter("view");
		pageContext.setAttribute("viewMode" , viewMode);
	}
	
	OrderListDao orderListDao = new OrderListDao();
	boolean hasList = false;
	
	if( session.getAttribute("user_id") != null ) // logIn 되어야만 접근 가능한 페이지
	{
		//System.out.println("user_id");
		String uid = (String)session.getAttribute("user_id");
		Long userId = Long.parseLong(uid);
		ArrayList<OrderDto> orderList = null;
		
		if( viewMode.equals("cart") ) // 사용자 장바구니 목록 
			orderList = orderListDao.selectUserCartList(userId);
		else if( viewMode.equals("order") )
			orderList = orderListDao.selectOrderList(userId,0L);
		
		if( orderList != null && orderList.size() > 0 )
		{
			hasList = true;
			pageContext.setAttribute("orderList" , orderList);
			System.out.println("hasList---- true" + orderList.size());
		}
		
	}
	
	pageContext.setAttribute("hasList" , hasList);
	System.out.println("hasList" + hasList);
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>MLB cap shopping Mall</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<style type="text/css">

body{
	text-decoration: none;
	font-family: "Kanit", sans-serif;
	font-weight: 300;
}

.pageTitle{
	max-width:1000px;
	min-width:700px;
	display:block;
	justify-content: center;
	margin: 0 auto;
	border-bottom:2px solid #b3ccff;
	padding:10px;
	font-weight: 400;
	font-size:3.0em;
}

.orderContainer{
	max-width:1000px;
	min-width:700px;
	display:block;
	justify-content: center;
	margin: 0 auto;
	border:2px solid #b3ccff;
	background-color: #e6eeff;
	padding:10px;
}

.orderInfoTxt{
	margin-left:20px;
}

.orderDetailContainer{
	max-width:1000px;
	min-width:700px;
	display:block;
	justify-content: center;
	margin: 0 auto;
	border-bottom:1px dotted #b3ccff;
	background-color: #FFFFFF;
	margin-bottom: 30px;
	padding:30px;
	box-sizing: content-box;
}

.orderDetailItem{
	display:block;
}

.productTitle{
	color:#1a66ff;
	font-size: 1.5em;
	text-decoration: none;
	font-family: "Kanit", sans-serif;
	font-weight: 600;
	margin:20px 20px;
}


.productPrice{
	color:#e215a3;
	font-size: 1.1em;
	text-decoration: none;
	font-family: "Kanit", sans-serif;
	font-weight: 600;
	margin:20px 20px;
	padding:10px;
}

.colorchip{
	border-radius: 5px;
	margin:5px;
	padding:2px;
	padding-left:20px;
	border:1px solid #000000;	
	position: relative;
  	display: inline;
}

.orderBtnContainer{
	max-width:1000px;
	min-width:700px;
	display:flex;
	justify-content: center;
	margin: 0 auto;
	padding:10px 0px 100px 0px;
}


.orderBtn{
  background-color: black;
  color: white;
  padding: 14px 25px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  cursor:pointer;
  font-family: "Kanit", sans-serif;
  font-weight: 600;
}

.orderBtn:link, .orderBtn:visited {
  background-color: black;
  color: white;
  padding: 14px 25px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
}

.orderBtn:hover, .orderBtn:active {
  background-color: darkgray;
}

.btnCartItem{
	width:80px;
	height:30px;
	background-color: black;
	color:white;
	font-family: "Kanit", sans-serif;
	font-weight: 600;
	border-radius: 5px;
	cursor: pointer;
	padding:5px;
}

.selchkAll{
	max-width:1000px;
	min-width:700px;
	display:flex;
	margin: 0 auto;
	font-family: "Kanit", sans-serif;
	font-weight: 600;
	font-size: 2.0em;
}

#selectAll{
	width:40px;
	height:40px;
	background-color: #b3ccff;
	margin-right:20px;
}

</style>


<script>

function toggleAll(source) {
    let checkboxes = document.querySelectorAll('.item');
    checkboxes.forEach(checkbox => checkbox.checked = source.checked);
}

function orderDetailProcess(action, id = "") {
    // 요청 파라미터 구성
    const params = new URLSearchParams();
    params.append("action", action);
    
    if (action === "del_detail_id") {
        if (id === "" ) {
            alert("아이디가 없습니다.");
            return;
        }
        params.append("orderDetailId", id);
    }

    // AJAX 요청
    fetch( "<%=application.getContextPath()%>/order/tempOrder.jsp" , {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: params.toString()
    })
    .then(response => response.text())
    .then(result => {
        if (result.trim() === "delete-success") {
            alert("✅ 장바구니 아이템 삭제 !");
            location.reload(); // 새로고침
        } else {
            alert("⚠️ 알 수 없는 오류가 발생했습니다.");
        }
    })
    .catch(err => console.error("Error:", err));
}
</script>


</head>
<body>
<jsp:include page="/topnavigator.jsp" />


<%--
hasList: ${hasList}<br>
viewMode: ${viewMode}<br>
 --%>

<%-- page Title --%>
<c:if test="${ viewMode eq 'order'}" >
	<div class="pageTitle">${name} 님의 주문내역 입니다.</div>
</c:if>

<c:if test="${ viewMode eq 'cart'}" >
	<div class="pageTitle">${name} 님의 장바구니 리스트 입니다.</div>
</c:if>

<%-- 사용자 주문목록 Start--%>
<c:if test="${hasList eq true }">

<c:if test="${ viewMode eq 'orderadmin'}" >
	<div class="pageTitle">주문내역 리스트 입니다.</div>
</c:if>

<div class="cotentbody">
	
	<c:forEach var="orderDto" items="${orderList}">
		<c:if test="${ viewMode eq 'order'}" >
		<div class="orderContainer">
		<span class="orderInfoTxt">주문번호: ${orderDto.orderno.orderId }</span>
		<span class="orderInfoTxt">주문일: ${orderDto.orderno.orderDate.toLocalDate() }</span>
		<span class="orderInfoTxt">결제금액: <fmt:formatNumber value="${orderDto.orderno.totalPrice }" type="currency" /></span>
		<span class="orderInfoTxt">결제수단: ${orderDto.orderno.payId }</span><br>
		<span class="orderInfoTxt">배송주소: ${orderDto.orderno.shippingAddress }</span>
		<span class="orderInfoTxt">발송일: ${orderDto.orderno.shippingDate.toLocalDate() }</span>
		</div>
		</c:if>
		<%--
		this.userId = userId;
		this.orderDetailId = orderDetailId;
		this.prName = prName;
		this.prThumImg = prThumImg;
		
		product = new Product( prStId,  prId , clId, szId, orderQuantity, orderPrice);
		 --%>
		 
		<c:if test="${ viewMode eq 'cart' }" >
			<form action="${approot}order/payments.jsp" method="get">
			<label class="selchkAll"><input type="checkbox" id="selectAll" onclick="toggleAll(this)" checked> 전체 선택</label>
		</c:if>
		
		<c:forEach var="orderPrId" items="${orderDto.getPrIdList()}">
		<div class="orderDetailContainer">
		<%--<h3>orderPrId: ${orderPrId}</h3>--%>
		
			<c:forEach var="orderDetail" items="${orderDto.getOrderDetailPrId(orderPrId) }" varStatus="loop" >
				<c:if test="${loop.count eq 1}">
				<span class="productTitle">상품명: ${orderDetail.prName}</span><br>
				<span><img width="200" src="${thumImgDir}${orderDetail.prThumImg}" /></span><br>
				</c:if>
				
				<%--
				<span>userId: ${orderDetail.userId}</span><br>
				<span>orderDetailId: ${orderDetail.orderDetailId}</span><br>
				<span>prStId: ${orderDetail.product.prStId}</span><br>
				<span>prId: ${orderDetail.product.prId}</span><br>
				--%>
				
				<c:if test="${ viewMode eq 'cart'}" >
					<label for="order_detail_id">주문체킹: </label>
					<input class="item" type="checkbox" name="order_detail_id" value="${orderDetail.orderDetailId}" checked />
				</c:if>
				
				<span class="orderInfoTxt">color: <span class="colorchip" style="background-color:${orderDetail.product.color.hexcode};">&nbsp;</span></span>
				<span class="orderInfoTxt">size: ${orderDetail.product.szId}</span>
				<span class="orderInfoTxt">수량: ${orderDetail.product.quantity}</span>        		
				<span class="productPrice">가격: <fmt:formatNumber value="${orderDetail.product.price}" type="currency" /></span>
				
				<c:if test="${ viewMode eq 'cart'}" >
					<span class="btnCartItem" onclick="orderDetailProcess('del_detail_id' , ${orderDetail.orderDetailId} )"> 장바구니에서 삭제 </span>
				</c:if>
				
				<br>
				
			</c:forEach>
			
			
		</div>
		</c:forEach>
		
		
		<c:if test="${ viewMode eq 'cart'  }" >
				<div class="orderBtnContainer">
					<input class="orderBtn" type="submit" value="주문하기" />
				</div>
			</form>
		</c:if>
		

	</c:forEach>
	

</div>
</c:if> <%-- 사용자 주문목록 End --%>




<c:if test="${hasList eq false}">
	<center>
		<h1>리스트가 존재 하지 않습니다.</h1>
	</center>
</c:if>


</body>
</html>











