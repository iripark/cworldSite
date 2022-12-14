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
ArrayList<QnaInfo> ql = (ArrayList<QnaInfo>)request.getAttribute("qnaList");

PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");

int cpage = pageInfo.getCpage(), psize = pageInfo.getPsize(), bsize = pageInfo.getBsize();
int rcnt = pageInfo.getRcnt(), pcnt = pageInfo.getPcnt(), spage = pageInfo.getSpage();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#qnaListBox { width:800px; }
#qnaListBox th, #qnaListBox td { border-bottom:1px black solid; border-collapse:collapse; }
#qnaListBox th { text-align:center;}
strong { font-weight:bold; }
</style>
</head>
<body>
<div class="content" align="center">
<p style="width:800px; text-align:left;">
<img src="/cworldSite/img/qna_list.png" width="100" height="40"/>
</p>
<p style="width:800px; text-align:right;">
<input type="button" value="문의 하기" onclick="location.href='qna_form'" />
</p>
<br />
<table width="800" align="center" id="qnaListBox" cellpadding="0" cellspacing="0">
<tr height="45">
<th>번호</th><th>분류</th><th>제목</th><th>작성일</th><th>답변상태</th>
</tr>
<% 

if (ql.size() > 0) { 
int num = (rcnt - (psize * (cpage - 1)));
	for (int i = 0; i < ql.size(); i++) {
		QnaInfo qi = ql.get(i);
		
		
%>
<tr align="center" height="45" onmouseover="this.bgColor='#cfcfcf';" onmouseout="this.bgColor='';">
<td><%=num %></td>
<td>
<% if (qi.getQl_ctgr().equals("a")) { %>
회원관련
<% } else if (qi.getQl_ctgr().equals("b")) { %>
상품관련
<% } else if (qi.getQl_ctgr().equals("c")) { %>
결제관련
<% } else if (qi.getQl_ctgr().equals("d")) { %>
기타
<% } %> 
</td>
<td align="left"><a href="qna_view?idx=<%=qi.getQl_idx() %>&cpage=<%=cpage %>" ><%=qi.getQl_title() %></a></td>
<td><%=qi.getQl_qdate() %></td>
<td>
<% if(qi.getQl_isanswer().equals("y")) { %>
답변완료
<% } else { %>
답변대기
<% } %>
</td>
</tr>
<%
num--;
	}
%>
<% } else { %>
<tr><td align="center" height="50" colspan="5">문의 내역이 없습니다.</td></tr>
<% } %>
</table>
<br />
<p style="width:800px; text-align:center;">
<%
pcnt = rcnt / psize;
if (rcnt % psize > 0) {
	pcnt++;
}
if (rcnt > 0) { 	// 게시글이 있으면 - 페이징 영역을 보여줌
	if (cpage == 1) {
		out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
	} else {
		out.println("<a href='qna_list?cpage=1'>[처음]</a>&nbsp;&nbsp;&nbsp;<a href='qna_list?cpage=" + (cpage - 1) + "'>[이전]</a>&nbsp;&nbsp;");
	}
	spage = (cpage - 1) / bsize * bsize + 1; 		// 현재 블록에서의 시작 페이지 번호
	for (int i = 1, j = spage; i <= bsize && j <= pcnt; i++, j++) {
		// i : 블록에서 보여줄 페이지의 개수만큼 루프를 돌릴 조건으로 사용되는 변수
		// j : 실제 출력한 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 사용해야 함
		if (cpage == j) {
			out.println("&nbsp;<strong>" + j + "</strong>");
		} else {
			out.println("&nbsp;<a href='qna_list?cpage=" + j + "'>" + j + "</a>");
		}	
	}
	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
	} else {
		out.println("<a href='qna_list?cpage=" + (cpage + 1) + "'>&nbsp;&nbsp;[다음]</a><a href='qna_list?cpage=" + pcnt + "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
	}
}
%>
</p>
<br />
<p style="width:800px; text-align:right;">
<input type="button" value="마이페이지" class="mpBtn" onclick="location.href='member_page'" />&nbsp;&nbsp;
</p>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>