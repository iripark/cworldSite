<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
ArrayList<RentInfo> rentList = (ArrayList<RentInfo>)request.getAttribute("rentList");
ArrayList<PdtCtgrSmall> smallList = (ArrayList<PdtCtgrSmall>)request.getAttribute("smallList");
RentInfo ri = null;

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

String pcb = "", pcs = "", name = "", id = "";
String sd = "", ed = "", isR = "";
if (sch != null && !sch.equals("")) {
	// &sch=bR,sR01,p텐트,itest1,r2022-10-04:2022-10-06,ta
	String[] arrSch = sch.split(",");
	for (int i = 0; i < arrSch.length; i++) {
		char c = arrSch[i].charAt(0);
		if (c == 'b') {
			pcb = arrSch[i].substring(1);
		} else if (c == 's') {
			pcs = arrSch[i].substring(1); 
		} else if (c == 'p') {
			name = arrSch[i].substring(1); 
		} else if (c == 'i') {
			id = arrSch[i].substring(1); 
		} else if (c == 'r') {
			sd = arrSch[i].substring(1, arrSch[i].indexOf(':'));
			ed = arrSch[i].substring(arrSch[i].indexOf(':') + 1);		
		} else if (c == 't') {
			isR = arrSch[i].substring(1); 
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
#subnavi01 { display:block; }
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
#rentBox th, #rentBox td { border-bottom:1px black solid; border-collapse:collapse; }
</style>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script> 
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> 
<script>
var arrR = new Array();		// R 대분류의 소분류 목록을 저장할 배열
arrR[0] = new Option("", " 소분류 선택 ");
arrR[1] = new Option("R01", " 텐 트 ");
arrR[2] = new Option("R02", " 타 프 / 쉘 터 ");
arrR[3] = new Option("R03", " 침 구 ");
arrR[4] = new Option("R04", " 의 자 / 테 이 블 ");
arrR[5] = new Option("R05", " 화 기 용 품 ");
arrR[6] = new Option("R06", " 식 기 용 품 ");

var arrP = new Array();		// P 대분류의 소분류 목록을 저장할 배열
arrP[0] = new Option("", " 소분류 선택 ");
arrP[1] = new Option("P00", " 패 키 지 ");
function setCategory(x, target) {
	for (var i = target.options.length - 1; i > 0; i--) {
		target.options[i] = null;
	} 
	if (x != "") {	
		var arr = eval("arr" + x);
		for (var i = 0; i < arr.length; i++) {
			target.options[i] = new Option(arr[i].value, arr[i].text);
		}		
		target.options[0].selected = true;
	}
}
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
	// &sch=bR,sR01,p텐트,itest1,r2022-10-04:2022-10-06,ta
	var frmM = document.memSchFrm;
	var frm = document.frmHidden;
	var sch = "";
	var pcb = frmM.pcb.value;
	if (pcb != "") {
		sch += "b" + pcb;
	}
	
	var pcs = frmM.pcs.value;
	if (pcs != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "s" + pcs;
	}
	var name = frmM.name.value;
	if (name != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "p" + name;
	}
	var id = frmM.id.value;
	if (id != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "i" + id;
	}
	var sd = frmM.sd.value;
	var ed = frmM.ed.value;
	if (sd != "" || ed != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "r" + sd + ":" + ed;
	}
	var isR = frmM.isR.value;
	if (isR != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "t" + isR;
	}
		
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
function isReturnUp(frm, isReturn) {
	var isReturn = isReturn.value;
	var ord_idx = frm.ord_idx.value;
	var cnt = frm.ord_cnt.value;
	var psidx = frm.ps_idx.value;
	$.ajax({
		type : "POST",				
		url : "/cworld_admin/isRturnUpdate",		
		data : {"isReturn" : isReturn, "ord_idx" : ord_idx, "cnt" : cnt, "psidx" : psidx},		
		success : function(chkRs) {	
			if (chkRs == 1) {		
				alert("대여 상태가 변경되었습니다.");
			} else if(chkRs == 0 && isReturn == 'b') {				
				alert("대여 시작일이 아직 지나지 않았습니다.");
				location.reload();
			} else if((chkRs == 0 && isReturn == 'c') || (chkRs == 0 && isReturn == 'd')) {				
				alert("대여 종료일이 아직 지나지 않았습니다.");
				location.reload();
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
<table width="1000" align="center">
<caption style="text-align:left; font-size:25px; font-weight:bold;">대 여 물 품 관 리</caption>
<tr><td>
<form name="frmHidden">
	<input type="hidden" name="sch" value="<%=sch %>" />
</form>
<form name="memSchFrm" id="schFrm">
<fieldset style="text-align:center; height:110px;  line-height:25px;">
<legend class="title"> 검 색 조 건 </legend>
	분 류 선 택 : 
	<select name="pcb" class="cata" onchange="setCategory(this.value, this.form.pcs);">
		<option value=""> 대분류 선택 </option>
		<option value="R" <% if (pcb != null && pcb.equals("R")) { %> selected="selected" <% } %>> 대 여 </option>
		<option value="P" <% if (pcb != null && pcb.equals("P")) { %> selected="selected" <% } %>> 패 키 지 </option>
	</select>
	<select name="pcs" class="cata" >
		<option value=""> 소분류 선택 </option>
<% if (pcb != null && !pcb.equals("")) { 
	for (int i = 0; i < smallList.size(); i++) {
		PdtCtgrSmall ps = smallList.get(i);
%>
		<option value="<%=ps.getPcs_id() %>" <%if (pcs != null && pcs.equals(ps.getPcs_id())) { %> selected="selected" <% } %>><%=ps.getPcs_name() %></option>
<%
	}
} 
%>
	</select>&nbsp;
	반 납 여 부 :
	<select name="isR"> 
		<option value=""> 반 납 여 부 </option>
		<option value="a" <% if (isR.equals("a")) { %> selected="selected" <% } %>> 대 여 예 정 </option>
		<option value="b" <% if (isR.equals("b")) { %> selected="selected" <% } %>> 대 여 중 </option>
		<option value="c" <% if (isR.equals("c")) { %> selected="selected" <% } %>> 반 납 완 료 </option>
		<option value="d" <% if (isR.equals("d")) { %> selected="selected" <% } %>> 기간내 미반납 </option>
	</select>
	<br />
	상 품 명 : 
	<input type="text" name="name" id="pi_name" placeholder="상품명 검색" value="<%=name %>" />
	회원아이디 : 
	<input type="text" name="id" id="mi_id" placeholder="회원 아이디 검색" value="<%=id %>" /><br/>
	대여 기간 : 
<input type="text" name="sd" id="edusdate" value="<%=sd %>" size="10" class="ipt" /> ~
<input type="text" name="ed" id="eduedate" value="<%=ed %>" size="10" class="ipt" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="상품 검색" class="btn" onclick="makeSch();" />	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="검색초기화" class="btn resetSch" onclick="resetSch();" />
</fieldset>
</form>
</td></tr>
</table>
<table align="center" width="1000" cellpadding="0" cellspacing="0" id="rentBox">
<tr>
<th height="35" width="7%">상품코드</th><th width="10%">사진</th><th width="13%">상품명</th><th width="10%">회원아이디</th><th width="30%">대여기간</th><th width="5%">수량</th><th width="15%">대여상태</th><th width="*">기능</th>
</tr>
<%
if(rentList.size() > 0) {
	for (int i = 0; i < rentList.size(); i++) {
		ri = rentList.get(i);
		MemberInfo mi = ri.getMemberInfo();
%>
<tr align="center" onmouseover="this.bgColor='#cfcfcf';" onmouseout="this.bgColor='';">
<td height="35" ><%=ri.getPi_id() %></td>
<td><img src="/cworld_admin/pdt_img/<%=ri.getOrd_pimg() %>" width="80" height="80"/></td>
<td align="left"><%=ri.getOrd_pname() %></td>
<td><%=ri.getMi_id() %></td>
<td><%=ri.getOrd_sdate().substring(0, 10) %> ~ <%=ri.getOrd_edate().substring(0, 10) %></td>
<td><%=ri.getOrd_cnt() %></td>

<td>
<form name="reFrm">
<select name="isReturn" onchange="isReturnUp(this.form, this);">
	<option value="a" <% if (ri.getOrd_isreturn().equals("a")) { %> selected="selected" <% } %>> 대 여 예 정 </option>
	<option value="b" <% if (ri.getOrd_isreturn().equals("b")) { %> selected="selected" <% } %>> 대 여 중 </option>
	<option value="c" <% if (ri.getOrd_isreturn().equals("c")) { %> selected="selected" <% } %>> 반 납 완 료 </option>
	<option value="d" <% if (ri.getOrd_isreturn().equals("d")) { %> selected="selected" <% } %>> 기간내 미반납 </option>
</select>
<input type="hidden" name="ord_idx" value="<%=ri.getOrd_idx() %>" />
<input type="hidden" name="ord_cnt" value="<%=ri.getOrd_cnt() %>" />
<input type="hidden" name="ps_idx" value="<%=ri.getPs_idx() %>" />
</form>
</td>
<td>
<input type="button" value="회원정보" name="info<%=i %>" onclick="clickEvt(<%=i %>);" />
</td>
</tr>
<%
		if (i == rentList.size() - 1) {
			out.println("</table>");
		}
	}
	for (int i = 0; i < rentList.size(); i++) {
		ri = rentList.get(i);
		MemberInfo mi = ri.getMemberInfo();
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
		<th height="30">포인트</th><td><%=mi.getMi_point() %></td><th>접속횟수</th><td><%=mi.getMi_visited() %></td>
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
			out.println("<a href='rent_list?cpage=1" + sargs + "'>[처음]</a>&nbsp;&nbsp;&nbsp;<a href='rent_list?cpage=" + (cpage - 1) + sargs + "'>[이전]</a>&nbsp;&nbsp;");
		}
		spage = (cpage - 1) / bsize * bsize + 1; 		// 현재 블록에서의 시작 페이지 번호
		for (int k = 1, j = spage; k <= bsize && j <= pcnt; k++, j++) {
			if (cpage == j) {
				out.println("&nbsp;<strong>" + j + "</strong>");
			} else {
				out.println("&nbsp;<a href='rent_list?cpage=" + j + sargs + "'>" + j + "</a>");
			}	
		}
		if (cpage == pcnt) {
			out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
		} else {
			out.println("<a href='rent_list?cpage=" + (cpage + 1) + sargs + "'>&nbsp;&nbsp;[다음]</a><a href='rent_list?cpage=" + pcnt + sargs + "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
		}
	}
} else {
	out.println("<tr height='45'><td colspan='11' align='center'>대여 목록이 없습니다.</td></tr></table>");
}
%>
</p>
</body>
</html>