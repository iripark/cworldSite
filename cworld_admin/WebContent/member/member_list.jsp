<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
ArrayList<MemberInfo> memberList = (ArrayList<MemberInfo>)request.getAttribute("memberList");
MemberInfo mi = null;

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

String status = "", gender = "", age = "", last = "";
String name = "", event = "", sj = "", ej = "";
if (sch != null && !sch.equals("")) {
	// &sch=sa,gm,a20,d180,n홍길동,en,j2022-10-10:2022-10-20
	String[] arrSch = sch.split(",");
	for (int i = 0; i < arrSch.length; i++) {
		char c = arrSch[i].charAt(0);
		if (c == 's') {
			status = arrSch[i].substring(1);
		} else if (c == 'g') {
			gender = arrSch[i].substring(1); 
		} else if (c == 'a') {
			age = arrSch[i].substring(1); 
		} else if (c == 'd') {
			last = arrSch[i].substring(1); 
		} else if (c == 'n') {
			name = arrSch[i].substring(1); 
		} else if (c == 'e') {
			event = arrSch[i].substring(1); 
		} else if (c == 'j') {
			sj = arrSch[i].substring(1, arrSch[i].indexOf(':'));
			ej = arrSch[i].substring(arrSch[i].indexOf(':') + 1);		
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
#subnavi02 { display:block; }
#schFrm { text-align:center; }
.title { text-align:left; }
.memInfo { 
	width:800px; height:700px; position:absolute; text-align:center; margin:-400px 0 0 -350px;
	background:white; color:black; display:none; border:1px black solid;
	top:50%; left:50%;
}
a { text-decoration:none; color:black; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:none; color:black; }
.icoX { position:absolute; top:15px; right:15px; }
#lastBox th, #lastBox td { border-bottom:1px black solid; border-collapse:collapse; }
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
	// &sch=sa,gm,a20,d180,n홍길동,en,j2022-10-10:2022-10-20
	var frmM = document.memSchFrm;
	var frm = document.frmHidden;
	var sch = "";
	var status = frmM.status.value;
	if (status != "") {
		sch += "s" + status;
	}
	
	var gender = frmM.gender.value;
	if (gender != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "g" + gender;
	}
	var age = frmM.age.value;
	if (age != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "a" + age;
	}
	var last = frmM.last.value;
	if (last != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "d" + last;
	}
	var name = frmM.name.value;
	if (name != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "n" + name;
	}
	
	var event = frmM.event.value;
	if (event != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "e" + event;
	}
	var sj = frmM.sj.value;
	var ej = frmM.ej.value;
	
	if (sj != "" || ej != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "j" + sj + ":" + ej;
	}
	
	frm.sch.value = sch;
	frm.submit();
}
function resetSch() {
	var sch = "";
	var frm = document.frmHidden;
	frm.sch.value = sch;
	frm.submit();
}
function clickEvt(i) {
	//document.getElementById("memInfo").style.display = "block";
	//var arrI = document.getElementByClassName("memInfo");
	var mem = "memInfo" + i;
	document.getElementById(mem).style.display = "block";
	
}
function closeDiv(i) {
	//document.getElementById("memInfo").style.display = "none";
	//var arrI = document.getElementByClassName("memInfo");
	var mem = "memInfo" + i;
	document.getElementById(mem).style.display = "none";
} 
function memberPointUpdate(miid, i) {
	if(confirm("해당 회원의 포인트를 변경하시겠습니까?")) {
		var mp = "miPointUp" + i;
		var point = document.getElementById(mp).value;
		$.ajax({
			type : "POST",				
			url : "/cworld_admin/memberPointUpdate",		
			data : {"miid" : miid, "point" : point},		
			success : function(chkRs) {	
				if (chkRs == 1) {		
					alert("포인트 변경 완료!");
					location.reload();
				} else {				
					alert("포인트 변경 실패");
				}
			}
		});
	}
}
function memberExit(miid) {
	if(confirm("해당 회원을 탈퇴 처리하시겠습니까?")) {
		$.ajax({
			type : "POST",				
			url : "/cworld_admin/memberExitUpdate",		
			data : {"miid" : miid},		
			success : function(chkRs) {	
				if (chkRs == 1) {		
					alert("탈퇴 처리 완료!");
					location.reload();
				} else {				
					alert("탈퇴 처리 실패");
				}
			}
		});
	}
}
</script>
</head>
<body>
<table width="1100" align="center">
<caption style="text-align:left; font-size:25px; font-weight:bold;">회 원 목 록</caption>
<tr><td>
<form name="frmHidden">
	<input type="hidden" name="sch" value="<%=sch %>" />
</form>
<form name="memSchFrm" id="schFrm">

<fieldset style="width:1100px; text-align:center;">
<legend class="title"> 검 색 조 건 </legend>
이름 : <input type="text" name="name" value="<%=name %>" size="5" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 나이 : <input type="text" name="age" value="<%=age %>" size="2" onkeyup="onlyNum(this);"/>살 이상
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;성별 : 
<select name="gender" >
	<option value=""> 선 택 </option>
	<option value="m" <% if (gender.equals("m")) { %> selected="selected" <% } %>> 남 자 </option>
	<option value="f" <% if (gender.equals("f")) { %> selected="selected" <% } %>> 여 자 </option>
</select><br /><br />
광고성메일 수신 여부 : 
<select name="event" >
	<option value=""> 선 택 </option>
	<option value="y" <% if (event.equals("y")) { %> selected="selected" <% } %>> 동 의 </option>
	<option value="n" <% if (event.equals("n")) { %> selected="selected" <% } %>> 미 동 의 </option>
</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
최종로그인 : <select name="last" >
	<option value=""> 선 택 </option>
	<option value="30" <% if (last.equals("30")) { %> selected="selected" <% } %>> 1 개 월 </option>
	<option value="60" <% if (last.equals("60")) { %> selected="selected" <% } %>> 2 개 월 </option>
	<option value="90" <% if (last.equals("90")) { %> selected="selected" <% } %>> 3 개 월 </option>
	<option value="120" <% if (last.equals("120")) { %> selected="selected" <% } %>> 4 개 월 </option>
	<option value="150" <% if (last.equals("150")) { %> selected="selected" <% } %>> 5 개 월 </option>
	<option value="180" <% if (last.equals("180")) { %> selected="selected" <% } %>> 6 개 월 </option>
</select><br /><br />가입일 : 
<input type="text" name="sj" id="edusdate" value="<%=sj %>" size="10" class="ipt" /> ~
<input type="text" name="ej" id="eduedate" value="<%=ej %>" size="10" class="ipt" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
상태 : <select name="status" >
	<option value=""> 선 택 </option>
	<option value="a" <% if (status.equals("a")) { %> selected="selected" <% } %>> 정 상 </option>
	<option value="b" <% if (status.equals("b")) { %> selected="selected" <% } %>> 휴 면 </option>
	<option value="c" <% if (status.equals("c")) { %> selected="selected" <% } %>> 탈 퇴 </option>
</select>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="회원 검색" class="btn" onclick="makeSch();" />&nbsp;&nbsp;&nbsp;	
<input type="button" value="검색초기화" class="btn resetSch" onclick="resetSch();" />
</fieldset>
</form>
</td></tr>
</table>
<table align="center" width="1100" cellpadding="0" cellspacing="0" id="lastBox">
<caption class="title">총 <%=rcnt %> 명</caption>
<tr>
<th height="45" width="7%">아이디</th><th width="7%">이름</th><th width="10%">생년월일</th><th width="6%">성별</th>
<th width="15%">메일주소</th><th width="20%">전화번호</th><th width="10%">가입일</th><th width="10%">최종로그인</th>
<th width="6%">상태</th><th width="*">광고수신여부</th>
</tr>
<%
if(memberList.size() > 0) {
	for (int i = 0; i < memberList.size(); i++) {
		mi = memberList.get(i);
		ArrayList<AddrInfo> al = mi.getAddrList();
%>
<tr align="center" onclick="clickEvt(<%=i %>);" onmouseover="this.bgColor='#cfcfcf';" onmouseout="this.bgColor='';" class="hand">
<td height="45" ><%=mi.getMi_id() %></td>
<td ><%=mi.getMi_name() %></td>
<td ><%=mi.getMi_birth() %></td>
<td ><% if(mi.getMi_gender().equals("f")) { %>
여자 
<% } else { %>
남자	
<% } %></td>
<td ><%=mi.getMi_mail() %></td>
<td ><%=mi.getMi_phone() %></td>
<td><%=mi.getMi_join().substring(0, 10) %></td>
<td  ><%=mi.getMi_last().substring(0, 10) %></td>
<td ><% if(mi.getMi_status().equals("a")) { %>
정상
<% } else if (mi.getMi_status().equals("b")) { %>
휴면	
<% } else {%>
탈퇴
<% } %>
</td>
<td>
<% if(mi.getMi_adv().equals("y")) { %>
동의
<% } else { %>
미동의	
<% } %>
</td>
</tr>
<%
		if (i == memberList.size() - 1) {
			out.println("</table>");
		}
	}
	for (int i = 0; i < memberList.size(); i++) {
		mi = memberList.get(i);
		ArrayList<AddrInfo> al = mi.getAddrList();
%>
		<div id="memInfo<%=i %>" class="memInfo">
		<img src="/cworld_admin/img/ico_x.png" width="35" height="35" class="icoX hand" onclick="closeDiv(<%=i %>);"/>
		<br />
		<table width="800">
		<caption style="font-size:25px; font-weight:bold;">상 세 정 보</caption>
		<tr>
		<th width="20%" height="30">이름</th><td width="30%"><%=mi.getMi_name() %></td>
		<th width="20%">아이디</th><td width="30%" id="id"><%=mi.getMi_id() %></td>
		</tr>
		<tr>
		<th height="30">생년월일</th><td><%=mi.getMi_birth() %></td>
		<th>성별</th>
		<td>
		<% if(mi.getMi_gender().equals("f")) { %>
		여자 
		<% } else { %>
		남자	
		<% } %>
		</td>
		</tr>
		<tr>
		<th height="30">이메일</th><td><%=mi.getMi_mail() %></td><th>전화번호</th><td><%=mi.getMi_phone() %></td>
		</tr>
		<tr>
		<th height="30">포인트</th><td align="center"><input type="text" value="<%=mi.getMi_point() %>" name="point" id="miPointUp<%=i %>" style="border:none;" size="6"/><input type="button" value="수정" onclick="memberPointUpdate('<%=mi.getMi_id() %>', <%=i %>);"/></td><th>접속횟수</th><td><%=mi.getMi_visited() %></td>
		</tr>
		<tr>
		<th height="30">가입일</th><td><%=mi.getMi_join() %></td><th>최종로그인</th><td><%=mi.getMi_last() %></td>
		</tr>
		<tr>
		<th height="30">상태</th>
		<td>
		<% if(mi.getMi_status().equals("a")) { %>
		정상
		<% } else if (mi.getMi_status().equals("b")) { %>
		휴면	
		<% } else {%>
		탈퇴
		<% } %></td>
		<th>광고수신</th>
		<td>
		<% if(mi.getMi_adv().equals("y")) { %>
		동의
		<% } else { %>
		미동의	
		<% } %>
		</td>
		</tr>
		<tr><td colspan="4" align="right"><% if(mi.getMi_status().equals("a") || mi.getMi_status().equals("b")) { %><input type="button" value="탈퇴 처리" onclick="memberExit('<%=mi.getMi_id() %>');" /><% } %></td></tr>
		<tr><td colspan="4">
		<br /><br /><br />
		<table width="100%" class="addrBox" cellspacing="0" cellpadding="0">
		<cation style="font-size:20px; font-weight:bold;">배송지 등록 현황</cation>
		<tr>
		<th height="30">배송지명</th><th>받는사람명</th><th>전화번호</th><th>우편번호</th><th>기본주소</th><th>상세주소</th><th>기본배송지</th>
		</tr>
		<%
				if (al.size() > 0) {
					for (int j = 0; j < al.size(); j++) {
						AddrInfo addr = al.get(j);
		%>
			<tr>
			<td height="30"><%=addr.getMa_name() %></td>
			<td><%=addr.getMa_receiver() %></td>
			<td><%=addr.getMa_phone() %></td>
			<td><%=addr.getMa_zip() %></td>
			<td><%=addr.getMa_addr1() %></td>
			<td><%=addr.getMa_addr2() %></td>
			<td><%=addr.getMa_basic() %></td>
			</tr>
		<%
					}
				} else {
					out.println("<tr><td colspan='7' align='center'>등록된 배송지가 없습니다.</td></tr>");
				}
		%>
		</table>
		</td></tr>
		</table>
		</div>
<%
	}
%>
<p align="center" style="width:1100px; margin:0 auto;">
<%
	if (rcnt > 0) { 	// 게시글이 있으면 - 페이징 영역을 보여줌
		if (cpage == 1) {
			out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
		} else {
			out.println("<a href='member_list?cpage=1" + sargs + "'>[처음]</a>&nbsp;&nbsp;&nbsp;<a href='member_list?cpage=" + (cpage - 1) + sargs + "'>[이전]</a>&nbsp;&nbsp;");
		}
		spage = (cpage - 1) / bsize * bsize + 1; 		// 현재 블록에서의 시작 페이지 번호
		for (int k = 1, j = spage; k <= bsize && j <= pcnt; k++, j++) {
			if (cpage == j) {
				out.println("&nbsp;<strong>" + j + "</strong>");
			} else {
				out.println("&nbsp;<a href='member_list?cpage=" + j + sargs + "'>" + j + "</a>");
			}	
		}
		if (cpage == pcnt) {
			out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
		} else {
			out.println("<a href='member_list?cpage=" + (cpage + 1) + sargs + "'>&nbsp;&nbsp;[다음]</a><a href='member_list?cpage=" + pcnt + sargs + "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
		}
	}
} else {
	out.println("<tr height='45'><td colspan='11' align='center'>회원이 없습니다.</td></tr></table>");
}
%>
</p>
</body>
</html>