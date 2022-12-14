<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
ArrayList<MemberInfo> exitList = (ArrayList<MemberInfo>)request.getAttribute("exitList");
MemberInfo mi = null;

int cpage = pageInfo.getCpage(), psize = pageInfo.getPsize(), bsize = pageInfo.getBsize();
int rcnt = pageInfo.getRcnt(), pcnt = pageInfo.getPcnt(), spage = pageInfo.getSpage();
out.println(rcnt);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#subnavi02 { display:block; }
#schFrm { text-align:center; }
.title { text-align:left; }
.memInfo { 
	width:800px; height:700px; position:absolute; text-align:center; margin:-400px 0 0 -350px;
	background:white; color:black; display:none; border:1px black solid;
	top:50%; left:50%;
}
a { text-decoration:none; color:black; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:none; color:black; }
.icoX { position:absolute; top:15px; right:15px; }
#exitBox th, #exitBox td { border-bottom:1px black solid; border-collapse:collapse; }
</style>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script> 
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> 

</head>
<body>
<table width="1000" align="center" cellpadding="0" cellspacing="0" id="exitBox">
<caption style="text-align:left; font-size:25px; font-weight:bold;">탈 퇴 회 원 목 록</caption>
<tr height="45">
<th height="35" width="10%">아이디</th><th width="10%">이름</th><th width="10%">생년월일</th><th width="23%">메일주소</th>
<th width="23%">가입일</th><th width="*">최종로그인</th>
</tr>
<%
if (exitList.size() > 0) {
	for(int i = 0; i < exitList.size(); i++) {
		mi = exitList.get(i);
%>
<tr height="35" onmouseover="this.bgColor='#cfcfcf';" onmouseout="this.bgColor='';" height="45">
<td><%=mi.getMi_id() %></td>
<td><%=mi.getMi_name() %></td>
<td align="center"><%=mi.getMi_birth() %></td>
<td align="center"><%=mi.getMi_mail() %></td>
<td align="center"><%=mi.getMi_join() %></td>
<td align="center"><%=mi.getMi_last() %></td>
</tr>
<%	
	}
%>
</table>
<p align="center" style="width:1000px; margin:0 auto;">
<%
	if (rcnt > 0) { 	// 게시글이 있으면 - 페이징 영역을 보여줌
		if (cpage == 1) {
			out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
		} else {
			out.println("<a href='member_exit?cpage=1'>[처음]</a>&nbsp;&nbsp;&nbsp;<a href='member_exit?cpage=" + (cpage - 1) + "'>[이전]</a>&nbsp;&nbsp;");
		}
		spage = (cpage - 1) / bsize * bsize + 1; 		// 현재 블록에서의 시작 페이지 번호
		for (int i = 1, j = spage; i <= bsize && j <= pcnt; i++, j++) {
			if (cpage == j) {
				out.println("&nbsp;<strong>" + j + "</strong>");
			} else {
				out.println("&nbsp;<a href='member_exit?cpage=" + j + "'>" + j + "</a>");
			}	
		}
		if (cpage == pcnt) {
			out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
		} else {
			out.println("<a href='member_exit?cpage=" + (cpage + 1) + "'>&nbsp;&nbsp;[다음]</a><a href='member_exit?cpage=" + pcnt + "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
		}
	}
%>
</p>
<%
} else {
	out.println("<tr height='45'><td align='center' colspan='6'>탈퇴 회원이 없습니다.</td></tr></table>");
}
%>

</body>
</html>