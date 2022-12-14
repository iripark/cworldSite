<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
ArrayList<GReviewInfo> greviewList = (ArrayList<GReviewInfo>)request.getAttribute("gReviewList");

int cpage = pageInfo.getCpage(), psize = pageInfo.getPsize(), bsize = pageInfo.getBsize();
int rcnt = pageInfo.getRcnt(), pcnt = pageInfo.getPcnt(), spage = pageInfo.getSpage();


String schtype = pageInfo.getSchtype(), keyword = pageInfo.getKeyword(); 
String schargs = "", args = "";
if (schtype != null && keyword != null && !schtype.equals("") && !keyword.equals("")) {
	// 검색조건(schtype)과 검색어(keyword)가 null도 아니고 빈 문자열이 아니면 
	schargs = "&schtype=" + schtype + "&keyword=" + keyword;
	// 검색조건과 검색어가 있으면 검색관련 데이터들을 쿼리스트링으로 지정
}

args = "&cpage=" + cpage + schargs;
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
a { text-decoration:none; color:black; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:none; color:black; }
#gReviewBox th, #gReviewBox td { border-bottom:1px black solid; border-collapse:collapse; }
#gReviewBox th { text-align:center; }
strong { font-weight:bold; }
</style>
</head>
<body>
<div class="content" align="center">
<p align="center" style="width:800px; text-align:left; ">
<a href="/cworldSite/notice_list"><img src="/cworldSite/img/ico_notice.png" width="80" height="45"/></a>&nbsp;&nbsp;
<a href="/cworldSite/review_list"><img src="/cworldSite/img/ico_review.png" width="80" height="45"/></a>&nbsp;&nbsp;
<a href="/cworldSite/g_qna_list"><img src="/cworldSite/img/ico_gqna.png" width="80" height="45"/></a>&nbsp;&nbsp;
<a href="/cworldSite/g_review_list"><img src="/cworldSite/img/ico_greview_on.png" width="80" height="45"/></a>&nbsp;&nbsp;
</p>
<table width="800" align="center" cellpadding="0" cellspacing="0" id="gReviewBox">
<tr>
<th height="35" width="7%">글번호</th>
<th width="*">제목</th>
<th width="10%">작성자</th>
<th width="10%">단체명</th>
<th width="15%">작성일</th>
</tr>
<%
if (greviewList.size() > 0) {
	int num = rcnt - (psize * (cpage - 1));
	for (int i = 0; i < greviewList.size(); i++) {
		GReviewInfo gri = greviewList.get(i);
%>
<tr height="45" onmouseover="this.bgColor='#cfcfcf';" onmouseout="this.bgColor='';" align="center" >
<td><%=num %></td>

<td align="left">&nbsp;&nbsp;
<a href="g_review_view?cpage=<%=cpage %>&idx=<%=gri.getGr_idx() %>">
<%		if(gri.getGr_title().length() > 20) { 
			out.println(gri.getGr_title().substring(0, 15) + "...");  
		} else {
			out.println(gri.getGr_title());
		}
%>
</a>
</td>
<td><%=gri.getMi_id() %></td>
<td><%=gri.getGq_gname() %></td>
<td><%=gri.getGr_date() %></td>

<form name="frmIsview<%=i %>">

<input type="hidden" name="idx" value="<%=gri.getGq_idx() %>" />
</form>

</tr>
<%
		num--;
	}
} else {
	out.println("<tr height='45'><td colspan='5' align='center'>단체리뷰가 없습니다.</td></tr>");
}
%>
</table>
<table width="800" align="center">
<tr align="center" >
<td width="*" valign="middle"><br />
<%
if (rcnt > 0) { 	// 게시글이 있으면 - 페이징 영역을 보여줌
	if (cpage == 1) {
		out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
	} else {
		out.println("<a href='g_review_list?cpage=1" + "'>[처음]</a>&nbsp;&nbsp;&nbsp;<a href='g_review_list?cpage=" + (cpage - 1) + "'>[이전]</a>&nbsp;&nbsp;");
	}
	spage = (cpage - 1) / bsize * bsize + 1; 		// 현재 블록에서의 시작 페이지 번호
	for (int k = 1, j = spage; k <= bsize && j <= pcnt; k++, j++) {
		if (cpage == j) {
			out.println("&nbsp;<strong>" + j + "</strong>");
		} else {
			out.println("&nbsp;<a href='g_review_list?cpage=" + j + "'>" + j + "</a>");
		}	
	}
	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
	} else {
		out.println("<a href='g_review_list?cpage=" + (cpage + 1) + "'>&nbsp;&nbsp;[다음]</a><a href='g_review_list?cpage=" + pcnt + "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
	}
}
%>

</td>
</tr>
</table>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>