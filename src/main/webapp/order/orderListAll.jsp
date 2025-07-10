<%@page import="com.mlb.order.dto.OrderUserDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mlb.order.dto.OrderDto"%>
<%@page import="com.mlb.order.dao.OrderListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%

	request.setCharacterEncoding("UTF-8");
	
	boolean hasList = false;
	
	Long totalPageCnt = 0L;
	Long orderId = 0L;
	int currentPageNum = 0;
	int startLinkPageNum = 1;
	Long listViewCnt = 10L;
	
	if( session.getAttribute("grade") != null )
	{
		//System.out.println("user_id");
		String grade = (String)session.getAttribute("grade");
		ArrayList<OrderUserDto> orderList = null;
		ArrayList<OrderDto> oderDetails = null;
		
		if( grade.equals("admin") )
		{
			
			OrderListDao orderListDao = new OrderListDao();
			Long orderCnt = orderListDao.selectOrderCnt();
			
			if( request.getParameter("pageNum") != null )
			{
				currentPageNum = Integer.parseInt( (String) request.getParameter("pageNum") );
				
				if( orderCnt > 0 )
					totalPageCnt = (long) Math.ceil( (double)orderCnt / listViewCnt );
				
				startLinkPageNum = ( currentPageNum / 10 ) + 1;
				orderList = orderListDao.selectOrderUserList( currentPageNum , listViewCnt , 0L);
				
				System.out.println("currentPageNum: " + currentPageNum + " , orderCnt: " + orderCnt  );
				System.out.println("startLinkPageNum: " + startLinkPageNum + " , totalPageCnt: " + totalPageCnt  );
			}
			
			if( request.getParameter("orderId") != null )
			{
				orderId = Long.parseLong( (String)request.getParameter("orderId") );
				
				if( request.getParameter("shippingDate") != null )
				{
					orderListDao.updateShippingDate( orderId );
				}
				
				orderList = orderListDao.selectOrderUserList(0,0L,orderId);
				oderDetails = orderListDao.selectOrderList(0L,orderId);
				
				pageContext.setAttribute("orderId" , orderId);
				pageContext.setAttribute("oderDetails" , oderDetails);
				System.out.println("oderDetails : " + oderDetails.size());
				
				
			}
			
			if( orderList != null && orderList.size() > 0 )
			{
				hasList = true;
				pageContext.setAttribute("orderList" , orderList);
				System.out.println("hasList---- true" + orderList.size());
			}
		}
		
	}
	
	
	pageContext.setAttribute("hasList" , hasList);
	
	if( orderId == 0L && currentPageNum != 0 ) // orderId 없이 pageNum 만 있는 경우
	{
		pageContext.setAttribute("startLinkPageNum" , startLinkPageNum );
		pageContext.setAttribute("currentPageNum" , currentPageNum );
		pageContext.setAttribute("totalPageCnt" , totalPageCnt );
		pageContext.setAttribute("listViewCnt" , listViewCnt );
		
	}
	
	
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
	max-width:1300px;
	min-width:700px;
	display:block;
	justify-content: center;
	margin: 0 auto;
	border-bottom:2px solid #b3ccff;
	padding:10px;
	font-weight: 400;
	font-size:2.0em;
}

.orderContainer{
	max-width:1300px;
	min-width:700px;
	display:block;
	justify-content: center;
	margin: 0 auto;
	padding:10px;
}

.orderDetailContainer{
	max-width:1300px;
	min-width:700px;
	display:block;
	justify-content: center;
	margin: 0 auto;
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

#orders {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#orders td, #orders th {
  border: 1px solid #ddd;
  padding: 8px;
}

#orders tr:nth-child(even){background-color: #f2f2f2;}

#orders tr:hover {background-color: #ddd;}

#orders th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: center;
  background-color: #b3ccff;
  color: white;
}

.pageLinkFooter{
	display:flex;
	max-width:1300px;
	min-width:700px;
	height:50px;
	justify-content: center;
	margin: 0 auto;
	padding:10px;
}

.btnDetail{
	background-color: black;
	border-radius: 5px;
	height: 30px;
	text-decoration: none;
	color:white;
}

.btnDetail:hover , .btnDetail:active{
	background-color: #0066ff;
	text-decoration: none;
}

.btnDetail:visited{

}


#ordersDetails {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#ordersDetails td, #ordersDetails th {
  border: 1px solid #ddd;
  padding: 8px;
}

#ordersDetails tr:nth-child(even){background-color: #f2f2f2;}

/* #ordersDetails tr:hover {background-color: #ddd;}*/

#ordersDetails th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: center;
  background-color: #b3ccff;
  color: white;
}


.productPrice{
	color:#444;
	font-size: 1.0em;
	text-decoration: none;
	font-family: "Kanit", sans-serif;
	font-weight: 600;
	margin:20px 20px;
	padding:10px;
}

.orderListBtnContainer{
	display:flex;
	justify-content: center;
	margin: 0 auto;
}

.orderListBtn:link, .orderListBtn:visited {
	background-color: black;
	color: white;
	padding: 14px 25px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
  	border-radius: 5px;
	font-family: "Kanit", sans-serif;
	font-weight: 600;
	margin: 20px 0px;
}

.orderListBtn:hover, .orderListBtn:active {
  background-color: darkgray;
}

.footPageLink:link , .footPageLink:visited {
	text-decoration: none;
	color:black;
}

.footPageLink:hover, .footPageLink:active {
	text-decoration: underline;
}


</style>

</head>
<body>
<jsp:include page="/topnavigator.jsp" />

<%-- page Title --%>


	
<c:if test="${currentPageNum ne null && currentPageNum ne 0 }">
	<div class="pageTitle">Cap Mall 전체 주문 내역</div>
