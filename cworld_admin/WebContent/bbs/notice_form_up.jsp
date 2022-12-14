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
out.println(idx);
out.println(cpage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#subnavi03 { display:block; }
</style>
</head>
<body>
<form name="frm" action="notice_proc_up" method="post">
<input type="hidden" name="idx" value="<%=idx %>" />
<input type="hidden" name="cpage" value="<%=cpage %>" />
<table width="600" cellpadding="10" cellspacing="0" align="center">
<caption style="text-align:left; font-size:25px; font-weight:bold;">공 지 사 항 수 정</caption>
<tr>
<th width="15%">분류</th>
<td width="35%">
	<select name="ctgr">
		<option value="a" <% if (ni.getNl_ctgr().equals("a")) { %> selected="selected" <% } %>>공 지 사 항</option>
		<option value="b" <% if (ni.getNl_ctgr().equals("b")) { %> selected="selected" <% } %>>이 벤 트</option>
	</select>
</td>
<th>게시여부</th>
<td>
	<select name="isview">
		<option value="n" <% if (ni.getNl_isview().equals("n")) { %> selected="selected" <% } %>>미 게 시</option>
		<option value="y" <% if (ni.getNl_isview().equals("y")) { %> selected="selected" <% } %>>게 시</option>
	</select>
</td>
</tr>
<tr>
<th width="15%">글제목</th>
<td colspan="3">
	<input type="text" name="nl_title" value="<%=ni.getNl_title() %>" size="63" />
</td>
</tr>
<tr>
<th>글내용</th><td colspan="3"><textarea name="nl_content" rows="10" cols="65" style="resize:none;"><%=ni.getNl_content() %></textarea></td>
</tr>
<tr><td colspan="4" align="center">
<input type="submit" value="글 수정" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
<input type="button" value="취 소" onclick="location.href='notice_list'"/>	
</td></tr>
</table>
</form>
</body>
</html>