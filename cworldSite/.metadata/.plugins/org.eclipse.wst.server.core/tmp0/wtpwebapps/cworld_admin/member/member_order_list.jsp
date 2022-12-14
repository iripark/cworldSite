<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
ArrayList<MemberOrderInfo> mol = (ArrayList<MemberOrderInfo>)request.getAttribute("memberOrderList");
ArrayList<PdtCtgrSmall> smallList = (ArrayList<PdtCtgrSmall>)request.getAttribute("smallList");

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

String uid = "", pcb = "", pcs = "", pname = "", payment = "", status = "";
if (sch != null && !sch.equals("")) {
	// &sch=utest1,bR,sR01,p텐트,ma		// 아이디u, 대분류(패키지, 대여, 판매)b, 소분류s, 상품명p, 결제방법m 
	String[] arrSch = sch.split(",");
	for (int i = 0; i < arrSch.length; i++) {
		char c = arrSch[i].charAt(0);
		if (c == 'u') {
			uid = arrSch[i].substring(1);
		} else if (c == 'b') {
			pcb = arrSch[i].substring(1); 
		} else if (c == 's') {
			pcs = arrSch[i].substring(1); 
		} else if (c == 'p') {
			pname = arrSch[i].substring(1); 
		} else if (c == 'm') {
			payment = arrSch[i].substring(1); 
		} else if (c == 't') {
			status = arrSch[i].substring(1); 
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
.title { text-align:left; }
.special { display:inline; width:20px; height:14px; }
a { text-decoration:none; color:black; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:none; color:black; }
#subnavi02 { display:block; }
#memberOrderListBox th, #memberOrderListBox td { border-bottom:1px black solid; border-collapse:collapse; }
</style>
<script>
var arrR = new Array();		// R 대분류의 소분류 목록을 저장할 배열
arrR[0] = new Option("", " 소분류 선택 ");
arrR[1] = new Option("R01", " 텐 트 ");
arrR[2] = new Option("R02", " 타 프 / 쉘 터 ");
arrR[3] = new Option("R03", " 침 구 ");
arrR[4] = new Option("R04", " 의 자 / 테 이 블 ");
arrR[5] = new Option("R05", " 화 기 용 품 ");
arrR[6] = new Option("R06", " 식 기 용 품 ");

var arrS = new Array();		// S 대분류의 소분류 목록을 저장할 배열
arrS[0] = new Option("", " 소분류 선택 ");
arrS[1] = new Option("S01", " 텐 트 ");
arrS[2] = new Option("S02", " 타 프 / 쉘 터 ");
arrS[3] = new Option("S03", " 침 구 ");
arrS[4] = new Option("S04", " 의 자 / 테 이 블 ");
arrS[5] = new Option("S05", " 화 기 용 품 ");
arrS[6] = new Option("S06", " 식 기 용 품 ");

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
function makeSch() {
// makeSch() 함수에서 만들 검색 문자열 : &sch=utest1,bR,sR01,p텐트,ma	아이디u, 대분류(패키지, 대여, 판매)b, 소분류s, 상품명p, 결제방법m 
	var frmS = document.frmSearch;
	var frm = document.frm;
	var sch = "";
	var uid = frmS.mi_id.value;
	if (uid != "") {
		sch += "n" + uid;
	}
	var pcb = frmS.pcb.value;
	if (pcb != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "b" + pcb;
	}
	var pcs = frmS.pcs.value;
	if (pcs != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "s" + pcs;
	}
	var pname = frmS.pname.value;
	if (pname != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "p" + pname;
	}
	var payment = frmS.payment.value;
	if (payment != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "m" + payment;
	}
	var status = frmS.status.value;
	if (status != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "t" + status;
	}
	frm.sch.value = sch;
	frm.submit();
}
function statusUpdate(frm, st) {
	var status = st.value;
	var oi_id = frm.oi_id.value;
	$.ajax({
		type : "POST",				
		url : "/cworld_admin/orderStatusUpdate",		
		data : {"status" : status, "oi_id" : oi_id},		
		success : function(chkRs) {	
			if (chkRs == 1) {		
				alert("배송 상태가 변경되었습니다.");
				location.reload();
			} else {				
				alert("배송상태 변경 실패");
			}
		}
	});
}
function resetSch() {
	var sch = "";
	var frm = document.frm;
	frm.sch.value = sch;
	frm.submit();
}
</script>
</head>
<body>
<table width="1000" id="memberOrderList" align="center">
<caption style="text-align:left; font-size:25px; font-weight:bold;">회 원 결 제 내 역</caption>
<tr>
<td width="*" valign="top">
<!-- 검색조건 입력폼 -->
	<form name="frm">
		<input type="hidden" name="sch" value="<%=sch %>" />
	</form>
	<form name="frmSearch" >
	<fieldset align="center" style="height:110px;  line-height:25px;">
	<legend style="line-height:15px;" class="title"> 검 색 조 건 </legend>
	분 류 선 택 : <select name="pcb" class="cata" onchange="setCategory(this.value, this.form.pcs);">
		<option value=""> 대분류 선택 </option>
		<option value="R" <% if (pcb != null && pcb.equals("R")) { %> selected="selected" <% } %>> 대 여 </option>
		<option value="S" <% if (pcb != null && pcb.equals("S")) { %> selected="selected" <% } %>> 판 매 </option>
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
	</select><br />
	결 제 방 법 : <select name="payment">
		<option value=""> 결제 방법 선택 </option>
		<option value="a" <% if (payment != null && payment.equals("a")) { %> selected="selected" <% } %>> 카 드 </option>
		<option value="b" <% if (payment != null && payment.equals("b")) { %> selected="selected" <% } %>> 휴대폰 결제 </option>
		<option value="c" <% if (payment != null && payment.equals("c")) { %> selected="selected" <% } %>> 무통장 입금 </option>
	</select>
	배 송 상 태 : <select name="status">
		<option value=""> 배송 상태 선택 </option>
		<option value="a" <% if (status != null && status.equals("a")) { %> selected="selected" <% } %>> 입 금 대 기 중 </option>
		<option value="b" <% if (status != null && status.equals("b")) { %> selected="selected" <% } %>> 상 품 준 비 중 </option>
		<option value="c" <% if (status != null && status.equals("c")) { %> selected="selected" <% } %>> 배 송 준 비 중 </option>
		<option value="d" <% if (status != null && status.equals("d")) { %> selected="selected" <% } %>> 배 송  중 </option>
		<option value="e" <% if (status != null && status.equals("e")) { %> selected="selected" <% } %>> 배 송 완 료 </option>
	</select>
	<br />
	회원 아이디 : 
	<input type="text" name="mi_id" id="mi_id" placeholder="회원명 검색" value="<%=uid %>" size="10"/>
	상 품 명 : 
	<input type="text" name="pname" id="pname" placeholder="상품명 검색" value="<%=pname %>" size="10"/>
	<input type="button" value="상품 검색" class="btn" onclick="makeSch();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="검색초기화" class="btn resetSch" onclick="resetSch();" />
	</fieldset>
	</form>
</td>
</tr>
</table>
<!-- 상품 목록 및 페이징 -->
<table width="1000" cellpadding="0" cellspacing="0" id="memberOrderListBox" align="center">
<tr height="45">
<th width="10%">주문번호</th>
<th width="10%">구매자</th>
<th width="25%">상품명</th>
<th width="10%">가격</th>
<th width="14%">결제방법</th>
<th width="14%">배송상태</th>
<th width="*">운송장번호</th>
</tr>
<%
if (rcnt > 0) {
	for (int i = 0; i < mol.size(); i++) {
		MemberOrderInfo moi = mol.get(i);
%>
<tr height="40" align="center">
<td><%=moi.getOi_id() %></td>
<td><%=moi.getMi_id() %></td>
<td align="left">&nbsp;&nbsp;<%=moi.getOd_pname() %></td>
<td><%=moi.getOi_pay() %></td>
<td>
<% if (moi.getOi_payment().equals("a")) { %> 
카 드
<% } else if (moi.getOi_payment().equals("b")) { %>
휴대폰 결제
<% } else if (moi.getOi_payment().equals("c")) { %>
무통장 입금
<% } %>
</td>
<td>
<form name="frmstatus<%=i %>">
<select name="status" onchange="statusUpdate(this.form, this);">
	<option value="a" <% if (moi.getOi_status().equals("a")) { %> selected="selected" <% } %>> 입 금 대 기 </option>
	<option value="b" <% if (moi.getOi_status().equals("b")) { %> selected="selected" <% } %>> 상 품 준 비 중 </option>
	<option value="c" <% if (moi.getOi_status().equals("c")) { %> selected="selected" <% } %>> 배 송 대 기 중 </option>
	<option value="d" <% if (moi.getOi_status().equals("d")) { %> selected="selected" <% } %>> 배 송 중 </option>
	<option value="e" <% if (moi.getOi_status().equals("e")) { %> selected="selected" <% } %>> 배 송 완 료 </option>
</select>
<input type="hidden" name="oi_id" value="<%=moi.getOi_id() %>" />
</form>
</td>
<td>
<%
if (moi.getOi_invoice() != null && !moi.getOi_invoice().equals("")) {
	out.println(moi.getOi_invoice());
}
%>
</td>
</tr>
<%
	}
} else {
	out.println("<tr height='45'><td colspan='7' align='center'>검색 결과가 없습니다.</td></tr>");
}
%>
</table>
<p style="width:1000px; text-align:center; margin:0 auto;" >
<%
if (rcnt > 0) { 	// 게시글이 있으면 - 페이징 영역을 보여줌
	if (cpage == 1) {
		out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
	} else {
		out.println("<a href='member_order_list?cpage=1" + sargs + "'>[처음]</a>&nbsp;&nbsp;&nbsp;<a href='member_order_list?cpage=" + (cpage - 1) + sargs + "'>[이전]</a>&nbsp;&nbsp;");
	}
	spage = (cpage - 1) / bsize * bsize + 1; 		// 현재 블록에서의 시작 페이지 번호
	for (int i = 1, j = spage; i <= bsize && j <= pcnt; i++, j++) {
		// i : 블록에서 보여줄 페이지의 개수만큼 루프를 돌릴 조건으로 사용되는 변수
		// j : 실제 출력한 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 사용해야 함
		if (cpage == j) {
			out.println("&nbsp;<strong>" + j + "</strong>");
		} else {
			out.println("&nbsp;<a href='member_order_list?cpage=" + j + sargs + "'>" + j + "</a>");
		}	
	}
	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
	} else {
		out.println("<a href='member_order_list?cpage=" + (cpage + 1) + sargs + "'>&nbsp;&nbsp;[다음]</a><a href='member_order_list?cpage=" + pcnt + sargs + "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
	}
}
%>
</p>
</body>
</html>