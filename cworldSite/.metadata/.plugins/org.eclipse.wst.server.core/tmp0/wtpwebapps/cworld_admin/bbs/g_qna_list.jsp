<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
ArrayList<GQnaInfo> gql = (ArrayList<GQnaInfo>)request.getAttribute("gQnaList");

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

String uid = "", gname = "", answer = "", isview = "", pay = "";
double score = 0;
if (sch != null && !sch.equals("")) {
	//  검색조건 예시 :  &sch=itest,g2조,vy,ay,py			아이디, 단체명, 게시여부, 답변여부, 결제여부 
	String[] arrSch = sch.split(",");
	for (int i = 0; i < arrSch.length; i++) {
		char c = arrSch[i].charAt(0);
		if (c == 'i') {
			uid = arrSch[i].substring(1);
		} else if (c == 'g') {
			gname = arrSch[i].substring(1); 
		} else if (c == 'v') {
			isview = arrSch[i].substring(1); 
		} else if (c == 'a') {
			answer = arrSch[i].substring(1); 
		} else if (c == 'p') {
			pay = arrSch[i].substring(1); 
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
.gqnaInfo { 
	width:800px; height:700px; position:absolute; text-align:center; margin:-350px 0 0 -400px;
	background:white; color:black; display:none; border:1px black solid;
	top:50%; left:50%;
}
a { text-decoration:none; color:black; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:none; color:black; }
.icoX { position:absolute; top:15px; right:15px; }
#gqnaListBox th, #gqnaListBox td { border-bottom:1px black solid; border-collapse:collapse; }

.gqnaInfoBox { 
	border-collapse:collapse; border-bottom:1px solid black; border-right:1px solid black;
	border-top:1px solid black; border-left:1px solid black;
 }
.gqnaInfoBox th, .gqnaInfoBox td { padding:8px 3px; }
</style>
<script>
function makeSch() {
//  검색조건 예시 :  &sch=itest,g2조,iy,ay,py			아이디, 단체명, 게시여부, 답변여부, 결제여부
	var frmG = document.gQnaFrm;
	var frm = document.frmHidden;
	var sch = "";
	var uid = frmG.uid.value;
	if (uid != "") {
		sch += "i" + uid;
	}
	var gname = frmG.gname.value;
	if (gname != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "g" + gname;
	}
	var isview = frmG.isview.value;
	if (isview != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "v" + isview;
	}
	var answer = frmG.answer.value;
	if (answer != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "a" + answer;
	}
	
	var pay = frmG.pay.value;
	if (pay != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "p" + pay;
	}
	
	frm.sch.value = sch;
	frm.submit();
}

function clickEvt(i) {
	var gqna = "gqnaInfo" + i;
	document.getElementById(gqna).style.display = "block";
	
}
function closeDiv(i) {
	var gqna = "gqnaInfo" + i;
	document.getElementById(gqna).style.display = "none";
}
function gqnaUp(kind, is, idx) {	// a : 답변, p : 결제, i : 게시
	$.ajax({
		type : "POST",				
		url : "/cworld_admin/gqnaUp",		
		data : {"kind" : kind, "is" : is, "idx" : idx},		
		success : function(chkRs) {	
			if (chkRs == 1) {	
				if (kind == "a") {
					alert("답변 여부가 변경되었습니다.");
				} else if (kind == "p") {
					alert("결제 여부가 변경되었습니다.");
				} else {
					alert("게시 여부가 변경되었습니다.");
				}
				
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
<caption style="text-align:left; font-size:25px; font-weight:bold;">단 체 문 의 목 록</caption>
<tr><td>
<form name="frmHidden">
	<input type="hidden" name="sch" value="<%=sch %>" />
</form>
<form name="gQnaFrm" id="schFrm">
<fieldset style="width:1100px; text-align:center;">
<legend class="title"> 검 색 조 건 </legend>
아이디 : <input type="text" name="uid" value="<%=uid %>" size="5" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
단체명 : <input type="text" name="gname" value="<%=gname %>" size="5" />
답변 여부 : 
<select name="answer" >
	<option value=""> 선 택 </option>
	<option value="y" <% if (answer.equals("y")) { %> selected="selected" <% } %>> 답 변 완 료 </option>
	<option value="n" <% if (answer.equals("n")) { %> selected="selected" <% } %>> 미 답 변 </option>
</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br /><br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
게시 여부 :  <select name="isview" >
	<option value=""> 선 택 </option>
	<option value="y" <% if (isview.equals("y")) { %> selected="selected" <% } %>> 게 시 </option>
	<option value="n" <% if (isview.equals("n")) { %> selected="selected" <% } %>> 미 게 시 </option>
</select>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
결제 여부 :  <select name="pay" >
	<option value=""> 선 택 </option>
	<option value="y" <% if (pay.equals("y")) { %> selected="selected" <% } %>> 게 시 </option>
	<option value="n" <% if (pay.equals("n")) { %> selected="selected" <% } %>> 미 게 시 </option>
</select>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="검색" class="btn" onclick="makeSch();" />	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="검색초기화" class="btn resetSch" onclick="resetSch();" />
</fieldset>
</form>
</td></tr>
</table>
<table align="center" width="1100" cellpadding="0" cellspacing="0" id="gqnaListBox">
<tr align="center">
<th height="45" width="5%">번호</th>
<th width="15%">단체명</th>
<th width="*">제목</th>
<th width="10%">작성자</th>
<th width="15%">작성일</th>
<th width="10%">답변여부</th>
<th width="10%">결제여부</th>
<th width="10%">게시여부</th>
</tr>
<%
if(gql.size() > 0) {
	int num = rcnt - (psize * (cpage - 1));
	for (int i = 0; i < gql.size(); i++) {
		GQnaInfo gqi = gql.get(i);
%>
<tr align="center" height="45" onmouseover="this.bgColor='#cfcfcf';" onmouseout="this.bgColor='';">
<td><%=num %></td>
<td><%=gqi.getGq_gname() %></td>
<td onclick="clickEvt(<%=i %>)" class="hand" align="left">&nbsp;&nbsp;<%=gqi.getGq_title() %></td>
<td><%=gqi.getMi_id() %></td>
<td><%=gqi.getGq_date().substring(0, 10) %></td>
<td>
<% if (gqi.getGq_isreply().equals("y")) { %>
답변 완료
<% } else { %>
<select name="answer" onchange="gqnaUp('a', this.value, <%=gqi.getGq_idx() %>)">
	<option value="y" <% if (gqi.getGq_isreply().equals("y")) { %> selected="selected" <% } %>>답 변 완 료</option>
	<option value="n" <% if (gqi.getGq_isreply().equals("n")) { %> selected="selected" <% } %>>미 답 변</option>
</select>
<% } %>
</td>
<td>
<% if (gqi.getGq_pay().equals("y")) { %>
결제 완료
<% } else { %>
<select name="pay" onchange="gqnaUp('p', this.value, <%=gqi.getGq_idx() %>)">
	<option value="y" <% if (gqi.getGq_pay().equals("y")) { %> selected="selected" <% } %>>결 제 완 료</option>
	<option value="n" <% if (gqi.getGq_pay().equals("n")) { %> selected="selected" <% } %>>미 결 제</option>
</select>
<% } %>
</td>
<td>
<select name="isview" onchange="gqnaUp('i', this.value, <%=gqi.getGq_idx() %>)">
	<option value="y" <% if (gqi.getGq_isview().equals("y")) { %> selected="selected" <% } %>>게 시</option>
	<option value="n" <% if (gqi.getGq_isview().equals("n")) { %> selected="selected" <% } %>>미 게 시</option>
</select>
</td>
</tr>
<%	
	num--;
	}
%>
</table>
<%
	for (int i = 0; i < gql.size(); i++) {
		GQnaInfo gqi = gql.get(i);
%>
<div id="gqnaInfo<%=i %>" class="gqnaInfo">
<img src="/cworld_admin/img/ico_x.png" width="35" height="35" class="icoX hand" onclick="closeDiv(<%=i %>);"/>
<br />
<table width="800" cellspacing="0" cellpadding="0" class="gqnaInfoBox">
<caption style="font-size:25px; font-weight:bold;">문 의 상 세 보 기</caption>
<tr height="45">
<th width="20%">작성자</th>
<td  width="30%"><%=gqi.getMi_id() %></td>
<th  width="20%">작성일</th>
<td  width="*"><%=gqi.getGq_date() %></td>
</tr>
<tr height="45">
<th>단체명</th>
<td><%=gqi.getGq_gname() %></td>
<th>작성자 아이피</th>
<td><%=gqi.getGq_ip() %></td>
</tr>
<tr height="45">
<th>연락처</th>
<td><%=gqi.getGq_phone() %></td>
<th>이메일 & 팩스</th>
<td><%=gqi.getGq_ef() %></td>
</tr>
<tr height="45">
<th>제목</th>
<td colspan="3" align="left"><%=gqi.getGq_title() %></td>
</tr>
<tr height="45">
<th>내용</th>
<td colspan="3" align="left"><%=gqi.getGq_content().replaceAll("\r\n", "<br />") %></td>
</tr>
</table>
<br />
</div>
<%
	}
} else {
	out.println("<tr height='45'><td colspan='8' align='center'>검색 조건에 맞는 게시글이 없습니다.</td></tr></table>");
}
%>
<p align="center" style="width:1100px; margin:0 auto;">
<%
	if (rcnt > 0) { 	// 게시글이 있으면 - 페이징 영역을 보여줌
		if (cpage == 1) {
			out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
		} else {
			out.println("<a href='g_qna_list?cpage=1" + sargs + "'>[처음]</a>&nbsp;&nbsp;&nbsp;<a href='g_qna_list?cpage=" + (cpage - 1) + sargs + "'>[이전]</a>&nbsp;&nbsp;");
		}
		spage = (cpage - 1) / bsize * bsize + 1; 		// 현재 블록에서의 시작 페이지 번호
		for (int k = 1, j = spage; k <= bsize && j <= pcnt; k++, j++) {
			if (cpage == j) {
				out.println("&nbsp;<strong>" + j + "</strong>");
			} else {
				out.println("&nbsp;<a href='g_qna_list?cpage=" + j + sargs + "'>" + j + "</a>");
			}	
		}
		if (cpage == pcnt) {
			out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
		} else {
			out.println("<a href='g_qna_list?cpage=" + (cpage + 1) + sargs + "'>&nbsp;&nbsp;[다음]</a><a href='g_qna_list?cpage=" + pcnt + sargs + "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
		}
	}

%>
</p>
</body>
</html>