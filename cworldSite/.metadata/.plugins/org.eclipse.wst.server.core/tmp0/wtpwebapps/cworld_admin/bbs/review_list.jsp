<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
ArrayList<ReviewInfo> reviewList = (ArrayList<ReviewInfo>)request.getAttribute("reviewList");

int cpage = pageInfo.getCpage(), psize = pageInfo.getPsize(), bsize = pageInfo.getBsize();
int rcnt = pageInfo.getRcnt(), pcnt = pageInfo.getPcnt(), spage = pageInfo.getSpage();

String args = "", sargs = "";
String sch = pageInfo.getSch();
if (sch == null ) {
	sch = "";
}
if (sch != null && !sch.equals("")) {
	sargs += "&sch=" + sch;
}
args = "&cpage=" + cpage + sargs;

String uid = "", ctgr = "", pname = "", isview = "";
double score = 0;
if (sch != null && !sch.equals("")) {
	//   &sch=itest,cR,s4,vy,p텐트		아이디, 대여-구매-패키지, 평점 범위, 게시여부, 상품명
	String[] arrSch = sch.split(",");
	for (int i = 0; i < arrSch.length; i++) {
		char c = arrSch[i].charAt(0);
		if (c == 'i') {
			uid = arrSch[i].substring(1);
		} else if (c == 'c') {
			ctgr = arrSch[i].substring(1); 
		} else if (c == 's') {
			score = Double.parseDouble(arrSch[i].substring(1)); 
		} else if (c == 'p') {
			pname = arrSch[i].substring(1); 
		} else if (c == 'v') {
			isview = arrSch[i].substring(1); 
		}
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
#subnavi03 { display:block; }
#schFrm { text-align:center; }
.title { text-align:left; }
.reviewInfo { 
	width:800px; height:700px; position:absolute; text-align:center; margin:-350px 0 0 -400px;
	background:white; color:black; display:none; border:1px black solid;
	top:50%; left:50%;
}
a { text-decoration:none; color:black; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:none; color:black; }
.icoX { position:absolute; top:15px; right:15px; }
#reviewListBox th, #reviewListBox td { border-bottom:1px black solid; border-collapse:collapse; }

.reviewInfoBox { 
	border-collapse:collapse; border-bottom:1px solid black; border-right:1px solid black;
	border-top:1px solid black; border-left:1px solid black;
 }
.reviewInfoBox th, .reviewInfoBox td { padding:8px 3px; }
</style>
<script>
function makeSch() {
	// &sch=itest,cR,s4,vy,p텐트		아이디, 대여-구매-패키지, 평점 범위, 게시여부, 상품명
	var frmR = document.reviewFrm;
	var frm = document.frmHidden;
	var sch = "";
	var uid = frmR.uid.value;
	if (uid != "") {
		sch += "i" + uid;
	}
	var ctgr = frmR.ctgr.value;
	if (ctgr != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "c" + ctgr;
	}
	var score = frmR.score.value;
	if (score != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "s" + score;
	}
	var isview = frmR.isview.value;
	if (isview != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "v" + isview;
	}
	var pname = frmR.pname.value;
	if (pname != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "p" + pname;
	}
	
	frm.sch.value = sch;
	frm.submit();
}

function clickEvt(i) {
	var review = "reviewInfo" + i;
	document.getElementById(review).style.display = "block";
	
}
function closeDiv(i) {
	var review = "reviewInfo" + i;
	document.getElementById(review).style.display = "none";
}
function reviewUp(is, idx) {
	$.ajax({
		type : "POST",				
		url : "/cworld_admin/reviewUp",		
		data : {"is" : is, "idx" : idx},		
		success : function(chkRs) {	
			if (chkRs == 1) {		
				alert("게시여부가 변경되었습니다.");
				location.reload();
			} else {				
				alert("게시여부 변경 실패");
			}
		}
	});
}
function resetSch() {
	var sch = "";
	var frm = document.frmHidden;
	frm.sch.value = sch;
	frm.submit();
}
</script>
</head>
<body>

<table width="1100" align="center">
<caption style="text-align:left; font-size:25px; font-weight:bold;">리 뷰 목 록</caption>
<tr><td>
<form name="frmHidden">
	<input type="hidden" name="sch" value="<%=sch %>" />
</form>
<form name="reviewFrm" id="schFrm">
<fieldset style="width:1100px; text-align:center;">
<legend class="title"> 검 색 조 건 </legend>
아이디 : <input type="text" name="uid" value="<%=uid %>" size="5" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
상품명 : <input type="text" name="pname" value="<%=pname %>" size="5" />
판매 종류 : 
<select name="ctgr" >
	<option value=""> 선 택 </option>
	<option value="R" <% if (ctgr.equals("R")) { %> selected="selected" <% } %>> 대 여 </option>
	<option value="S" <% if (ctgr.equals("S")) { %> selected="selected" <% } %>> 판 매 </option>
	<option value="P" <% if (ctgr.equals("P")) { %> selected="selected" <% } %>> 패 키 지 </option>
</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br /><br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
게시 여부 :  <select name="isview" >
	<option value=""> 선 택 </option>
	<option value="y" <% if (isview.equals("y")) { %> selected="selected" <% } %>> 게 시 </option>
	<option value="n" <% if (isview.equals("n")) { %> selected="selected" <% } %>> 미 게 시 </option>
</select>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
평점 : <input type="text" name="score" value="<%=score %>" onkeyup="onlyNum(this)" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="검색" class="btn" onclick="makeSch();" />	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="검색초기화" class="btn resetSch" onclick="resetSch();" />
</fieldset>
</form>
</td></tr>
</table>
<table align="center" width="1100" cellpadding="0" cellspacing="0" id="reviewListBox">
<tr align="center">
<th height="35" width="5%">번호</th>
<th width="7%">분류</th>
<th width="15%">상품명&옵션</th>
<th width="*" >제목</th>
<th width="10%">작성자</th>
<th width="15%">작성일</th>
<th width="7%">평점</th>
<th width="10%">게시여부</th>
</tr>
<%
if(reviewList.size() > 0) {
	int num = rcnt - (psize * (cpage - 1));
	for (int i = 0; i < reviewList.size(); i++) {
		ReviewInfo ri = reviewList.get(i);
%>
<tr align="center" height="45" onmouseover="this.bgColor='#cfcfcf';" onmouseout="this.bgColor='';">
<td><%=num %></td>
<td>
<% if (ri.getPi_id().indexOf("R") >= 0) { %>
대여
<% } else if (ri.getPi_id().indexOf("S") >= 0) { %>
판매
<% } else if (ri.getPi_id().indexOf("P") >= 0) { %>
패키지
<% } %>
</td>
<td><%=ri.getRl_pname() %></td>
<td align="left" onclick="clickEvt(<%=i %>);"  class="hand">&nbsp;&nbsp;<%=ri.getRl_title() %></td>
<td><%=ri.getMi_id() %></td>
<td><%=ri.getRl_date() %></td>
<td><%=ri.getRl_score() %></td>
<td>
<select name="isview" onchange="reviewUp(this.value, <%=ri.getRl_idx() %>)">
	<option value="y" <% if (ri.getRl_isview().equals("y")) { %> selected="selected" <% } %>>게 시</option>
	<option value="n" <% if (ri.getRl_isview().equals("n")) { %> selected="selected" <% } %>>미 게 시</option>
</select>
</td>
</tr>
<%	
	num--;
	}
%>
</table>
<%
	for (int i = 0; i < reviewList.size(); i++) {
		ReviewInfo ri = reviewList.get(i);
%>
<div id="reviewInfo<%=i %>" class="reviewInfo">
<img src="/cworld_admin/img/ico_x.png" width="35" height="35" class="icoX hand" onclick="closeDiv(<%=i %>);"/>
<br />
<table width="800" cellspacing="0" cellpadding="0" class="reviewInfoBox">
<caption style="font-size:25px; font-weight:bold;">리 뷰 상 세 보 기</caption>
<tr height="45">
<th width="20%">작성자</th>
<td  width="30%"><%=ri.getMi_id() %></td>
<th  width="20%">작성일</th>
<td  width="*"><%=ri.getRl_date() %></td>
</tr>
<tr height="45">
<th>분류</th>
<td><% if (ri.getPi_id().indexOf("R") >= 0) { %>
대여
<% } else if (ri.getPi_id().indexOf("S") >= 0) { %>
판매
<% } else if (ri.getPi_id().indexOf("P") >= 0) { %>
패키지
<% } %></td>
<th>작성자 아이피</th>
<td><%=ri.getRl_ip() %></td>
</tr>
<tr height="45">
<th>상품명 & 옵션</th>
<td><%=ri.getRl_pname() %></td>
<th>평점</th>
<td><%=ri.getRl_score() %></td>
</tr>
<tr height="45">
<th>제목</th>
<td colspan="3" align="left"><%=ri.getRl_title() %></td>
</tr>
<tr height="45">
<th>내용</th>
<td colspan="3" align="left"><%=ri.getRl_content().replaceAll("\r\n", "<br />") %></td>
</tr>
<% if (ri.getRl_img() != null && !ri.getRl_img().equals("")) { %>
<tr height="100">
<th>첨부파일</th>
<td colspan="3" align="left"><img src="/cworld_admin/upload_review/<%=ri.getRl_img() %>" width="90" height="90"/><%=ri.getRl_img() %></td>
</tr>
<% } %>
</table>
<br />
</div>
<%
	}
}else {
		out.println("<tr height='45'><td colspan='8' align='center'>검색 조건에 맞는 게시글이 없습니다.</td></tr></table>");
	}
%>
<p align="center" style="width:1100px; margin:0 auto;">
<%
if (rcnt > 0) { 	// 게시글이 있으면 - 페이징 영역을 보여줌
	if (cpage == 1) {
		out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
	} else {
		out.println("<a href='review_list?cpage=1" + sargs + "'>[처음]</a>&nbsp;&nbsp;&nbsp;<a href='review_list?cpage=" + (cpage - 1) + sargs + "'>[이전]</a>&nbsp;&nbsp;");
	}
	spage = (cpage - 1) / bsize * bsize + 1; 		// 현재 블록에서의 시작 페이지 번호
	for (int k = 1, j = spage; k <= bsize && j <= pcnt; k++, j++) {
		if (cpage == j) {
			out.println("&nbsp;<strong>" + j + "</strong>");
		} else {
			out.println("&nbsp;<a href='review_list?cpage=" + j + sargs + "'>" + j + "</a>");
		}	
	}
	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
	} else {
		out.println("<a href='review_list?cpage=" + (cpage + 1) + sargs + "'>&nbsp;&nbsp;[다음]</a><a href='review_list?cpage=" + pcnt + sargs + "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
	}
} 
%>
</p>
</body>
</html>