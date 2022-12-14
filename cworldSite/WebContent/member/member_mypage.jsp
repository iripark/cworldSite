<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
request.setCharacterEncoding("utf-8");
if (!isLogin){
	out.println("<script>");
	out.println("alert('잘못된 경로입니다.');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}
String os = (String)request.getAttribute("simpleOrder");
int mipoint = (int)request.getAttribute("mipoint");
String[] arrO = os.split(",");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#memberBox { 
	border-collapse:collapse; border-bottom:1px solid black; border-right:1px solid black;
	border-top:1px solid black; border-left:1px solid black;
 }
#memberBox th, #memberBox td { padding:8px 3px; }
.tmpSpan { font-weight:bold; }
</style>
</head>
<body>
<div class="content" align="center">
<p style="width:600px; text-align:left; align="center">
<img src="/cworldSite/img/ico_mp.png" width="120" hright="50"/>
</p>
<br /><br />
<table width="600" id="memberBox" align="center" border="1">
<tr align="center" height="70" style="font-size:18px;">
<td width="50%" colspan="2"><span class="tmpSpan">보유 포인트</span></td><td width="*" colspan="2"><%=mipoint %> point</td>
</tr>
<tr align="center" height="70" style="font-size:18px;">
<td width="25%"><span class="tmpSpan">입금대기중</span><br /><%=arrO[0] %></td>
<td width="25%"><span class="tmpSpan">배송대기중</span><br /><%=arrO[1] %></td>
<td width="25%"><span class="tmpSpan">배송중</span><br /><%=arrO[2] %></td>
<td width="25%"><span class="tmpSpan">배송완료</span><br /><%=arrO[3] %></td>
</tr>
<tr align="center">
<td><a href="jjim_list"><img src="/cworldSite/img/ico_jjim.png" width="120" height="120" /></a></td>
<td><a href="/cworldSite/member/info_form.jsp"><img src="/cworldSite/img/ico_info.png" width="120" height="120" /></a></td>
<td><a href="mypage_order_list"><img src="/cworldSite/img/ico_order.png" width="120" height="120" /></a></td>
<td><a href="mypage_rent_list"><img src="/cworldSite/img/ico_rent.png" width="120" height="120" /></a></td>
</tr>
<tr align="center">
<td><a href="my_review_list"><img src="/cworldSite/img/ico_myre.png" width="120" height="120" /></a></td>
<td><a href="member_point"><img src="/cworldSite/img/ico_point.png" width="120" height="120" /></a></td>
<td><a href="addr_ctrl"><img src="/cworldSite/img/ico_addr.png" width="120" height="120" /></a></td>
<td><a href="qna_list"><img src="/cworldSite/img/ico_qna.png" width="120" height="120" /></a></td>
</tr>
</table>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>