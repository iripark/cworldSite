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
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int cpage = pageInfo.getCpage(), psize = pageInfo.getPsize(), bsize = pageInfo.getBsize();
int rcnt = pageInfo.getRcnt(), pcnt = pageInfo.getPcnt(), spage = pageInfo.getSpage();
ArrayList<MemberPoint> pl = (ArrayList<MemberPoint>)request.getAttribute("pointList");
int totalPoint = (int)request.getAttribute("totalPoint");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#pointBox { width:800px; }
#pointBox th, #pointBox td { border-bottom:1px black solid; border-collapse:collapse; }
#pointBox th { text-align:center;}
strong { font-weight:bold; }
</style>
</head>
<body>
<div class="content" align="center">
<p style="width:800px; text-align:left;"><img src="/cworldSite/img/mp_point.png" width="100" height="40"/></p>
<br />
<table width="800" align="center" id="pointBox" cellpadding="0" cellspacing="0">
<tr height="40">
<th width="5%">번호</th>
<th width="15%">분류</th>
<th width="30%">내용</th>
<th width="20%">사용/적립 포인트</th>
<th width="*">사용/적립일</th>
</tr>
<% 
if (pl.size() > 0) {
	int num = (rcnt - (psize * (cpage - 1)));
	for (int i = 0; i < pl.size(); i++) {
		MemberPoint mp = pl.get(i);
%>
<tr height="40" align="center">
<td><%=num %></td>
<td>
<% if (mp.getMp_issu().equals("s")) { %>
적립
<% } else if (mp.getMp_issu().equals("u")) { %>
사용
<% } %>
</td>
<td align="left">&nbsp;&nbsp;<%=mp.getMp_desc() %></td>
<td><%=mp.getMp_point() %></td>
<td><%=mp.getMp_date().substring(0, 10) %></td>
</tr>
<%
		num--;
	}
} else {
	out.println("<tr align='center'><td colspan='5'>포인트 사용내역이 없습니다.</td></tr>");
}
%>
</table>
<br />
<p style="width:800px; text-align:right;">
총 포인트 : <span style="font-size:1.2em; font-seight:600;"><%=totalPoint %></span> point
</p>
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
		out.println("<a href='member_point?cpage=1'>[처음]</a>&nbsp;&nbsp;&nbsp;<a href='member_point?cpage=" + (cpage - 1) + "'>[이전]</a>&nbsp;&nbsp;");
	}
	spage = (cpage - 1) / bsize * bsize + 1; 		// 현재 블록에서의 시작 페이지 번호
	for (int i = 1, j = spage; i <= bsize && j <= pcnt; i++, j++) {
		// i : 블록에서 보여줄 페이지의 개수만큼 루프를 돌릴 조건으로 사용되는 변수
		// j : 실제 출력한 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 사용해야 함
		if (cpage == j) {
			out.println("&nbsp;<strong>" + j + "</strong>");
		} else {
			out.println("&nbsp;<a href='member_point?cpage=" + j + "'>" + j + "</a>");
		}	
	}
	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
	} else {
		out.println("<a href='member_point?cpage=" + (cpage + 1) + "'>&nbsp;&nbsp;[다음]</a><a href='member_point?cpage=" + pcnt + "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
	}
}
%>
</p>
<br />
<p style="width:800px; text-align:right;">
<input type="button" value="마이페이지" class="mpBtn" onclick="history.back();" />&nbsp;&nbsp;
</p>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>