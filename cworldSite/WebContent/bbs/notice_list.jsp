<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
ArrayList<NoticeInfo> noticeList = (ArrayList<NoticeInfo>)request.getAttribute("noticeList");

int cpage = pageInfo.getCpage(), psize = pageInfo.getPsize(), bsize = pageInfo.getBsize();
int rcnt = pageInfo.getRcnt(), pcnt = pageInfo.getPcnt(), spage = pageInfo.getSpage();

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
#noticeListBox { width:800px; }
#noticeListBox th, #noticeListBox td { border-bottom:1px black solid; border-collapse:collapse; }
#noticeListBox th { text-align:center; }
strong { font-weight:bold; }
</style>
</head>
<body>
<div class="content" align="center" >
<p align="center" style="width:800px; text-align:left; ">
<a href="/cworldSite/notice_list"><img src="/cworldSite/img/ico_notice_on.png" width="80" height="45"/></a>&nbsp;&nbsp;
<a href="/cworldSite/review_list"><img src="/cworldSite/img/ico_review.png" width="80" height="45"/></a>&nbsp;&nbsp;
<a href="/cworldSite/g_qna_list"><img src="/cworldSite/img/ico_gqna.png" width="80" height="45"/></a>&nbsp;&nbsp;
<a href="/cworldSite/g_review_list"><img src="/cworldSite/img/ico_greview.png" width="80" height="45"/></a>&nbsp;&nbsp;
</p>
<table align="center" cellpadding="0" cellspacing="0" id="noticeListBox">
<tr align="center">
<th height="35" width="7%">글번호</th>
<th width="10%">분류</th>
<th width="*">제목</th>
<th width="7%">작성자</th>
<th width="10%">작성일</th>
<th width="10%">조회수</th>
</tr>
<%
if (noticeList.size() > 0) {
	int num =  (rcnt - (psize * (cpage - 1)));
	for (int i = 0; i < noticeList.size(); i++) {
		NoticeInfo ni = noticeList.get(i);
%>
<tr height="35" onmouseover="this.bgColor='#cfcfcf';" onmouseout="this.bgColor='';" align="center" >
<td><%=num %></td>
<td><% if (ni.getNl_ctgr().equals("a")) { %> 공지사항 <% } else { %> 이벤트 <% } %></td>
<td align="left">&nbsp;&nbsp;
<a href="notice_view?cpage=<%=cpage %>&idx=<%=ni.getNl_idx() %>">
<%		if(ni.getNl_title().length() > 20) { 
			out.println(ni.getNl_title().substring(0, 15) + "...");  
		} else {
			out.println(ni.getNl_title());
		}
%>
</a>
</td>
<td><%=ni.getAi_name() %></td>
<td><%=ni.getNl_date() %></td>
<td><%=ni.getNl_read() %></td>
<td>
<form name="frmIsview<%=i %>">

<input type="hidden" name="idx" value="<%=ni.getNl_idx() %>" />
</form>
</td>
</tr>
<%
		num--;
	}
} else {
	out.println("<tr align='center' height='45'><td colspan='6'>공지사항이 없습니다.</td></tr>");
}
%>
</table>
<table width="800" align="center" >
<tr align="center" >
<td width="*" valign="middle"><br />
<%
if (rcnt > 0) { 	// 게시글이 있으면 - 페이징 영역을 보여줌
	if (cpage == 1) {
		out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
	} else {
		out.println("<a href='notice_list?cpage=1" + "'>[처음]</a>&nbsp;&nbsp;&nbsp;<a href='notice_list?cpage=" + (cpage - 1) + "'>[이전]</a>&nbsp;&nbsp;");
	}
	spage = (cpage - 1) / bsize * bsize + 1; 		// 현재 블록에서의 시작 페이지 번호
	for (int k = 1, j = spage; k <= bsize && j <= pcnt; k++, j++) {
		if (cpage == j) {
			out.println("&nbsp;<strong>" + j + "</strong>");
		} else {
			out.println("&nbsp;<a href='notice_list?cpage=" + j + "'>" + j + "</a>");
		}	
	}
	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
	} else {
		out.println("<a href='notice_list?cpage=" + (cpage + 1) + "'>&nbsp;&nbsp;[다음]</a><a href='notice_list?cpage=" + pcnt + "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
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