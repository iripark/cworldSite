<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#indexMenu th { border-bottom:1px solid black; }
#indexMenu a { text-decoration:none; color:black; }
#indexMenu a:link { text-decoration:none; color:black; }
#indexMenu a:visited { text-decoration:none; color:black; }
#indexMenu a:hover { text-decoration:underline; color:black; }
</style>
</head>
<body>
<table width="800" height="300" align="center" id="indexMenu" cellpadding="0" cellspacing="0">
<caption style="text-align:left; font-size:25px; font-weight:bold;">메 뉴</caption>
<tr><th width="25%">상품관리</th><th width="25%">회원관리</th><th width="25%">게시판관리</th><th width="25%">통계관리</th></tr>
<tr align="center">
<td>
<a href="product_in">상품 등록</a><br /><br />
<a href="product_list">상품 목록</a><br /><br />
<a href="product_list_stock">재고 관리</a><br /><br />
<a href="rent_list">대 여 물 품 관 리</a>
</td>
<td>
<a href="member_list">회원 목록</a><br /><br />
<a href="member_last">장기 미접속 회원</a><br /><br />
<a href="member_exit">탈퇴 회원관리</a><br /><br />
<a href="member_order_list">결제 내역 관리</a>
</td>
<td>
<a href="notice_list">공지 사항</a><br /><br />
<a href="qna_list">1:1 문의</a><br /><br />
<a href="review_list">리뷰</a><br /><br />
<a href="g_qna_list">단체 문의</a><br /><br />
<a href="g_review_list">단체 후기</a>
</td>
<td>
<a href="/cworld_admin/sta_home">통계 홈</a><br /><br />
<a href="/cworld_admin/sta_month_sale">연간 월별 판매량</a><br /><br />
<a href="/cworld_admin/sta_day_of_week">요일별 판매량</a><br /><br />
<a href="/cworld_admin/sta_review">판매량 대비 리뷰 개수</a><br /><br />
<a href="/cworld_admin/sta_amount">분류별 판매량</a>
</td>
</tr>
</table>
</body>
</html>