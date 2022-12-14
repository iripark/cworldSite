<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
NoticeInfo ni = (NoticeInfo)request.getAttribute("noticeInfo");
if (ni == null) {
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어왔습니다.');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}
int idx = Integer.parseInt(request.getParameter("idx"));
int cpage = Integer.parseInt(request.getParameter("cpage"));
String args = "?cpage=" + cpage; 	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#subnavi03 { display:block; }
#list { 
	border-collapse:collapse; border-bottom:1px solid black; border-right:1px solid black;
	border-top:1px solid black; border-left:1px solid black;
 }
#list th, #list td { padding:8px 3px;  }
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
<table width="600" cellpadding="5" id="list" align="center">
<caption style="text-align:left; font-size:25px; font-weight:bold;">
<% if (ni.getNl_ctgr().equals("a")) { %> 공 지 사 항 <% } else { %> 이 벤 트 <% } %>
</caption>
<tr>
<th width="10%">작성자</th><td width="15%"><%=ni.getAi_name() %></td>
<th width="10%">조회수</th><td width="15%"><%=ni.getNl_read() %></td>
<th width="*">작성일</th><td width="*"><%=ni.getNl_date() %></td>
</tr>
<tr>
<th >글제목</th><td colspan="3"><%=ni.getNl_title() %></td><th>게시여부</th>
<td>
<form name="frmV">
<input type="hidden" name="idx" value="<%=ni.getNl_idx() %>" />
	<select name="isview" onchange="isviewUpdate(this.form, this);">
		<option value="n" <% if(ni.getNl_isview().equals("n")) {%> selected="selected" <% } %>>미 게 시</option>
		<option value="y" <% if(ni.getNl_isview().equals("y")) {%> selected="selected" <% } %>>게 시</option>
	</select>
</form>
</td>
</tr>
<tr>
<th>글내용</th><td colspan="5" height="300"><%=ni.getNl_content().replaceAll("\r\n", "<br />") %></td>
</tr>
<tr><td colspan="6" align="center">
<%
String upLink = "notice_form_up" + args + "&idx=" + idx;
String delLink = "notice_proc_del?idx=" + idx;
%>
<script>
function realDel() {
	if (confirm("정말 삭제하시겠습니까?\n삭제된 글은 다시 복구할 수 없습니다.")) {
		location.href = "<%=delLink %>";
	} else {
		hitory.back();
	}
}
</script>
	<input type="button" value="글 수정" onclick="location.href='<%=upLink %>';"/>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="글 삭제" onclick="realDel();"/>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
	<input type="button" value="글 목록" onclick="location.href='notice_list<%=args %>';"/>	
</td></tr>
</table>
</body>
</html>