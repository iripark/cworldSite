<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
request.setCharacterEncoding("utf-8");
GReviewInfo gri = (GReviewInfo)request.getAttribute("gri");
if (gri == null) {
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
#gReviewInfoBox { 
	border-collapse:collapse; border-bottom:1px solid black; border-right:1px solid black;
	border-top:1px solid black; border-left:1px solid black;
 }
#gReviewInfoBox th, #gReviewInfoBox td { padding:8px 3px;  }
</style>
</head>
<body>
<div class="content" align="center">
<p style="width:600px; text-align:left;">
<img src="/cworldSite/img/group_review_view.png" width="100" height="40"/>
</p>
<br />
<table width="600" cellpadding="5" id="gReviewInfoBox" align="center" border="1">
<tr>
<th width="15%">작성자</th><td width="20%"><%=gri.getMi_id() %></td>
<th width="15%">단체명</th><td width="20%"><%=gri.getGq_gname() %></td>
<th width="15%">작성일</th><td width="*"><%=gri.getGr_date() %></td>
</tr>
<tr>
<th >글제목</th><td colspan="5"><%=gri.getGr_title() %></td>
</tr>
<tr>
<th>글내용</th><td colspan="5" height="300"><%=gri.getGr_content().replaceAll("\r\n", "<br />") %></td>
</tr>
<% if(gri.getGr_img() != null && !gri.getGr_img().equals("")) {%>
<tr>
<th>첨부파일</th><td colspan="5"><img src="/cworld_admin/upload_g_review/<%=gri.getGr_img() %>" alt="첨부파일" width="90" height="90"/></td>
</tr>
<% } %>
</table>
<br />
<input type="button" value="글 목록" onclick="location.href='g_review_list<%=args %>';"/>	
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>