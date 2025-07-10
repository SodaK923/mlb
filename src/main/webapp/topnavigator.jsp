<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	request.setCharacterEncoding("utf-8");

	// 오라클드라이버  
	//String OracleDriver = application.getInitParameter("oracleDriver");
	//application.setAttribute("OracleDriver", OracleDriver);
	
	// root 디렉토리 
	String approot = application.getContextPath() +"/";
	application.setAttribute("approot", approot);
	
	// 상품썸네일이미지 디렉토리 
	if(application.getAttribute("thumImgDir") == null )
	{
		String thumImgDir = application.getContextPath() + "/primg/thum/";
		application.setAttribute("thumImgDir", thumImgDir);
	}	
	
	// 상품상세정보이미지 디렉토리 
	if(application.getAttribute("detailImgDir") == null )
	{
		String detailImgDir = application.getContextPath() + "/primg/detail/";
		application.setAttribute("detailImgDir", detailImgDir);
	}
	
	// 리소스 이미지 디렉토리 
	if(application.getAttribute("resource") == null )
	{
		String resources = application.getContextPath() + "/resource/";
		application.setAttribute("resource", resources);
	}
	
	
	if( session.getAttribute("user_id") != null )
	{
		// 로그인 세션 정보저장
		//session.setAttribute("user_id", "1");
		//session.setAttribute("grade", "admin");
		//session.setAttribute("grade", "customer");
		//session.setAttribute("name", "jdbcproj");
	}
	
	//session.getAttribute("user_id");
	//session.getAttribute("grade");
	//session.getAttribute("name");
	
	// 로그아웃 세션 정보제거
	//session.removeAttribute("user_id");
	//session.removeAttribute("grade");
	//session.removeAttribute("name");
	
	// session.invalidate(); <-- 호출하지 마세요~
	
%>

<c:set var="approot" value="${applicationScope.approot}" />
<c:if test="${not empty sessionScope.userId}">
    <c:set target="${sessionScope}" property="user_id" value="${sessionScope.user_id}"/>
    <c:set target="${sessionScope}" property="grade" value="${sessionScope.grade}"/>
    <c:set target="${sessionScope}" property="name" value="${sessionScope.name}"/>
</c:if>


<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<!-- 아이콘 순서대로 기입해야함  -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&icon_names=list_alt,manage_accounts,shopping_bag" />
<style type="text/css">
* {
	margin: 0px;
	padding: 0px;
}

#topnavigation_container {
	display: flex;
	position: sticky;
	justify-content: center;
	top: 0px;
	background: black;
	width: 100%;
	height: 92px;
	color: #FFFFFF;
	font-family: "Lucida Sans", sans-serif;
	z-index: 1000;
}

#topnavigation_container .logo {
	margin: 0px 20px;
	width: 80px;
}

#topnavigation_container .navibox_container {
	margin: 0px 20px;
	width: 900px;
	display: block;
}

#topnavigation_container .usermenu {
	font-family: "Lucida Sans", sans-serif;
	font-size: 1.0em;
	width: 100%;
	height: 30px;
	justify-content: center;
	align-content: center;
	text-align: right;
	margin-top: 20px;
}

#topnavigation_container .customer {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
	background-color: #FFFF00;
}

#topnavigation_container .camenu_container {
	display: flex;
}

#topnavigation_container .camenu_container .camenu {
	width: 25%;
	height: 40px;
	align-content: center;
	color: #FFFFFF;
	text-align: center;
}

#topnavigation_container .camenu_container .camenu:hover {
	background-color: #222222;
	width: 25%;
	color: #FFFFFF;
	text-align: center;
}

.link_white {
	color: #DDDDFF;
	font-size: 1.0em;
	text-decoration: none;
	font-family: "Kanit", sans-serif;
	font-weight: 600;
}

.link_white:hover {
	color: #FFFFFF;
}

.link_white:active :visited {
	
}

.logbtn {
	background-color: black;
}

.logbtn {
	border: none;
	outline: none;
	background-color: inherit;
	cursor: pointer;
}

.material-symbols-outlined {
	color: gray;
}

.material-symbols-outlined:hover {
	color: white;
}

.material-symbols-outlined:active :visited {
	
}

.material-symbols-outlined .tooltiptext {
	visibility: hidden;
	width: 50px;
	background-color: #222222;
	color: #fff;
	text-align: center;
	font-family: dotum;
	font-size: 10px;
	text-transform: capitalize;
	border-radius: 6px;
	padding: 5px 0;
	/* Position the tooltip */
	position: absolute;
	z-index: 1;
	bottom: 100%;
	left: 50%;
	margin-left: -25px;
}

.material-symbols-outlined:hover {
	cursor: pointer;
}

.material-symbols-outlined:hover .tooltiptext {
	visibility: visible;
}

.noto-sans-kr-400 {
	font-family: "Noto Sans KR", sans-serif;
	font-optical-sizing: auto;
	font-weight: 400;
	font-style: normal;
}

#scrollToOutputBtn {
	position: fixed;
	bottom: 10px;
	right: 10px;
	padding: 10px 15px;
	background-color: #007BFF;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

#scrollToOutputBtn:hover {
	background-color: #0056b3;
}

