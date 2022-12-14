<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
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
#subnavi03 { display:block; }
a { text-decoration:none; color:black; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:none; color:black; }
#noticeBox th, #noticeBox td { border-bottom:1px black solid; border-collapse:collapse; }
</style>
<script>
function isviewUpdate(frm, is) {
	var isview = is.value;
	var idx = frm.idx.value;
	$.ajax({
		type : "POST",				
		url : "/cworld_admin/noticeUpdate",		
		data : {"isview" : isview, "idx" : idx},		
		success : function(chkRs) {	
			if (chkRs == 1) {		
				alert("게시여부가 변경되었습니다.");
			} else {				
				alert("게시여부 변경 실패");
			}
		}
	});
}
</script>
</head>
<body>
<table width="1000" align="center" cellpadding="0" cellspacing="0" id="noticeBox">
<caption style="text-align:left; font-size:25px; font-weight:bold;">공 지 사 항</caption>
<tr>
<th height="35" width="7%">글번호</th>
<th width="10%">분류</th>
<th width="46%">제목</th>
<th width="7%">작성자</th>
<th width="10%">작성일</th>
<th width="10%">조회수</th>
<th width="10%">게시여부</th>
</tr>
<%
if (noticeList.size() > 0) {
	int num = rcnt - (psize * (cpage - 1));
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
<select name="isview" onchange="isviewUpdate(this.form, this)">
	<option value="y" <% if (ni.getNl_isview().equals("y")) { %> selected="selected" <% } %>> 게 시 </option>
	<option value="n" <% if (ni.getNl_isview().equals("n")) { %> selected="selected" <% } %>> 미 게 시 </option>
</select>
<input type="hidden" name="idx" value="<%=ni.getNl_idx() %>" />
</form>
</td>
</tr>
<%
		num--;
	}
} else {
	out.println("<tr height='45'><td colspan='7' align='center'>공지사항이 없습니다.</td></tr>");
}
%>
</table>
<table width="1000" align="center" >
<tr align="center" >
<td width="*" valign="middle"><br />
<%
if (rcnt > 0) { 	// 게시글이 있으면 - 페이징 영역을 보여줌
	if (cpage == 1) {
		out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
	} else {
		out.println("<a href='notice_list?cpage=1" + "'>[처음]</a>&nbsp;&nbsp;&nbsp;<a href='notice_list?cpage=" + (cpage - 1) + ">[이전]</a>&nbsp;&nbsp;");
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
		out.println("<a href='notice_list?cpage=" + (cpage + 1) + "'>&nbsp;&nbsp;[다음]</a><a href='notice_list?cpage=" + pcnt + ">&nbsp;&nbsp;&nbsp;[마지막]</a>");
	}
}
%>

</td>
<td width="7%" align="right" valign="bottom">
<input type="button" value="글 등록" onclick="location.href='notice_form_in';" id="inBtn"/>
</td>
</tr>
</table>
</body>
</html>