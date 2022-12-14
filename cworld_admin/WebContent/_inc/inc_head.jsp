<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
AdminInfo loginInfo = (AdminInfo)session.getAttribute("loginInfo");
if (loginInfo == null) {
	out.println("<script> alert('잘못된 경로로 들어왔습니다.'); location.replace('admin_login.jsp'); </script>");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cworld_admin</title>
<link rel="shortcut icon" href="/cworldSite/img/favicon.ico" type="image/x-icon" />
<link rel="icon" href="/cworldSite/img/favicon.ico" type="image/x-icon" />

<script type="text/javascript" src="/cworld_admin/js/jquery-3.6.1.js"></script>
<script>
function onlyNum(obj) {
	if (isNaN(obj.value)) {
		obj.value = "";
	}
}
</script>
<script type="text/javascript">
function startTimer(duration, display) {
  var timer = duration, minutes, seconds;
  var interval = setInterval(function () {
    minutes = parseInt(timer / 60, 10)
    seconds = parseInt(timer % 60, 10);

    minutes = minutes < 10 ? "0" + minutes : minutes;
    seconds = seconds < 10 ? "0" + seconds : seconds;

    display.textContent = minutes + ":" + seconds;

    if (--timer < 0) {
      timer = duration;
    }
    if(timer === 0) {
      clearInterval(interval);
      display.textContent = "세션 만료!";
    }
  }, 1000);
}

window.onload = function () {
  /* 기본값 10(분)입니다. */
  var minutes = 10;

  var fiveMinutes = (60 * minutes) - 1,
    display = document.querySelector('#MyTimer');
  startTimer(fiveMinutes, display);
};

</script>


<style type="text/css">
	.contentDiv { width:80%; float:right; }
	body, th, td, div, p { font-size:1em; }
	body { 
		background:#fff;
	}
	li, ul, ol { list-style-type:none; }
	#sideMenu a:link { text-decoration:none; color:#fff; }
	#sideMenu a:visited { text-decoration:none; color:#fff; }
	#sideMenu a:hover { text-decoration:underline; color:#fff; }
	#sideMenu a:active { text-decoration:none; color:#fff; }	
	.hand { cursor:pointer; }
	.bold { font-weight:bold; }
	#bigMenu1 { position:relative; top:20px; left:25px; display:block; }
	#bigMenu2 { position:relative; top:20px; left:25px; display:block; }
	#bigMenu3 { position:relative; top:20px; left:25px; display:block; }
	#bigMenu4 { position:relative; top:20px; left:25px; display:block; }
	
	#sideMenu { 
		width:200px; height:100%; position:fixed; top:0; left:0px;
		background:rgba(100, 100, 100, 0.8); 
	}
	#subnavi01 { width:200px; position:relative; top:20px; left:0px; display:none; text-align:center; }
	#subnavi02 { width:200px; position:relative; top:20px; left:0px; display:none; text-align:center; }
	#subnavi03 { width:200px; position:relative; top:20px; left:0px; display:none; text-align:center; }
	#subnavi04 { width:200px; position:relative; top:20px; left:0px; display:none; text-align:center; }
	#menus { width:200px; height:100%; }
	#loginInfo { position:absolute; margin:5px; top:10px; right:10px; text-align:right; }
	#logoutBtn { width:70px; margin-top:3px; }
.title { text-align:left; }
canvas {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}
.hand { cursor:pointer; }
.resetSch { background-color:pink; border:pink; }
#footerBlank { position:absolute; top:150%; width:100px;  }
</style>
<script src="/cworld_admin/js/jquery-3.6.1.js"></script>
<script>
$(document).ready(function() {
	$("#bigMenu1").click(function() {
		$("#subnavi01").slideToggle();
	});
	$("#bigMenu2").click(function() {
		$("#subnavi02").slideToggle();
	});
	$("#bigMenu3").click(function() {
		$("#subnavi03").slideToggle();
	});
	$("#bigMenu4").click(function() {
		$("#subnavi04").slideToggle();
	});
});
function logout() {
	if (confirm("로그아웃 하시겠습니까?")) {
		location.href = "/cworld_admin/logout.jsp";
	}
}
</script>
<script src="/cworld_admin/js/Chart.min.js"></script>
<script src="/cworld_admin/js/utils.js"></script>


</head>
<body>
<div id="loginInfo">
<b><%=loginInfo.getAi_name() %></b> 님 환영합니다.<br />
<span id="MyTimer">10:00</span>&nbsp;&nbsp;<input type="button" value="로그아웃" name="logout" id="logoutBtn" onclick="logout()" />
</div>
<br /><br /><br />
<hr />
<div id="sideMenu">
<a href="/cworld_admin/index.jsp"><img src="/cworld_admin/img/cworld_logo.jpg" width="200" height="200" /></a>
	<div id="menus">
		<img src="/cworld_admin/img/ico_menu01.png" width="150" height="43" id="bigMenu1" />
		<div id="subnavi01">
			<a href="/cworld_admin/product_in">상품 등록</a><br />
			<a href="/cworld_admin/product_list">상품 목록</a><br />
			<a href="/cworld_admin/product_list_stock">재고 관리</a><br />
			<a href="/cworld_admin/rent_list">대여 물품 관리</a>
		</div>
		<img src="/cworld_admin/img/ico_menu02.png" width="150" height="43" id="bigMenu2" />
		<div id="subnavi02">
				<a href="/cworld_admin/member_list">회원 목록</a><br />
				<a href="/cworld_admin/member_last">장기 미접속 회원</a><br />
				<a href="/cworld_admin/member_exit">탈퇴 회원관리</a><br />
				<a href="/cworld_admin/member_order_list">결제 내역 관리</a>
		</div>
		<img src="/cworld_admin/img/ico_menu03.png" width="150" height="43" id="bigMenu3" />
		<div id="subnavi03">
				<a href="/cworld_admin/notice_list">공지 사항</a><br />
				<a href="/cworld_admin/qna_list">1:1 문의</a><br />
				<a href="/cworld_admin/review_list">리뷰</a><br />
				<a href="/cworld_admin/g_qna_list">단체 문의</a><br />
				<a href="/cworld_admin/g_review_list">단체 후기</a>
		</div>
		<img src="/cworld_admin/img/ico_menu04.png" width="150" height="43" id="bigMenu4" />
		<div id="subnavi04">
				<a href="/cworld_admin/sta_home">통계 홈</a><br />
				<a href="/cworld_admin/sta_month_sale">연간 월별 판매량</a><br />
				<a href="/cworld_admin/sta_day_of_week">요일별 판매량</a><br />
				<a href="/cworld_admin/sta_review">판매량 대비 리뷰 개수</a><br />
				<a href="/cworld_admin/sta_amount">분류별 판매량</a>
		</div>
	</div>
</div>

<div id="footerBlank">
<br/><br/><br/>
</div>

