<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%

request.setCharacterEncoding("utf-8");
String oiid = request.getParameter("oiid");
if(!isLogin || oiid == null || oiid.equals("")){
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어오셨습니다.'); history.back();");
	out.println("</script>");
	out.close();	
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="content" align="center">
<div id="orderAfter">
결제가 완료되었습니다!<br/>
주문번호 : <%=oiid %>
</div>
<input type="button" value="주문 내역" onclick="location.href='/cworldSite/mypage_order_list';"/>
   <input type="button" value="홈으로" onclick="location.href='/cworldSite/index.jsp';"/>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>