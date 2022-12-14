<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
request.setCharacterEncoding("utf-8");
GqnaInfo gqi = (GqnaInfo)request.getAttribute("gqnaInfo");
if (gqi == null) {
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
#list { 
	border-collapse:collapse; border-bottom:1px solid black; border-right:1px solid black;
	border-top:1px solid black; border-left:1px solid black;
 }
#list th, #list td { padding:8px 3px;  }
</style>
</head>
<body>
<div class="content" align="center">
<p style="width:600px; text-align:left;">
<img src="/cworldSite/img/group_qna_view.png" width="100" height="40"/>
</p>
<% if(gqi.getGq_pay().equals("y")) { %>
<p style="width:600px; text-align:right; ">
<input type="button" value="리뷰 작성" onclick="location.href='g_review_form_ctrl?idx=<%=gqi.getGq_idx() %>$gname=<%=gqi.getGq_gname() %>';"/>
</p>
<% } %>
<br />
<table width="600" cellpadding="5" id="list" align="center" border="1">
<tr>
<th width="20%">작성자</th><td width="20%"><%=gqi.getMi_id() %></td>
<th colspan="2">작성일</th><td><%=gqi.getGq_date() %></td>
<tr>
<th rowspan="2">연락처 정보</th><td rowspan="2"><%=gqi.getGq_phone() %> </td>
<th rowspan="2">견적 회신 받을 곳</th><th width="10%">이메일</th><td><%=gqi.getGq_ef() %> </td>
</tr>
<tr>
<th>단체명</th>
<td><%=gqi.getGq_gname() %></td>
</tr>
<tr>
<th >글제목</th><td colspan="5"><%=gqi.getGq_title() %></td>
</tr>
<tr>
<th>글내용</th><td colspan="6" height="300"><%=gqi.getGq_content().replaceAll("\r\n", "<br />") %></td>
</tr>
</table>
<br />
<input type="button" value="글 목록" onclick="location.href='g_qna_list<%=args %>';"/>	
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>