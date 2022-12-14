<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
request.setCharacterEncoding("utf-8");
if (!isLogin){
	out.println("<script>");
	out.println("alert('잘못된 경로입니다.');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}
ArrayList<MypageOrderInfo> ol = (ArrayList<MypageOrderInfo>)request.getAttribute("ol");

PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");

int cpage = pageInfo.getCpage(), psize = pageInfo.getPsize(), bsize = pageInfo.getBsize();
int rcnt = pageInfo.getRcnt(), pcnt = pageInfo.getPcnt(), spage = pageInfo.getSpage();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#orderListBox { width:800px; }
#orderListBox th, #orderListBox td { border-bottom:1px black solid; border-collapse:collapse; }
#orderListBox th { text-align:center;}
strong { font-weight:bold; }
</style>
</head>
<body>
<div class="content" align="center">
<p style="width:800px; text-align:left;">
<img src="/cworldSite/img/order_list.png" width="100" height="40"/>
</p>
<br />
<table width="800" align="center" id="orderListBox" cellpadding="0" cellspacing="0">
<tr height="45">
<th width="5%">번호</th>
<th width="10%">주문번호</th>
<th width="15%">상품이미지</th>
<th width="*">상품명 & 옵션</th>
<th width="5%">개수</th>
<th width="10%">가격</th>
<th width="10%">주문일</th>
<th width="10%">리뷰작성</th>
</tr>
<% 

if (ol.size() > 0) { 
	int num = (rcnt - (psize * (cpage - 1)));
	for (int i = 0; i < ol.size(); i++) {
		MypageOrderInfo moi = ol.get(i);
		String img = moi.getVimg();
		
		String img2 = img.substring(0, 6) + 2 + img.substring(7);
		String img3 = img.substring(0, 6) + 3 + img.substring(7);
%>
<tr align="center" height="45" onmouseover="this.bgColor='#cfcfcf';" onmouseout="this.bgColor='';">
<td><%=num %></td>
<td><%=moi.getOi_id() %></td>
<td>
<% if (moi.getPs_opt().equals("r")) { %>
<img src="/cworld_admin/pdt_img/<%=moi.getVimg() %>" width="90" height="90"/>
<% } else if (moi.getPs_opt().equals("a")) { %>
<img src="/cworld_admin/pdt_img/<%=moi.getVimg() %>" width="90" height="90"/>
<% } else if (moi.getPs_opt().equals("b")) { %>
<img src="/cworld_admin/pdt_img/<%=img2 %>" width="90" height="90"/>
<% } else if (moi.getPs_opt().equals("c")) { %>
<img src="/cworld_admin/pdt_img/<%=img3 %>" width="90" height="90"/>
<% } else if (moi.getPs_opt().equals("d")) { %>
<img src="/cworld_admin/pdt_img/<%=moi.getVimg() %>" width="90" height="90"/>
<% } %>
</td>
<td align="left"><%=moi.getVname() %> - 
<% if (moi.getPs_opt().equals("r")) { %>
대여
<% } else if (moi.getPs_opt().equals("a")) { %>
빨강
<% } else if (moi.getPs_opt().equals("b")) { %>
파랑
<% } else if (moi.getPs_opt().equals("c")) { %>
검정
<% } else if (moi.getPs_opt().equals("d")) { %>
단일 옵션
<% } %>

</td>
<td><%=moi.getVcnt() %></td>
<td><%=moi.getVprice() %></td>
<td><%=moi.getOi_date() %></td>
<td>
<% if (moi.getIsReview() >= 0) { %>
작성완료
<% } else { %>
<form name="reviewFrm<%=i %>" method="post" action="review_form_in">
<input type="hidden" name="oi_id" value="<%=moi.getOi_id() %>" />
<input type="hidden" name="mi_id" value="<%=moi.getMi_id() %>" />
<input type="hidden" name="pi_id" value="<%=moi.getPi_id() %>" />
<input type="hidden" name="ps_idx" value="<%=moi.getPs_idx() %>" />
<input type="hidden" name="ps_opt" value="<%=moi.getPs_opt() %>" />
<input type="hidden" name="pi_name" value="<%=moi.getVname() %>" />
<input type="submit" name="reviewInsert" value="리뷰작성"/>
</form>
<% } %>
</td>
</tr>
<%
num--;
	}
%>
<% } else { %>
<tr><td align="center" height="50" colspan="8">구매 내역이 없습니다.</td></tr>
<% } %>
</table>
<br />
<p style="width:800px; text-align:center;">
<%
pcnt = rcnt / psize;
if (rcnt % psize > 0) {
	pcnt++;
}
if (rcnt > 0) { 	// 게시글이 있으면 - 페이징 영역을 보여줌
	if (cpage == 1) {
		out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
	} else {
		out.println("<a href='mypage_order_list?cpage=1'>[처음]</a>&nbsp;&nbsp;&nbsp;<a href='mypage_order_list?cpage=" + (cpage - 1) + "'>[이전]</a>&nbsp;&nbsp;");
	}
	spage = (cpage - 1) / bsize * bsize + 1; 		// 현재 블록에서의 시작 페이지 번호
	for (int i = 1, j = spage; i <= bsize && j <= pcnt; i++, j++) {
		// i : 블록에서 보여줄 페이지의 개수만큼 루프를 돌릴 조건으로 사용되는 변수
		// j : 실제 출력한 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 사용해야 함
		if (cpage == j) {
			out.println("&nbsp;<strong>" + j + "</strong>");
		} else {
			out.println("&nbsp;<a href='mypage_order_list?cpage=" + j + "'>" + j + "</a>");
		}	
	}
	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
	} else {
		out.println("<a href='mypage_order_list?cpage=" + (cpage + 1) + "'>&nbsp;&nbsp;[다음]</a><a href='mypage_order_list?cpage=" + pcnt + "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
	}
}
%>
</p>
<br />
<p style="width:800px; text-align:right;">
<input type="button" value="마이페이지" class="mpBtn" onclick="location.href='member_page'" />&nbsp;&nbsp;
</p>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>