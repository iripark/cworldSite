<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
ArrayList<GqnaInfo> gqnaList = (ArrayList<GqnaInfo>)request.getAttribute("gqnaList");

int cpage = pageInfo.getCpage(), psize = pageInfo.getPsize(), bsize = pageInfo.getBsize();
int rcnt = pageInfo.getRcnt(), pcnt = pageInfo.getPcnt(), spage = pageInfo.getSpage();


String schtype = pageInfo.getSchtype(), keyword = pageInfo.getKeyword(); 
String schargs = "", args = "";
if (schtype != null && keyword != null && !schtype.equals("") && !keyword.equals("")) {
	// 검색조건(schtype)과 검색어(keyword)가 null도 아니고 빈 문자열이 아니면 
	schargs = "&schtype=" + schtype + "&keyword=" + keyword;
	// 검색조건과 검색어가 있으면 검색관련 데이터들을 쿼리스트링으로 지정
}

	
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
#gqnaBox th, #gqnaBox td { border-bottom:1px black solid; border-collapse:collapse; }
#gqnaBox th { text-align:center; }
strong { font-weight:bold; }
</style>
</head>
<body>
<div class="content" align="center">
<p align="center" style="width:800px; text-align:left; ">
<a href="/cworldSite/notice_list"><img src="/cworldSite/img/ico_notice.png" width="80" height="45"/></a>&nbsp;&nbsp;
<a href="/cworldSite/review_list"><img src="/cworldSite/img/ico_review.png" width="80" height="45"/></a>&nbsp;&nbsp;
<a href="/cworldSite/g_qna_list"><img src="/cworldSite/img/ico_gqna_on.png" width="80" height="45"/></a>&nbsp;&nbsp;
<a href="/cworldSite/g_review_list"><img src="/cworldSite/img/ico_greview.png" width="80" height="45"/></a>&nbsp;&nbsp;
</p>
<% if (loginInfo != null) { %>
<p align="center" style="width:800px; text-align:right; ">
<input type="button" value="전체 글 보기" onclick="location.href='g_qna_list'"/>
</p>
<% } %>
<table width="800" align="center" cellpadding="0" cellspacing="0" id="gqnaBox">
<tr>
<th height="35" width="7%">글번호</th>
<th width="*">제목</th>
<th width="10%">단체명</th>
<th width="10%">작성자</th>
<th width="15%">작성일</th>
<th width="7%">답변여부</th>
</tr>
<%
if (gqnaList.size() > 0) {
	int num = rcnt - (psize * (cpage - 1));
	for (int i = 0; i < gqnaList.size(); i++) {
		GqnaInfo gqi = gqnaList.get(i);
%>
<tr height="35" onmouseover="this.bgColor='#cfcfcf';" onmouseout="this.bgColor='';" align="center" >
<td><%=num %></td>

<td align="left">&nbsp;&nbsp;
<a href="g_qna_view?cpage=<%=cpage %>&idx=<%=gqi.getGq_idx() %>">
<%		if(gqi.getGq_title().length() > 20) { 
			out.println(gqi.getGq_title().substring(0, 15) + "...");  
		} else {
			out.println(gqi.getGq_title());
		}
%>
</a>
</td>
<td><%=gqi.getGq_gname() %></td>
<td><%=gqi.getMi_id() %></td>
<td><%=gqi.getGq_date() %></td>
<td><% if (gqi.getGq_isreply().equals("y")) { %>
<img src="/cworldSite/img/ico_reply.png" width="30" height="30" alt="답변완료"/>
<% } else { %>
<img src="/cworldSite/img/ico_no_reply.png" width="30" height="30" alt="미답변"/>
<% } %>
</td>
</tr>
<%
		num--;
	}
} else {
	out.println("<tr height='45'><td colspan='6' align='center'>단체문의가 없습니다.</td></tr>");
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
		out.println("<a href='g_qna_list?cpage=1" + "'>[처음]</a>&nbsp;&nbsp;&nbsp;<a href='g_qna_list?cpage=" + (cpage - 1) + "'>[이전]</a>&nbsp;&nbsp;");
	}
	spage = (cpage - 1) / bsize * bsize + 1; 		// 현재 블록에서의 시작 페이지 번호
	for (int k = 1, j = spage; k <= bsize && j <= pcnt; k++, j++) {
		if (cpage == j) {
			out.println("&nbsp;<strong>" + j + "</strong>");
		} else {
			out.println("&nbsp;<a href='g_qna_list?cpage=" + j + "'>" + j + "</a>");
		}	
	}
	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
	} else {
		out.println("<a href='g_qna_list?cpage=" + (cpage + 1) + "'>&nbsp;&nbsp;[다음]</a><a href='g_qna_list?cpage=" + pcnt + "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
	}
}
%>

</td>

<td width="7%" align="right" valign="bottom">
<input type="submit" value="글 등록" onclick="location.href='g_qna_form_in';" id="inBtn"/>
</td>
</tr>
</table>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>