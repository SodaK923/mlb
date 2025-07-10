<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sample Test Code Page</title>
<style type="text/css">
body{
	text-align: center;
}
</style>
</head>
<body>
<jsp:include page="/topnavigator.jsp"></jsp:include>

<%
	ArrayList<String> thumImglist = new ArrayList<>();
	thumImglist.add("ballcap_ace_ny.jpg");
	thumImglist.add("ballcap_basic_wash_ny.jpg");
	thumImglist.add("ballcap_color_denim_ny.jpg");
	// page 내에서 ${thumImglist} ELtag 변수로 사용하기 위해 setAttribute 함.
	pageContext.setAttribute("thumImglist", thumImglist);
	
	// 스크립 트릿내에서 세션정보 이용 시 아래와 같이 getAttribute  이용
	if( session.getAttribute("user_id") != null )
	{
		long user_id = Long.parseLong( (String) session.getAttribute("user_id") ) ;
		String grade = (String) session.getAttribute("grade");
		String name = (String) session.getAttribute("name");
		out.println("스크립트릿에서 세션정보 호출 <br>");
		out.println( String.format("user_id: %d , grade:%s , name:%s ", user_id, grade , name ) );
		out.println( "<hr>");
	}
	
%>
<h5>Context-Param값 읽어오기</h5>
OracleDriver: ${OracleDriver}<br>
approot: ${approot}<br>

<hr>
userId: if 로그인 조건 (문자열비교)

<c:if test="${not empty user_id && grade eq 'admin'}">
	<h1>user_id: ${user_id}  , name: ${name} 으로 로그인 된 <span style="color:red">관리자</span> 입니다.</h1>
</c:if>

<c:if test="${not empty user_id && grade ne 'admin'}">
	<h1>user_id: ${user_id}  , name: ${name} 으로 로그인 된 <span style="color:red">일반사용자</span> 입니다.</h1>
</c:if>

<c:if test="${empty user_id}">
	<h1>로그인 하세요.</h1>
</c:if>

<hr>
thumImglist: 반복문 AND case 조건문 테스트 
<br>

<%-- jstl 반복문 & case 조건테스트 --%>
<c:forEach var="imgfile" items="${thumImglist}" varStatus="loop">

	count:${loop.count}<br>
	<c:choose>
	
		<c:when test="${loop.first}">
			<h1>imgstart</h1>
			<img width="100" src="${thumImgDir}${imgfile}" ><br>
		</c:when>
		
		<c:when test="${loop.last}">
			<img width="100" src="${thumImgDir}${imgfile}" ><br>
			<h1>imgEnd</h1>
		</c:when>
		
		<c:otherwise>
			<img width="100" src="${thumImgDir}${imgfile}" ><br>
		</c:otherwise>
	
	</c:choose>
	
</c:forEach>

<c:forEach var="imgfile" items="${thumImglist}" varStatus="loop">

	count:${loop.count}<br>
	<c:choose>
	
		<c:when test="${loop.first}">
			<h1>imgstart</h1>
			<img width="100" src="${thumImgDir}${imgfile}" ><br>
		</c:when>
		
		<c:when test="${loop.last}">
			<img width="100" src="${thumImgDir}${imgfile}" ><br>
			<h1>imgEnd</h1>
		</c:when>
		
		<c:otherwise>
			<img width="100" src="${thumImgDir}${imgfile}" ><br>
		</c:otherwise>
	
	</c:choose>
	
</c:forEach>

</body>
</html>