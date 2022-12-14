<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
request.setCharacterEncoding("utf-8");
QnaInfo qi = (QnaInfo)request.getAttribute("qi");
int cpage = Integer.parseInt(request.getParameter("cpage"));
if (qi == null) {
%>
<script>
alert("잘못된 경로로 들어왔습니다.");
location.replace("/cworldSite/index.jsp");
</script>
<%
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#qnaAViewBox, #qnaQViewBox { 
	border-collapse:collapse; border-bottom:1px solid black; border-right:1px solid black;
	border-top:1px solid black; border-left:1px solid black;
 }
#qnaAViewBox th, #qnaAViewBox td, #qnaQViewBox th, #qnaQViewBox td { padding:8px 3px; }
#qnaAViewBox th, #qnaQViewBox th { text-align:center; }
</style>
<script>
function qnaDel(idx) {
	if (confirm("정말로 삭제하시겠습니다?\n답변이 달린 후에는 삭제하실 수 없습니다.")) {
		$.ajax({
			type : "POST",				
			url : "/cworldSite/qna_del",		
			data : {"idx" : idx},		
			success : function(chkRs) {			
				if (chkRs == 0) {	// 옵션 변경에 실패 했을 경우
					alert("1:1 게시글 삭제에 실패했습니다.");
				} 
				location.replace("qna_list");
			}
		});
	}
}
function satisQna(opt, idx) {
	$.ajax({
		type : "POST",				
		url : "/cworldSite/qna_satis",		
		data : {"opt" : opt, "idx" : idx},		
		success : function(chkRs) {			
			if (chkRs == 0) {	// 옵션 변경에 실패 했을 경우
				alert("만족도 조사에 실패했습니다.");
			} else {
				alert("만족도 조사에 참여해 주셔서 감사합니다.");
				location.replace("qna_view?cpage=<%=cpage %>&idx=" + idx);
			}
		}
	});
}
</script>
</head>
<body>
<div class="content" align="center">
<p style="width:700px; text-align:left;">
<img src="/cworldSite/img/qna_view.png" width="100" height="40"/>
</p>
<p style="width:670px; text-align:left;">
<img src="/cworldSite/img/qna_q.png" width="70" height="40"/>
</p>
<br />
<table width="700" id="qnaQViewBox" align="center">
<tr height="45">
<th width="25%">분류</th>
<td width="*" colspan="3">
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
</tr>
<tr height="45">
<th>작성자</th>
<td>
<%=qi.getMi_id() %>
</td>
<th>작성일</th>
<td>
<%=qi.getQl_qdate() %>
</td>
</tr>
<tr height="45">
<th>제목</th>
<td colspan="3">
<%=qi.getQl_title() %>
</td>
</tr>
<tr height="250">
<th>내용</th>
<td colspan="3">
<%=qi.getQl_content().replaceAll("\r\n", "<br />") %>
</td>
</tr>
<tr>
<% if (qi.getQl_img1() != null && !qi.getQl_img1().equals("")) { %>
<th>첨부파일</th>
<td colspan="3">
<img src="/cworld_admin/upload_qna/<%=qi.getQl_img1() %>" width="80" height="80"/>
</td>
</tr>
<% } %>
</table>
<br />
<p style="width:700px; text-align:left;">
<% if (qi.getQl_isanswer().equals("n")) { %><input type="button" value="삭제" onclick="qnaDel(<%=qi.getQl_idx() %>);"/> <% } %>
</p>
<br />
<p style="width:670px; text-align:left;">
<img src="/cworldSite/img/qna_a.png" width="70" height="40"/>
</p>
<table width="700" id="qnaAViewBox" align="center">
<% if (qi.getQl_isanswer().equals("y")) { %>
<tr>
<th height="45" width="25%">답변 관리자</th>
<td width="25%"><%=qi.getQl_ai_name() %></td>
<th width="25%">답변일</th>
<td width="25%"><%=qi.getQl_adate() %></td>
</tr>
<tr>
<th height="250">답변 내용</th>
<td colspan="3"><%=qi.getQl_answer().replaceAll("\r\n", "<br />") %></td>
</tr>
<tr>
<th>만족도 조사</th>
<td>
<% if (qi.getQl_satis().equals("z")) { %>
<select name="satis" onchange="satisQna(this.value, <%=qi.getQl_idx() %>);">
	<option value="z">만 족 도 평 가</option>
	<option value="a">매 우 만 족</option>
	<option value="b">만 족</option>
	<option value="c">보 통</option>
	<option value="d">불 만 족</option>
	<option value="e">매 우 불 만 족</option>
</select>
<% } else { %>
<% if (qi.getQl_satis().equals("a")) { %>
매우만족
<% } else if (qi.getQl_satis().equals("b")) { %>
만족
<% } else if (qi.getQl_satis().equals("c")) { %>
보통
<% } else if (qi.getQl_satis().equals("d")) { %>
불만족
<% } else if (qi.getQl_satis().equals("e")) { %>
매우불만족
<% } %>
<% } %>
</td>
</tr>
<% } else { %>
<tr><td height="50" align="center">아직 답변이 달리지 않았습니다.</td></tr>
<% } %>
</table>
<br />
<p style="width:700px; text-align:right;">
<input type="button" value="목록으로" onclick="location.href='qna_list'"/>
</p>
<br />
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>