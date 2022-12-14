<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%@ page import="java.text.*" %>
<%
request.setCharacterEncoding("utf-8");
String mem = (String)request.getAttribute("memCnt");	
String qna = (String)request.getAttribute("qnaCnt");			
String gQna = (String)request.getAttribute("gQnaCnt");	
String stock = (String)request.getAttribute("stockCnt");	
String rent = (String)request.getAttribute("rentCnt");	
String ctgrSale = (String)request.getAttribute("ctgrSaleSum");
String[] memCnt = mem.split(",");
String[] qnaCnt = qna.split(",");
String[] gQnaCnt = gQna.split(",");
String[] stockCnt = stock.split(",");
String[] rentCnt = rent.split(",");
String[] ctgrSaleSum = ctgrSale.split(",");

DecimalFormat df = new DecimalFormat("###,###");
String pMoney = df.format(Integer.parseInt(ctgrSaleSum[0]));
String rMoney = df.format(Integer.parseInt(ctgrSaleSum[1]));
String sMoney = df.format(Integer.parseInt(ctgrSaleSum[2]));
String total = df.format(Integer.parseInt(ctgrSaleSum[0]) + Integer.parseInt(ctgrSaleSum[1]) + Integer.parseInt(ctgrSaleSum[2]));
String sSum = "";

%>
<!doctype html>
<html>
<head>
<title>d</title>
<style>
#subnavi04 { display:block; }
.staBoxs th, .staBoxs td { border-bottom:1px black solid; border-collapse:collapse; }
.staBoxs caption { font-size:1.4em; font-weight:bold; }
a:link { text-decoration:none; color:#6a3; }
a:visited { text-decoration:none; color:#6a3; }
a:hover { text-decoration:underline; color:#6a3; }
a:active { text-decoration:none; color:#6a3; }	
.divBoxs { margin-bottom:25px; }
</style>
</head>
<body>
<div style="width:60%; margin:0 auto;">
<h2>통계 홈</h2>
<div style="width:49%; float:left;" class="divBoxs">
<table width="70%" cellspacing="0" cellpadding="0" align="center" class="staBoxs" >
<caption><a href="/cworld_admin/sta_month_sale"> 매출 통계 </a></caption>
<tr height="45"><th width="40%">패 키 지</th><td align="right" width="*"><%=pMoney %> 원</td></tr>
<tr height="45"><th>대 여</th><td align="right"><%=rMoney %> 원</td></tr>
<tr height="45"><th>판 매</th><td align="right"><%=sMoney %> 원</td></tr>
<tr height="45"><th>총 매출</th><td align="right"><%=total %> 원</td></tr>
</table>
</div>
<div style="width:49%; float:left;" class="divBoxs">
<table width="70%" cellspacing="0" cellpadding="0" align="center" class="staBoxs">
<caption>회원 수</caption>
<tr height="45"><th width="60%">전 체</th><td width="*" align="center"><a href="/cworld_admin/member_list"><%=memCnt[0] %></a> 명</td></tr>
<tr height="45"><th>정 상 회 원</th><td align="center"><a href="/cworld_admin/member_list?sch=sa"><%=memCnt[1] %></a> 명</td></tr>
<tr height="45"><th>휴 면 회 원</th><td align="center"><a href="/cworld_admin/member_list?sch=sb"><%=memCnt[2] %></a> 명</td></tr>
<tr height="45"><th>탈 퇴 회 원</th><td align="center"><a href="/cworld_admin/member_exit"><%=memCnt[3] %></a> 명</td></tr>
</table>
</div>
<div style="width:49%; float:left;" class="divBoxs">
<table width="70%" cellspacing="0" cellpadding="0" align="center" class="staBoxs">
<caption>문의 글 내역</caption>
<tr height="45"><th width="60%">전체 - 1:1 문의</th><td align="center" width="*"><a href="/cworld_admin/qna_list"><%=qnaCnt[0] %></a> 개</td></tr>
<tr height="45"><th>답변완료 - 1:1 문의</th><td align="center"><a href="/cworld_admin/qna_list?sch=ay"><%=qnaCnt[1] %></a> 개</td></tr>
<tr height="45"><th>답변필요 - 1:1 문의</th><td align="center"><a href="/cworld_admin/qna_list?sch=an"><%=qnaCnt[2] %></a> 개</td></tr>
</table>
<br /><br /><br />
<table width="70%" cellspacing="0" cellpadding="0" align="center" class="staBoxs">
<caption>문의 글 내역</caption>
<tr height="45"><th width="60%">전체 - 단체 문의</th><td align="center" width="*"><a href="/cworld_admin/g_qna_list"><%=gQnaCnt[0] %></a> 개</td></tr>
<tr height="45"><th>답변완료 - 단체 문의</th><td align="center"><a href="/cworld_admin/g_qna_list?sch=ay"><%=gQnaCnt[1] %></a> 개</td></tr>
<tr height="45"><th>답변필요 - 단체 문의</th><td align="center"><a href="/cworld_admin/g_qna_list?sch=an"><%=gQnaCnt[2] %></a> 개</td></tr>
</table>
</div>
<div style="width:49%; float:left;" class="divBoxs">
<table width="70%" cellspacing="0" cellpadding="0" align="center" class="staBoxs">
<caption>재고 상태</caption>
<tr height="45"><th width="60%">여유</th><td align="center" width="*"><a href="/cworld_admin/product_list_stock?sch=sd"><%=stockCnt[0] %></a> 개</td></tr>
<tr height="45"><th>부족</th><td align="center"><a href="/cworld_admin/product_list_stock?sch=sc"><%=stockCnt[1] %></a> 개</td></tr>
<tr height="45"><th>품절</th><td align="center"><a href="/cworld_admin/product_list_stock?sch=sb"><%=stockCnt[2] %></a> 개</td></tr>
</table>
</div>

<div style="width:49%; float:left;" class="divBoxs">
<table width="70%" cellspacing="0" cellpadding="0" align="center" class="staBoxs">
<caption>대여 내역</caption>
<tr height="45"><th> </th><th>패키지</th><th>대여</th></tr>
<tr height="45"><th>대 여 예 정</th><td align="center"><a href="/cworld_admin/rent_list?sch=bP,sP00,ta"><%=rentCnt[0] %></a> 개</td><td align="center"><a href="/cworld_admin/rent_list?sch=bR,ta"><%=rentCnt[3] %></a> 개</td></tr>
<tr height="45"><th>대 여 중</th><td align="center"><a href="/cworld_admin/rent_list?sch=bP,sP00,tb"><%=rentCnt[1] %></a> 개</td><td align="center"><a href="/cworld_admin/rent_list?sch=bR,tb"><%=rentCnt[4] %></a> 개</td></tr>
<tr height="45"><th>미 반 납</th><td align="center"><a href="/cworld_admin/rent_list?sch=bP,sP00,td"><%=rentCnt[2] %></a> 개</td><td align="center"><a href="/cworld_admin/rent_list?sch=bR,td"><%=rentCnt[5] %></a> 개</td></tr>
</table>
</div>
</div>
</body>
</html>