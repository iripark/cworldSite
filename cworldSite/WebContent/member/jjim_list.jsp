<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
ArrayList<PdtInfo> jjimList = (ArrayList<PdtInfo>)request.getAttribute("jjimList"); 


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#jjimListBox { width:800px; }
#jjimListBox th, #jjimListBox td { border-bottom:1px black solid; border-collapse:collapse; }
#jjimListBox th { text-align:center;}
</style>
</head>
<body>
<div class="content" align="center">
<p style="width:800px; text-align:left;">
<img src="/cworldSite/img/mp_jjim.png" width="100" height="40"/>
</p>

<% if (jjimList.size() > 0) { %>
<table width="800" align="center" id="jjimListBox" cellpadding="0" cellspacing="0">
<tr height="45">
<th width="5%">번호</th>
<th width="20%">상품이미지</th>
<th width="45%">상품명</th>
<th width="15%">판매가</th>
<th width="*">찜등록날짜</th>
</tr>
<% for (int i = 0; i < jjimList.size(); i++) {
		PdtInfo pi = jjimList.get(i);
		String pcbName = "";
		if (pi.getPi_id().charAt(0) == 'S'){
			pcbName = "캠핑용품 판매";
		} else if (pi.getPi_id().charAt(0) == 'R'){	
			pcbName = "캠핑용품 대여";
		} else {
			pcbName = "풀세트패키지 대여";
		}
		
%>
<tr align="center">
<td><%=i + 1 %></td>
<td><a href="product_view?piid=<%=pi.getPi_id() %>"><img src="/cworldSite/pdt_img/<%=pi.getPi_img1() %>" width="80" height="80" /></a></td>
<td align="left">&nbsp;<a href="product_view?piid=<%=pi.getPi_id() %>"><%=pcbName %> - <%=pi.getPi_name() %></a></td>
<td><%=pi.getRealPrice() %></td>
<td><%=pi.getMj_date() %></td>
</tr>

<%
}
%>
</table>
<% } else { %>

<img src="/cworldSite/img/ico_nojjim.png" width="450" height="450"/>
<br />
찜 등록한 상품이 없습니다.

<% } %>

<br />
<p style="width:800px; text-align:right;">
<input type="button" value="마이페이지" class="mpBtn" onclick="location.href='member_page'" />
</p>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>