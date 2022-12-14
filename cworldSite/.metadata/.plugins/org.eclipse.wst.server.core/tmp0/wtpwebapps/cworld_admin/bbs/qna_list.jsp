<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
ArrayList<QnaInfo> qnaList = (ArrayList<QnaInfo>)request.getAttribute("qnaList");

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

String uid = "", ctgr = "", answer = "", sd = "", ed = "", isview = "";
if (sch != null && !sch.equals("")) {
	//  &sch=itest,ca,ay,r2022-10-04:2022-10-06	작성자, 분류, 답변여부, 기간
	String[] arrSch = sch.split(",");
	for (int i = 0; i < arrSch.length; i++) {
		char c = arrSch[i].charAt(0);
		if (c == 'i') {
			uid = arrSch[i].substring(1);
		} else if (c == 'c') {
			ctgr = arrSch[i].substring(1); 
		} else if (c == 'a') {
			answer = arrSch[i].substring(1); 
		} else if (c == 'r') {
			sd = arrSch[i].substring(1, arrSch[i].indexOf(':'));
			ed = arrSch[i].substring(arrSch[i].indexOf(':') + 1);	
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
.qnaInfo { 
	width:800px; height:700px; position:absolute; text-align:center; margin:-350px 0 0 -400px;
	background:white; color:black; display:none; border:1px black solid;
	top:50%; left:50%;
}
a { text-decoration:none; color:black; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:none; color:black; }
.icoX { position:absolute; top:15px; right:15px; }
#qnaListBox th, #qnaListBox td { border-bottom:1px black solid; border-collapse:collapse; }

.qnaInfoBox { 
	border-collapse:collapse; border-bottom:1px solid black; border-right:1px solid black;
	border-top:1px solid black; border-left:1px solid black;
 }
.qnaInfoBox th, .qnaInfoBox td { padding:8px 3px; }
</style>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script> 
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> 
<script>
$(document).ready(function() {
	$.datepicker.regional['ko'] = {
		closeText: '닫기',
		prevText: '이전달',
		nextText: '다음달',
		currentText: '오늘',
		monthNames: ['1월','2월','3월','4월','5월','6월',
		'7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월',
		'7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		//buttonImage: "/images/kr/create/btn_calendar.gif",
		buttonImageOnly: true,
		// showOn :"both",
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd',
		firstDay: 0,
		isRTL: false,
		duration:200,
		showAnim:'show',
		showMonthAfterYear: false
		// yearSuffix: '년'
	};
	$.datepicker.setDefaults($.datepicker.regional['ko']);

	$( "#edusdate" ).datepicker({
		//defaultDate: "+1w",
		changeMonth: true,
		//numberOfMonths: 3,
		dateFormat:"yy-mm-dd",
		onClose: function( selectedDate ) {
			//$( "#eday" ).datepicker( "option", "minDate", selectedDate );
		}
	});
	$( "#eduedate" ).datepicker({
		//defaultDate: "+1w",
		changeMonth: true,
		//numberOfMonths: 3,
		dateFormat:"yy-mm-dd",
		onClose: function( selectedDate ) {
			//$( "#sday" ).datepicker( "option", "maxDate", selectedDate );
		}
	});
});


function makeSch() {
	// &sch=itest,ca,ay,r2022-10-04:2022-10-06	작성자, 분류, 답변여부, 기간
	var frmQ = document.qnaFrm;
	var frm = document.frmHidden;
	var sch = "";
	var uid = frmQ.uid.value;
	if (uid != "") {
		sch += "i" + uid;
	}
	var ctgr = frmQ.ctgr.value;
	if (ctgr != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "c" + ctgr;
	}
	var answer = frmQ.answer.value;
	if (answer != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "a" + answer;
	}
	var sd = frmQ.sd.value;
	var ed = frmQ.ed.value;
	
	if (sd != "" || ed != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "r" + sd + ":" + ed;
	}
	var isview = frmQ.isview.value;
	if (isview != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "v" + isview;
	}
	
	frm.sch.value = sch;
	frm.submit();
}

function clickEvt(i) {
	var qna = "qnaInfo" + i;
	document.getElementById(qna).style.display = "block";
	
}
function closeDiv(i) {
	var qna = "qnaInfo" + i;
	document.getElementById(qna).style.display = "none";
}
function qnaUp(is, idx) {
	$.ajax({
		type : "POST",				
		url : "/cworld_admin/qnaUp",		
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
<caption style="text-align:left; font-size:25px; font-weight:bold;">1:1 문의 목록</caption>
<tr><td>
<form name="frmHidden">
	<input type="hidden" name="sch" value="<%=sch %>" />
</form>
<form name="qnaFrm" id="schFrm">
<fieldset style="width:1100px; text-align:center;">
<legend class="title"> 검 색 조 건 </legend>
아이디 : <input type="text" name="uid" value="<%=uid %>" size="5" />
질문 분류 : 
<select name="ctgr" >
	<option value=""> 선 택 </option>
	<option value="a" <% if (ctgr.equals("a")) { %> selected="selected" <% } %>> 회 원 관 련 </option>
	<option value="b" <% if (ctgr.equals("b")) { %> selected="selected" <% } %>> 상 품 관 련 </option>
	<option value="c" <% if (ctgr.equals("c")) { %> selected="selected" <% } %>> 결 제 관 련 </option>
	<option value="d" <% if (ctgr.equals("d")) { %> selected="selected" <% } %>> 기 타 </option>
</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
질문일 : 
<input type="text" name="sd" id="edusdate" value="<%=sd %>" size="10" class="ipt" /> ~
<input type="text" name="ed" id="eduedate" value="<%=ed %>" size="10" class="ipt" />
<br /><br />
답변 여부 :  <select name="answer" >
	<option value=""> 선 택 </option>
	<option value="y" <% if (answer.equals("y")) { %> selected="selected" <% } %>> 답변 완료 </option>
	<option value="n" <% if (answer.equals("n")) { %> selected="selected" <% } %>> 미 답 변 </option>
</select>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
게시 여부 :  <select name="isview" >
	<option value=""> 선 택 </option>
	<option value="y" <% if (isview.equals("y")) { %> selected="selected" <% } %>> 게 시 </option>
	<option value="n" <% if (isview.equals("n")) { %> selected="selected" <% } %>> 미 게 시 </option>
</select>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="검색" class="btn" onclick="makeSch();" />	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="검색초기화" class="btn resetSch" onclick="resetSch();" />
</fieldset>
</form>
</td></tr>
</table>
<table align="center" width="1100" cellpadding="0" cellspacing="0" id="qnaListBox">
<tr align="center">
<th height="35" width="5%">번호</th>
<th width="10%">분류</th>
<th width="*" >제목</th>
<th width="10%">작성자</th>
<th width="20%">질문일</th>
<th width="10%">답변여부</th>
<th width="10%">게시여부</th>
</tr>
<%
if(qnaList.size() > 0) {
	int num = rcnt - (psize * (cpage - 1));
	for (int i = 0; i < qnaList.size(); i++) {
		QnaInfo qi = qnaList.get(i);
%>
<tr align="center" height="45"  onmouseover="this.bgColor='#cfcfcf';" onmouseout="this.bgColor='';" >
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
<td align="left" onclick="clickEvt(<%=i %>);" class="hand">&nbsp;&nbsp;&nbsp;<%=qi.getQl_title() %></td>
<td><%=qi.getMi_id() %></td>
<td><%=qi.getQl_qdate() %></td>
<td>
<% if (qi.getQl_isanswer().equals("y")) {%>
답변완료
<% } else { %>
미답변
<% } %>
</td>
<td>
<select name="isview" onchange="qnaUp(this.value, <%=qi.getQl_idx() %>)">
	<option value="y" <% if (qi.getQl_isview().equals("y")) { %> selected="selected" <% } %>>게 시</option>
	<option value="n" <% if (qi.getQl_isview().equals("n")) { %> selected="selected" <% } %>>미 게 시</option>
</select>
</td>
</tr>
<%	
	num--;
	}
%>
</table>
<%
	for (int i = 0; i < qnaList.size(); i++) {
		QnaInfo qi = qnaList.get(i);
%>
<div id="qnaInfo<%=i %>" class="qnaInfo">
<img src="/cworld_admin/img/ico_x.png" width="35" height="35" class="icoX hand" onclick="closeDiv(<%=i %>);"/>
<br />
<table width="800" cellspacing="0" cellpadding="0" class="qnaInfoBox">
<caption style="font-size:25px; font-weight:bold;">질 문 정 보</caption>
<tr height="45">
<th width="20%">작성자</th>
<td  width="20%"><%=qi.getMi_id() %></td>
<th  width="20%">작성일</th>
<td  width="*"><%=qi.getQl_qdate() %></td>
</tr>
<tr height="45">
<th>분류</th>
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
<th>작성자 아이피</th>
<td><%=qi.getQl_ip() %></td>
</tr>
<tr height="45">
<th>제목</th>
<td colspan="3" align="left"><%=qi.getQl_title() %></td>
</tr>
<tr height="45">
<th>내용</th>
<td colspan="3" align="left"><%=qi.getQl_content().replaceAll("\r\n", "<br />") %></td>
</tr>
<% if (qi.getQl_img() != null && !qi.getQl_img().equals("")) { %>
<tr height="100">
<th>첨부파일</th>
<td colspan="3" align="left"><img src="/cworld_admin/upload_qna/<%=qi.getQl_img() %>" width="90" height="90"/><%=qi.getQl_img() %></td>
</tr>
<% if (qi.getQl_satis() != null && !qi.getQl_satis().equals("")) { %>
<tr height="45">
<th>만족도 평가</th>
<td align="left" colspan="3">&nbsp;&nbsp;&nbsp;
<% if (qi.getQl_satis() != null && qi.getQl_satis().equals("a")) { %>
매우만족
<% } else if (qi.getQl_satis() != null && qi.getQl_satis().equals("b")) { %>
만족
<% } else if (qi.getQl_satis() != null && qi.getQl_satis().equals("c")) { %>
보통
<% } else if (qi.getQl_satis() != null && qi.getQl_satis().equals("d")) { %>
불만족
<% } else if (qi.getQl_satis() != null && qi.getQl_satis().equals("e")) { %>
매우불만족
<% } %>
</td>
</tr>
<% } %>
<% } %>
</table>

<br />
<form name="answerFrm" action="answer_qna" method="post">
<input type="hidden" name="aname" value="<%=loginInfo.getAi_name() %>" />
<input type="hidden" name="idx" value="<%=qi.getQl_idx() %>" />
<input type="hidden" name="sch" value="<%=sch %>" />
<table width="800" class="qnaInfoBox" cellspacing="0" cellpadding="0" border="1">
<caption style="font-size:20px; font-weight:bold;">
<% if (qi.getQl_isanswer().equals("y")) { %>답 변 내 용 <% } else { %>답 변 입 력 <% } %>
</caption>
<% if (qi.getQl_isanswer().equals("y")) { %>
<tr>
<th width="25%">작성자</th><td width="25%"><%=qi.getQl_ai_name() %></td>
<th width="25%">작성일</th><td width="25%"><%=qi.getQl_adate() %></td>
</tr>
<% } %>
<tr>
<th>내용</th>
<td width="*" colspan="3"  align="left">
<% if (qi.getQl_isanswer().equals("n")) { %><textarea name="ql_answer" style="width:650px; height:100px; resize:none;"></textarea> <% } %>
<% if (qi.getQl_isanswer().equals("y")) { out.println(qi.getQl_answer().replaceAll("\r\n", "<br />")); } %>
</td>
</tr>
<% if (qi.getQl_isanswer().equals("n")) { %><tr height="45"><td align="center" colspan="2"><input type="submit" name="qnaUp" value="등록"  /></td></tr><% } %>
</table>
</form>
</div>
<%
	}
} else {
	out.println("<tr height='45'><td colspan='7' align='center'>검색 조건에 맞는 게시글이 없습니다.</td></tr></table>");
}
%>
<p align="center" style="width:1100px; margin:0 auto;">
<%
	if (rcnt > 0) { 	// 게시글이 있으면 - 페이징 영역을 보여줌
		if (cpage == 1) {
			out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
		} else {
			out.println("<a href='qna_list?cpage=1" + sargs + "'>[처음]</a>&nbsp;&nbsp;&nbsp;<a href='qna_list?cpage=" + (cpage - 1) + sargs + "'>[이전]</a>&nbsp;&nbsp;");
		}
		spage = (cpage - 1) / bsize * bsize + 1; 		// 현재 블록에서의 시작 페이지 번호
		for (int k = 1, j = spage; k <= bsize && j <= pcnt; k++, j++) {
			if (cpage == j) {
				out.println("&nbsp;<strong>" + j + "</strong>");
			} else {
				out.println("&nbsp;<a href='qna_list?cpage=" + j + sargs + "'>" + j + "</a>");
			}	
		}
		if (cpage == pcnt) {
			out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
		} else {
			out.println("<a href='qna_list?cpage=" + (cpage + 1) + sargs + "'>&nbsp;&nbsp;[다음]</a><a href='qna_list?cpage=" + pcnt + sargs + "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
		}
	}

%>
</p>
</body>
</html>