</c:if>

<c:if test="${orderId ne null && orderId ne 0 }">
	<div class="pageTitle"> 주문번호: [ ${orderId } ]  상세주문내역</div>
</c:if>

<%-- 사용자 주문목록 Start--%>
<c:if test="${hasList eq true }">

<div class="orderContainer">

	<table id="orders">
		<tr>
			<th> No </th>
			<th>주문번호</th>
			<th>회원아이디</th>
			<th>이름</th>
			<th>연락처</th>
			<th>결제수단</th>
			<th>결제금액</th>
			<th>배송주소</th>
			<th>배송일</th>
			<th>결제일</th>
			<th></th>
		</tr>
	
	<c:forEach var="dto" items="${orderList}">
		<tr>
			<td>${dto.numId }</td>
			<td>${dto.orderId }</td>
			<td>${dto.logId }</td>
			<td>${dto.userName }</td>
			<td>${dto.userHP }</td>
			<td>${dto.payId }</td>
			<td><fmt:formatNumber value="${dto.totalPrice }" type="currency" /></td>
			<td>${dto.shippingAddress }</td>
			<td>${dto.shippingDate.toLocalDate() }</td>
			<td>${dto.orderDate.toLocalDate() }</td>
			<td width= "70px">
			<c:if test="${orderId eq null }">
				<a href="orderListAll.jsp?orderId=${dto.orderId}" class="btnDetail" >주문상세</a>
			</c:if>
			<c:if test="${orderId ne null && dto.shippingDate.toLocalDate() eq null}">
				<a href="orderListAll.jsp?orderId=${dto.orderId}&shippingDate=true" class="btnDetail" >발송완료</a>
			</c:if>
			</td>
		</tr>
	</c:forEach>
	</table>
</div>

  <%-- ${startLinkPageNum } ~ ${startLinkPageNum+9 }, total: ${totalPageCnt } ,cur: ${currentPageNum } <br> --%>

	<%-- list footer number page navigator --%>
	<c:if test="${ currentPageNum ne null && currentPageNum ne 0 }" >
		<div class ="pageLinkFooter">
			<c:forEach var="pageNum" begin="${startLinkPageNum }" end="${ startLinkPageNum + (listViewCnt-1) }" varStatus="loop" >
		    
			    <c:if test="${ pageNum eq startLinkPageNum && ( startLinkPageNum - listViewCnt ) > 1 }">
			        <span> <a href="orderListAll.jsp?pageNum=${ startLinkPageNum - listViewCnt }"> prev </a> </span>
			    </c:if>
			    
			    <c:if test="${pageNum <= totalPageCnt}">
			    	<span> &nbsp;&nbsp; <a href="orderListAll.jsp?pageNum=${pageNum}" class="footPageLink"> ${pageNum} </a> &nbsp;&nbsp; </span>
			    	<c:if test="${pageNum < totalPageCnt}">
			    		<span> | </span>
			    	</c:if>
			    </c:if>
			    
			    <c:if test="${ pageNum eq startLinkPageNum + (listViewCnt-1) && pageNum < totalPageCnt }">
			        <span> <a href="orderListAll.jsp?pageNum=${ startLinkPageNum + listViewCnt }"> next </a> </span>
			    </c:if>
			 
			</c:forEach>
			
		</div>
	</c:if>

</c:if> <%-- 주문목록 End --%>


<%-- 주문상세 리스트 --%>
<c:if test="${oderDetails ne null && oderDetails.size() ne 0 }" >
<div class="orderDetailContainer">

	<c:forEach var="orderDto" items="${oderDetails}">
		
		<c:forEach var="orderPrId" items="${orderDto.getPrIdList()}">
		<div class="orderDetailContainer">
		<%--<h3>orderPrId: ${orderPrId}</h3>--%>
		
			<c:forEach var="orderDetail" items="${orderDto.getOrderDetailPrId(orderPrId) }" varStatus="loop" >
				<c:if test="${loop.first}">
				<table id="ordersDetails">
					<tr>
						<th colspan="2">${orderDetail.prName}</th>
					</tr>
					<tr>
						<td><img width="100" src="${thumImgDir}${orderDetail.prThumImg}" /></td>
						<td width="90%">
				</c:if>
				
				<%--
				<span>userId: ${orderDetail.userId}</span><br>
				<span>orderDetailId: ${orderDetail.orderDetailId}</span><br>
				<span>prStId: ${orderDetail.product.prStId}</span><br>
				<span>prId: ${orderDetail.product.prId}</span><br>
				--%>
				
				<span class="orderInfoTxt">color: <span class="colorchip" style="background-color:${orderDetail.product.color.hexcode};">&nbsp;</span></span>
				<span class="orderInfoTxt">size: ${orderDetail.product.szId}</span>
				<span class="orderInfoTxt">수량: ${orderDetail.product.quantity}</span>        		
				<span class="productPrice">가격: <fmt:formatNumber value="${orderDetail.product.price}" type="currency" /></span>
				<br>
				
				<c:if test="${loop.last}">
							</td>
						</tr>
					</table>
				</c:if>
				
			</c:forEach>
			
		</div>
		</c:forEach>
		
		
		<div class="orderListBtnContainer">
			<a href="orderListAll.jsp?pageNum=1" class="orderListBtn" >전체 주문 내역</a>
		</div>
		
		

	</c:forEach>

</div>
</c:if>


<c:if test="${hasList eq false}">
	<center>
		<h1> 주문 리스트가 존재 하지 않습니다.</h1>
		<h1> 또는 admin 계정으로 로그인 해주세요.</h1>
	</center>
</c:if>

</body>
</html>











