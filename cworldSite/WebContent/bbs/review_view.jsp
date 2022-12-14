<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ReviewInfo ri = (ReviewInfo)request.getAttribute("ri");
if (ri == null) {
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어왔습니다.');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}
String piid = (String)request.getAttribute("piid");
int idx = Integer.parseInt(request.getParameter("idx"));
// 글번호로 반드시 있어야 하는 값이므로 받을때 int형으로 변환하여 받음 
int cpage = Integer.parseInt(request.getParameter("cpage"));
// 현재 페이지 번호로 반드시 있어야 하는 값이므로 받을때 int형으로 변환하여 받음
String args = "?cpage=" + cpage; 	// 링크에서 사용할 쿼리스트링을 저장

String schtype = request.getParameter("schtype");	// 검색조건
String keyword = request.getParameter("keyword");	// 검색어

if (schtype != null && keyword != null && !schtype.equals("") && !keyword.equals("")) {
// 검색 조건(schtype)과 검색어(keyword)가 null이 아니고, 빈문자열이 아닐경우
	keyword.trim().replace("'", "''");
	args = args + "&schtype=" + schtype + "&keyword=" + keyword;
	// 다른 링크들 에서도 검색관련 값들을 연결해줌
} 

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#reviewBox { 
	border-collapse:collapse; border-bottom:1px solid black; border-right:1px solid black;
	border-top:1px solid black; border-left:1px solid black;
 }
#reviewBox th, #reviewBox td { padding:8px 3px;  }
.star-ratings {
  color: #aaa9a9; 
  position: relative;
  unicode-bidi: bidi-override;
  width: max-content;
  -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
  -webkit-text-stroke-width: 1.3px;
  -webkit-text-stroke-color: #2b2a29;
}

.star-ratings-fill {
  color: #fff58c;
  padding: 0;
  position: absolute;
  z-index: 1;
  display: flex;
  top: 0;
  left: 0;
  overflow: hidden;
  -webkit-text-fill-color: gold;
}

.star-ratings-base {
  z-index: 0;
  padding: 0;
}
</style>
</head>
<body>
<div class="content" align="center" >
<p style="width:700px; text-align:left;">
<img src="/cworldSite/img/ico_bbs_review.png" width="100" height="40"/>
</p>
<br />
<table width="700" cellpadding="0" cellspaing="0" id="reviewBox" align="center" >
<tr height="40">
<th width="15%">작성자</th><td width="15%"><%=ri.getMi_id() %></td>
<th width="15%">조회수</th><td width="15%"><%=ri.getRl_read() %></td>
<th width="*">작성일</th><td width="*"><%=ri.getRl_date() %></td>
</tr>
<tr height="40">
<th>상품명 및 옵션</th><td colspan="3"><a href="product_view?piid=<%=piid %>"><%=ri.getRl_pname() %></a></td>
<th>평점</th><td><div class="star-ratings" style="display:inline-block;">
		<div class="star-ratings-fill space-x-2 text-lg" style="width: <%=ri.getRl_score()*20 %>%;">
			<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
		</div>
		<div class="star-ratings-base space-x-2 text-lg">
			<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
		</div>
	</div>&nbsp;( <%=ri.getRl_score() %> )<br/></td>
</tr>
<tr height="40">
<th>글제목</th><td colspan="5"><%=ri.getRl_title() %></td>
</tr>
<tr>
<th>글내용</th><td colspan="5" height="300"><%=ri.getRl_content().replaceAll("\r\n", "<br />") %></td>
</tr>
<% if (ri.getRl_img() != null && !ri.getRl_img().equals("")) { %>
<tr height="100"><th>첨부파일</th>
<td colspan="5" align="left">
	<img src="/cworld_admin/upload_review/<%=ri.getRl_img() %>" width="120" height="120"/>
</td>
</tr>
<% } %>
</table>
<p style="width:700px; height:100px; text-align:center; ">
<br />
<input type="button" value="글 목록" onclick="location.href='review_list<%=args %>';" style="width:90px; height:40px;"/>
<br />
</p>
	
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>