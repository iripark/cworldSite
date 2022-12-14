<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
ArrayList<GReviewInfo> grl = (ArrayList<GReviewInfo>)request.getAttribute("gReviewList");

int cpage = pageInfo.getCpage(), psize = pageInfo.getPsize(), bsize = pageInfo.getBsize();
int rcnt = pageInfo.getRcnt(), pcnt = pageInfo.getPcnt(), spage = pageInfo.getSpage();

String sargs = "";
String sch = pageInfo.getSch();
if (sch == null ) {
	sch = "";
}
if (sch != null && !sch.equals("")) {
	sargs += "&sch=" + sch;
}

String isview = "", schtype = "", keyword = "";
if (sch != null && !sch.equals("")) {
	//  검색조건 예시 :  &sch=vy			게시여부
	String[] arrSch = sch.split(",");
	for (int i = 0; i < arrSch.length; i++) {
		char c = arrSch[i].charAt(0);
		if (c == 'v') {
			isview = arrSch[i].substring(1); 
		} else if (c == 's') {
			String[] arrTmp = arrSch[i].substring(1).split(":");
			schtype = arrTmp[0];
			keyword = arrTmp[1];
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
.gReviewInfo { 
	width:800px; height:700px; position:absolute; text-align:center; margin:-350px 0 0 -400px;
	background:white; color:black; display:none; border:1px black solid;
	top:50%; left:50%;
}
a { text-decoration:none; color:black; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:none; color:black; }
.icoX { position:absolute; top:15px; right:15px; }
#gReviewListBox th, #gReviewListBox td { border-bottom:1px black solid; border-collapse:collapse; }

.gReviewInfoBox { 
	border-collapse:collapse; border-bottom:1px solid black; border-right:1px solid black;
	border-top:1px solid black; border-left:1px solid black;
 }
.gReviewInfoBox th, .gReviewInfoBox td { padding:8px 3px; }
</style>
<script>
function makeSch() {
//  검색조건 예시 :  &sch=vy,sasdfnkl:sdafjbasdf			아이디, 단체명, 게시여부, 답변여부, 결제여부
	var frmG = document.gReviewFrm;
	var frm = document.frmHidden;
	var sch = "";
	var isview = frmG.isview.value;
	if (isview != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "v" + isview;
	}
	var schtype = frmG.schtype.value;
	var keyword = frmG.keyword.value;
	if (schtype != "" && keyword != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "s" + schtype + ":" + keyword;
	}
	
	frm.sch.value = sch;
	frm.submit();
}

function clickEvt(i) {
	var gReview = "gReviewInfo" + i;
	document.getElementById(gReview).style.display = "block";
	
}
function closeDiv(i) {
	var gReview = "gReviewInfo" + i;
	document.getElementById(gReview).style.display = "none";
}
function gReviewUp(is, idx) {
	$.ajax({
		type : "POST",				
		url : "/cworld_admin/gReviewUp",		
		data : {"is" : is, "idx" : idx},		
		success : function(chkRs) {	
			if (chkRs == 1) {
				alert("게시 여부가 변경되었습니다.");
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
<caption style="text-align:left; font-size:25px; font-weight:bold;">단 체 후 기 목 록</caption>
<tr><td>
<form name="frmHidden">
	<input type="hidden" name="sch" value="<%=sch %>" />
</form>
<form name="gReviewFrm" method="get">
<fieldset style="width:1100px; text-align:center;">
<legend class="title"> 검 색 조 건 </legend>
	<select name="schtype">
		<option value="">검색조건</option>
		<option value="title" <% if (schtype.equals("title")) { %>selected="selected"<% } %>>제목</option>
		<option value="content" <% if (schtype.equals("content")) {%>selected="selected"<% } %>>내용</option>
		<option value="id" <% if (schtype.equals("id")) { %>selected="selected"<% } %>>작성자</option>
		<option value="gname" <% if (schtype.equals("gname")) { %>selected="selected"<% } %>>단체명</option>
		<option value="tc" <% if (schtype.equals("tc")) { %>selected="selected"<% } %>>제목+내용</option>
	</select>
	<input type="text" name="keyword" value="<%=keyword %>" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
게시 여부 :  <select name="isview" >
	<option value=""> 선 택 </option>
	<option value="y" <% if (isview.equals("y")) { %> selected="selected" <% } %>> 게 시 </option>
	<option value="n" <% if (isview.equals("n")) { %> selected="selected" <% } %>> 미 게 시 </option>
</select>&nbsp;&nbsp;&nbsp;
<input type="button" value="검색" onclick="makeSch();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="검색초기화" class="btn resetSch" onclick="resetSch();" />
</fieldset>
</form>
</td></tr>
</table>
<table align="center" width="1100" cellpadding="0" cellspacing="0" id="gReviewListBox">
<tr align="center">
<th height="45" width="5%">번호</th>
<th width="*">제목</th>
<th width="15%">단체명</th>
<th width="10%">작성자</th>
<th width="15%">작성일</th>
<th width="10%">게시여부</th>
</tr>
<%
if(grl.size() > 0) {
	int num = rcnt - (psize * (cpage - 1));
	for (int i = 0; i < grl.size(); i++) {
		GReviewInfo gri = grl.get(i);
%>
<tr align="center" height="45" onmouseover="this.bgColor='#cfcfcf';" onmouseout="this.bgColor='';">
<td><%=num %></td>
<td onclick="clickEvt(<%=i %>)" class="hand"><%=gri.getGr_title() %></td>
<td><%=gri.getGq_gname() %></td>
<td><%=gri.getMi_id() %></td>
<td><%=gri.getGr_date() %></td>
<td>
<select name="isview" onchange="gReviewUp(this.value, <%=gri.getGr_idx() %>)">
	<option value="y" <% if (gri.getGr_isview().equals("y")) { %> selected="selected" <% } %>>게 시</option>
	<option value="n" <% if (gri.getGr_isview().equals("n")) { %> selected="selected" <% } %>>미 게 시</option>
</select>
</td>
</tr>
<%	
	num--;
	}
%>
</table>
<%
	for (int i = 0; i < grl.size(); i++) {
		GReviewInfo gri = grl.get(i);
%>
<div id="gReviewInfo<%=i %>" class="gReviewInfo">
<img src="/cworld_admin/img/ico_x.png" width="35" height="35" class="icoX hand" onclick="closeDiv(<%=i %>);"/>
<br />
<table width="800" cellspacing="0" cellpadding="0" class="gReviewInfoBox">
<caption style="font-size:25px; font-weight:bold;">리 뷰 상 세 보 기</caption>
<tr height="45">
<th width="20%">작성자</th>
<td  width="30%"><%=gri.getMi_id() %></td>
<th  width="20%">작성일</th>
<td  width="*"><%=gri.getGr_date() %></td>
</tr>
<tr height="45">
<th>단체명</th>
<td><%=gri.getGq_gname() %></td>
<th>작성자 아이피</th>
<td><%=gri.getGr_ip() %></td>
</tr>
<tr height="45">
<th>제목</th>
<td colspan="3" align="left"><%=gri.getGr_title() %></td>
</tr>
<tr height="45">
<th>내용</th>
<td colspan="3" align="left"><%=gri.getGr_content().replaceAll("\r\n", "<br />") %></td>
</tr>
<% if (gri.getGr_img() != null && !gri.getGr_img().equals("")) { %>
<tr height="100">
<th>첨부파일</th>
<td colspan="3" align="left"><img src="/cworld_admin/upload_g_review/<%=gri.getGr_img() %>" width="90" height="90"/><%=gri.getGr_img() %></td>
</tr>
<% } %>
</table>
<br />
</div>
<%
	}
} else {
	out.println("<tr height='45'><td colspan='6' align='center'>검색 조건에 맞는 게시글이 없습니다.</td></tr></table>");
}
%>
<p align="center" style="width:1100px; margin:0 auto;">
<%
	if (rcnt > 0) { 	// 게시글이 있으면 - 페이징 영역을 보여줌
		if (cpage == 1) {
			out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
		} else {
			out.println("<a href='g_review_list?cpage=1" + sargs + "'>[처음]</a>&nbsp;&nbsp;&nbsp;<a href='g_review_list?cpage=" + (cpage - 1) + sargs + "'>[이전]</a>&nbsp;&nbsp;");
		}
		spage = (cpage - 1) / bsize * bsize + 1; 		// 현재 블록에서의 시작 페이지 번호
		for (int k = 1, j = spage; k <= bsize && j <= pcnt; k++, j++) {
			if (cpage == j) {
				out.println("&nbsp;<strong>" + j + "</strong>");
			} else {
				out.println("&nbsp;<a href='g_review_list?cpage=" + j + sargs + "'>" + j + "</a>");
			}	
		}
		if (cpage == pcnt) {
			out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
		} else {
			out.println("<a href='g_review_list?cpage=" + (cpage + 1) + sargs + "'>&nbsp;&nbsp;[다음]</a><a href='g_review_list?cpage=" + pcnt + sargs + "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
		}
	}

%>
</p>
</body>
</html>