</style>

<script>
function scrollToOutput() {
    //const outputElement = document.getElementById('.logo');
    //outputElement.scrollIntoView({ behavior: 'smooth', block: 'center' });
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

function logprocess(action, id = "", pw = "") {
    // 요청 파라미터 구성
    const params = new URLSearchParams();
    params.append("action", action);
    
    if (action === "login") {
        if (id === "" || pw === "") {
            alert("아이디와 비밀번호를 입력해주세요.");
            return;
        }
        params.append("userId", id);
        params.append("password", pw);
    }

    // AJAX 요청
    fetch( "<%=application.getContextPath()%>/tempAuth.jsp" , {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: params.toString()
    })
    .then(response => response.text())
    .then(result => {
        if (result.trim() === "login-success") {
            alert("✅ 로그인 성공!");
            location.reload(); // 새로고침
        } else if (result.trim() === "login-fail") {
            alert("⚠️ 로그인 실패! 아이디 또는 비밀번호를 확인하세요.");
        } else if (result.trim() === "logout-success") {
            alert("👋 로그아웃 되었습니다.");
            location.reload(); // 새로고침
        } else {
            alert("⚠️ 알 수 없는 오류가 발생했습니다.");
        }
    })
    .catch(err => console.error("Error:", err));
}
</script>
<button id="scrollToOutputBtn" onclick="scrollToOutput()">TOP</button>
<div id="topnavigation_container">

	<c:if test="${not empty user_id && grade eq 'admin'}">
		<div class="logo"><img width="100px" src="${resource}mlblogo.png"/></div>
	</c:if>
	
	<c:if test="${grade ne 'admin'}">
		<div class="logo"><a href="${approot}index.jsp"><img width="100px" src="${resource}mlblogo.png"/></a></div>
	</c:if>
	
	<div class="navibox_container">
	
		<div class="usermenu">
			<c:if test="${not empty user_id && grade eq 'admin'}">
				<span>${name} 님 <span style="color:red">관리자</span> 계정 입니다.</span>
				<button class="logbtn" onclick="logprocess('logout')"><span class="link_white">logOut</span></button>
			</c:if>

			<c:if test="${not empty user_id && grade ne 'admin'}">
				<span>${name} 님 <span style="color:red">일반사용자</span> 계정 입니다. </span>
				<button class="logbtn" onclick="logprocess('logout')"><span class="link_white">logOut</span></button>
				
				
				<a href="${approot}customer/update.jsp">
					<span class="material-symbols-outlined" style="position: relative; top: 5px ; margin-left:5px">
						manage_accounts
						<span class="tooltiptext" >mypage</span>
					</span>
				</a>
				
				<a href="${approot}order/orderList.jsp?view=order">
					
					<span class="material-symbols-outlined" style="position: relative; top: 5px ; margin-left:5px">
						list_alt
						<span class="tooltiptext" >order_list</span>
					</span>
					
				</a>
				
				<a href="${approot}order/orderList.jsp?view=cart">
					
					<span class="material-symbols-outlined" style="position: relative; top: 5px ; margin-left:5px">
						shopping_bag
						<span class="tooltiptext" >cart</span>
					</span>
					
				</a>
				
				
				
			</c:if>
			
			<c:if test="${empty user_id}">
				<a href="${approot}customer/register.jsp"><span class="link_white">join</span></a> | 
				<%-- 
				<button class="logbtn" onclick="logprocess('login','1234','adminpass')"><span class="link_white">adminlogIn</span></button>
				<button class="logbtn" onclick="logprocess('login','johndoe1','password1')"><span class="link_white">customerlogIn</span></button>
				--%>
				<button class="logbtn" onclick="location.href='${approot}customer/login.jsp'"><span class="link_white">logIn</span></button>
			</c:if>
		
		</div>
		
		
		<c:if test="${not empty user_id && grade eq 'admin'}">
			<div class="camenu_container">
				<div class="camenu">
					<a class="link_white" href="${approot}customer/userList.jsp">회원관리</a>
				</div>
				<div class="camenu">
  					<a class="link_white" href="${approot}product/AdminProductList.jsp">상품관리</a>
  				</div>
  				<div class="camenu">
  					<a class="link_white" href="${approot}order/orderListAll.jsp?pageNum=1">주문조회</a>
  				</div>
  				<div class="camenu">
  					<a class="link_white" href="${approot}order/orderStatistics.jsp">매출통계</a>
  				</div>
			</div>
		</c:if>
		
		<c:if test="${grade ne 'admin'}">
			<div class="camenu_container">
			<div class="camenu">
				<a class="link_white" href="${approot}store/productcategory.jsp?ca_id=BallCap">BallCap</a>
			</div>
			<div class="camenu">
  				<a class="link_white" href="${approot}store/productcategory.jsp?ca_id=Hat">Hat</a>
  			</div>
  			<div class="camenu">
  				<a class="link_white" href="${approot}store/productcategory.jsp?ca_id=Season">Season</a>
  			</div>
  			<div class="camenu">
  				<a class="link_white" href="${approot}store/productcategory.jsp?ca_id=Beanie">Beanie</a>
  			</div>
		</div>
		</c:if>
		
	</div>
</div>



