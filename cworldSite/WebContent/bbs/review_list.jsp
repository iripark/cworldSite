<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
ArrayList<ReviewInfo> reviewList = (ArrayList<ReviewInfo>)request.getAttribute("reviewList");

int cpage = pageInfo.getCpage(), psize = pageInfo.getPsize(), bsize = pageInfo.getBsize();
int rcnt = pageInfo.getRcnt(), pcnt = pageInfo.getPcnt(), spage = pageInfo.getSpage();
String schtype = pageInfo.getSchtype(), keyword = pageInfo.getKeyword();
String schargs = "", args = "";
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	schargs = "&schtype=" + schtype + "&keyword=" + keyword;
	// 검색 조건과 검색어가 있으면 검색관련 데이터들을 쿼리스트링으로 지정
}
args = "&cpage=" + cpage + schargs;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
a { text-decoration:none; color:black; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:none; color:black; }
#reviewListBox { width:800px; }
#reviewListBox th, #reviewListBox td { border-bottom:1px black solid; border-collapse:collapse; }
#reviewListBox th { text-align:center; }
strong { font-weight:bold; }
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
<div class="content" align="center">
<p align="center" style="width:800px; text-align:left; ">
<a href="/cworldSite/notice_list"><img src="/cworldSite/img/ico_notice.png" width="80" height="45"/></a>&nbsp;&nbsp;
<a href="/cworldSite/review_list"><img src="/cworldSite/img/ico_review_on.png" width="80" height="45"/></a>&nbsp;&nbsp;
<a href="/cworldSite/g_qna_list"><img src="/cworldSite/img/ico_gqna.png" width="80" height="45"/></a>&nbsp;&nbsp;
<a href="/cworldSite/g_review_list"><img src="/cworldSite/img/ico_greview.png" width="80" height="45"/></a>&nbsp;&nbsp;
</p>
<table width="800" cellpadding="0" cellspacing="0" id="reviewListBox">
<tr height="30">
<th width="7%" align="center" height="35">번호</th>
<th width="17%" align="center">상품명</th>
<th width="15%" align="center">평가</th>
<th width="*%" align="center">제목</th>
<th width="10%" align="center">작성자</th>
<th width="10%" align="center">작성일</th>
<th width="7%" align="center">조회</th>
<%
if (reviewList.size() > 0) {
	int num = (rcnt - (psize * (cpage - 1)));
	for (int i = 0; i < reviewList.size(); i++) {
		ReviewInfo ri = reviewList.get(i);
		String title = reviewList.get(i).getRl_title();
		if (title.length() > 20) {
			title = title.substring(0, 17) + "...";
		}
		title = "<a href='review_view?idx=" + ri.getRl_idx() + args + "'>" + title + "</a>";
		out.println("<tr align='center'>");
		out.println("<td height='35'>" + (num) + "</td>");
		num--;
		out.println("<td>" + ri.getRl_pname() + "</td>");%>
<td><div class="star-ratings" style="display:inline-block;">
		<div class="star-ratings-fill space-x-2 text-lg" style="width: <%=ri.getRl_score()*20 %>%;">
			<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
		</div>
		<div class="star-ratings-base space-x-2 text-lg">
			<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
		</div>
	</div>&nbsp;( <%=ri.getRl_score() %> )<br/></td>
	<%	out.println("<td align='left'>&nbsp;&nbsp;" + title + "</td>");
		out.println("<td>" + ri.getMi_id() + "</td>");
		out.println("<td>" + ri.getRl_date() + "</td>");
		out.println("<td>" + ri.getRl_read() + "</td>");
		out.println("</tr>");
		
	}
} else {
	out.println("<tr height='50'><td colspan='7' align='center'>");
	out.println("검색 결과가 없습니다.</td></tr>");
}
%>
</table>
<br />
<table width="800" cellpadding="0" >
<tr>
<td width="600" colspan="2" align="center">
<%
pcnt = rcnt / psize;
if (rcnt % psize > 0) {
	pcnt++;
}
if (rcnt > 0) { 	// 게시글이 있으면 - 페이징 영역을 보여줌
	if (cpage == 1) {
		out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
	} else {
		out.println("<a href='review_list?cpage=1" + schargs + "'>[처음]</a>&nbsp;&nbsp;&nbsp;<a href='review_list?cpage=" + (cpage - 1) + schargs + "'>[이전]</a>&nbsp;&nbsp;");
	}
	spage = (cpage - 1) / bsize * bsize + 1; 		// 현재 블록에서의 시작 페이지 번호
	for (int i = 1, j = spage; i <= bsize && j <= pcnt; i++, j++) {
		// i : 블록에서 보여줄 페이지의 개수만큼 루프를 돌릴 조건으로 사용되는 변수
		// j : 실제 출력한 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 사용해야 함
		if (cpage == j) {
			out.println("&nbsp;<strong>" + j + "</strong>");
		} else {
			out.println("&nbsp;<a href='review_list?cpage=" + j + schargs + "'>" + j + "</a>");
		}	
	}
	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
	} else {
		out.println("<a href='review_list?cpage=" + (cpage + 1) + schargs + "'>&nbsp;&nbsp;[다음]</a><a href='review_list?cpage=" + pcnt + schargs + "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
	}
}
%>
<br />
</td>
</tr>
<tr>
<td align="left">&nbsp;<input type="button" value="전체글" onclick="location.href='review_list';" /></td>
<td align="right">

	<form name="frmSch" method="get">
	<fieldset>
		<legend>게시판 검색</legend>	
		<select name="schtype">
			<option value="">검색조건</option>
			<option value="title" <% if (schtype.equals("title")) { %>selected="selected"<% } %>>제목</option>
			<option value="content" <% if (schtype.equals("content")) {%>selected="selected"<% } %>>내용</option>
			<option value="writer" <% if (schtype.equals("writer")) { %>selected="selected"<% } %>>작성자</option>
			<option value="tc" <% if (schtype.equals("tc")) { %>selected="selected"<% } %>>제목+내용</option>
		</select>
		<input type="text" name="keyword" value="<%=keyword %>" /><input type="submit" value="검색" />
		&nbsp;
	</fieldset>
	</form>
</td>
</tr>
</table>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>