<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
boolean isLogin = false;
if (loginInfo != null) { 
	isLogin = true; 
}
if (loginInfo != null && loginInfo.getMi_status().equals("b") && !request.getRequestURI().equals("/cworldSite/member/member_dormancy.jsp")){ 
	response.sendRedirect("/cworldSite/member/member_dormancy.jsp");
}
String url = request.getParameter("url");
if (url == null) url= "index.jsp";
%>
<%@ include file="../_inc/inc_sidebar2.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cworld에 오신것을 환영합니다.</title>
<link type="text/css" rel="stylesheet" href="/cworldSite/css/reset.css"/>	
<!--html의 기본적인 꾸밈기능을 제거하는 역할-->
<link type="text/css" rel="stylesheet" href="/cworldSite/css/base.css"/>
<!--기본적으로 들어갈 꾸밈기능을 넣어놓는 역할-->
<link type="text/css" rel="stylesheet" href="/cworldSite/css/layout.css"/>	
<!--위치 잡아주는 역할-->
<link type="text/css" rel="stylesheet" href="/cworldSite/css/main.css"/>
<!--첫화면에 대한 꾸밈역할-->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<!-- 달력에 대한 꾸밈-->
<script src="/cworldSite/js/jquery-3.6.1.js"></script>
<script>
$(document).ready(function(){
	$(".secM, #topMenu2Set").mouseenter(function(){
		$("#topMenu2Set").animate({width:"show"});
	});
	$(".secM, #topMenu2Set").mouseleave(function(){
		$("#topMenu2Set").animate({width:"hide"});
	});
});
function makeHeaderSch(){
	var frm = document.frmTop;
	var sch = "";
	var name = frm.pi_name.value;
	if(name != ""){	sch = "n" + name; }
	document.frmTop.sch.value = sch;
	document.frmTop.submit();
}
</script>
</head>
<body>
<div id="header">
	<div id="memberMenu" align="right">
		<% if (isLogin){ %>
		<a href="/cworldSite/logout.jsp">로그아웃</a>&nbsp;&nbsp;|&nbsp;
		<a href="/cworldSite/member/info_form.jsp">회원정보</a>&nbsp;&nbsp;|&nbsp;
		<a href="/cworldSite/cart_view">장바구니</a>&nbsp;&nbsp;|&nbsp;
		<a href="/cworldSite/member_page">마이페이지</a>
		<% } else { %>
		<a href="/cworldSite/login_form.jsp">로그인</a>&nbsp;&nbsp;|&nbsp;
		<a href="/cworldSite/member/join_contract.jsp">회원가입</a>&nbsp;&nbsp;|&nbsp;
		<a href="/cworldSite/login_form.jsp?url=cart_view">장바구니</a> &nbsp;&nbsp;|&nbsp;
		<a href="/cworldSite/login_form.jsp?url=member_page">마이페이지</a>
		
		<% } %>
	</div>
	<a href="/cworldSite/index.jsp"><img src="/cworldSite/img/cworld_logo.jpg" width="150" id="mainLogo"/></a>
	<div id="topsearch">
		<form name="frmTop" method="get" action="product_list">
		<input type="hidden" name="sch" value=""/>
		<input type="text" name="pi_name" style="width:150px; height:30px; border:0px" />
		<input type="submit" value="검색" onclick="makeHeaderSch();" style="width:50px; height:30px; background:pink; border:0px; padding-bottom:2px;"/>
		</form>
	</div>
	
	<a href="/cworldSite/product_list?pcb=P&pcs=P00"><div class="topMenu" id="menu1">
	풀세트패키지 대여</div></a>
	<a href="/cworldSite/product_list?pcb=R"><div class="topMenu secM" id="menu2">
	캠핑용품 대여</div></a>
	<a href="/cworldSite/product_list?pcb=S"><div class="topMenu secM" id="menu3">
	캠핑용품 구매</div></a>
	<a href="/cworldSite/g_qna_list"><div class="topMenu" id="menu4">
	단체행사 문의</div></a>
	<a href="/cworldSite/review_list"><div class="topMenu" id="menu5">
	이용 후기</div></a>
	<a href="/cworldSite/notice_list"><div class="topMenu" id="menu6">
	공지사항</div></a>
	<div id="topMenu2Set">
	<a href="/cworldSite/product_list?pcb=R&pcs=R01">
	<div class="smallMenuR" id="smallMenuR1"><span class="topMenu2">텐 트</span></div></a>
	<a href="/cworldSite/product_list?pcb=R&pcs=R02">
	<div class="smallMenuR" id="smallMenuR2"><span class="topMenu2">타 프 / 쉘 터</span></div></a>
	<a href="/cworldSite/product_list?pcb=R&pcs=R03">
	<div class="smallMenuR" id="smallMenuR3"><span class="topMenu2">침 구</span></div></a>
	<a href="/cworldSite/product_list?pcb=R&pcs=R04">
	<div class="smallMenuR" id="smallMenuR4"><span class="topMenu2">의 자 / 테 이 블</span></div></a>
	<a href="/cworldSite/product_list?pcb=R&pcs=R05">
	<div class="smallMenuR" id="smallMenuR5"><span class="topMenu2">화 기 용 품</span></div></a>
	<a href="/cworldSite/product_list?pcb=R&pcs=R06">
	<div class="smallMenuR" id="smallMenuR6"><span class="topMenu2">식 기 용 품</span></div></a>
	
	<a href="/cworldSite/product_list?pcb=S&pcs=S01">
	<div class="smallMenuS" id="smallMenuS1"><span class="topMenu2">텐 트</span></div></a>
	<a href="/cworldSite/product_list?pcb=S&pcs=S02">
	<div class="smallMenuS" id="smallMenuS2"><span class="topMenu2">타 프 / 쉘 터</span></div></a>
	<a href="/cworldSite/product_list?pcb=S&pcs=S03">
	<div class="smallMenuS" id="smallMenuS3"><span class="topMenu2">침 구</span></div></a>
	<a href="/cworldSite/product_list?pcb=S&pcs=S04">
	<div class="smallMenuS" id="smallMenuS4"><span class="topMenu2">의 자 / 테 이 블</span></div></a>
	<a href="/cworldSite/product_list?pcb=S&pcs=S05">
	<div class="smallMenuS" id="smallMenuS5"><span class="topMenu2">화 기 용 품</span></div></a>
	<a href="/cworldSite/product_list?pcb=S&pcs=S06">
	<div class="smallMenuS" id="smallMenuS6"><span class="topMenu2">식 기 용 품</span></div></a>
	</div>
</div>