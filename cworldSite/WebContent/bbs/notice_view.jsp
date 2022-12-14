<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%

// 해당 글을 눌르고 들어 갔을 때 보여주는 화면

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
#noticeBox { 
	border-collapse:collapse; border-bottom:1px solid black; border-right:1px solid black;
	border-top:1px solid black; border-left:1px solid black;
 }
#noticeBox th, #noticeBox td { padding:8px 3px;  }
</style>
</head>
<body>
<div class="content" align="center" >
<p style="width:600px; text-align:left;">
<% if (ni.getNl_ctgr().equals("a")) { %>
<img src="/cworldSite/img/ico_bbs_notice.png" width="100" height="40"/>
<% } else { %>
<img src="/cworldSite/img/ico_bbs_event.png" width="100" height="40"/>
<% } %>
</p>
<br />
<table width="600" cellpadding="5" id="noticeBox" align="center" border="1">
<tr>
<th width="10%">작성자</th><td width="15%"><%=ni.getAi_name() %></td>
<th width="10%">조회수</th><td width="15%"><%=ni.getNl_read() %></td>
<th width="*">작성일</th><td width="*"><%=ni.getNl_date() %></td>
</tr>
<tr>
<th >글제목</th><td colspan="5"><%=ni.getNl_title().replaceAll("\r\n", "<br />") %></td>
</tr>
<tr>
<th>글내용</th><td colspan="5" height="300"><%=ni.getNl_content().replaceAll("\r\n", "<br />") %></td>
</tr>
<tr><td colspan="6" align="center">
	<input type="button" value="글 목록" onclick="location.href='notice_list<%=args %>';"/>	
</td></tr>
</table>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>