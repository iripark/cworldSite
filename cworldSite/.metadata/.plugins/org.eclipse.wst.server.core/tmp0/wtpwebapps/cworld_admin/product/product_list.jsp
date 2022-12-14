<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
ArrayList<ProductInfo> productList = (ArrayList<ProductInfo>)request.getAttribute("productList");
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

String name = "", special = "", hs = "", pcb = "", pcs = "", isview = "";
if (sch != null && !sch.equals("")) {
	// 검색조건 예시 :  &sch=sbest,ntest,c101
	String[] arrSch = sch.split(",");
	for (int i = 0; i < arrSch.length; i++) {
		char c = arrSch[i].charAt(0);
		if (c == 's') {
			special = arrSch[i].substring(1);
		} else if (c == 'n') {
			name = arrSch[i].substring(1); 
		} else if (c == 'b') {
			pcb = arrSch[i].substring(1); 
		} else if (c == 'h') {
			hs = arrSch[i].substring(1); 
		} else if (c == 'i') {
			isview = arrSch[i].substring(1); 
		} else if (c == 'm') {
			pcs = arrSch[i].substring(1); 
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
table { margin:0 auto; }
.special { display:inline; width:20px; height:14px; }
#pdtList a { text-decoration:none; color:black; }
#pdtList a:link { text-decoration:none; color:black; }
#pdtList a:visited { text-decoration:none; color:black; }
#pdtList a:hover { text-decoration:underline; color:red; }
#subnavi01 { display:block; }
#pdtBox th, #pdtBox td { border-bottom:1px black solid; border-collapse:collapse; }
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
// makeSch() 함수에서 만들 검색 문자열 : &sch=ntest,sa:b:c,h100,bR,sR01,iy
	var frmS = document.frmSearch;
	var frm = document.frm;
	var sch = "";
	var name = frmS.pi_name.value;
	if (name != "") {
		sch += "n" + name;
	}
	var arrS = frmS.special;
	var isFirst = true; // 브랜드 선택 체크박스(brd)들 중 첫번째로 선택한 값인지 여부를 저장할 변수
	for (var i = 0; i < arrS.length; i++) {
		if (arrS[i].checked) {
			if (isFirst) {
				isFirst = false;
				if (sch != "") {
					sch += ",";
				}
				sch += "s" + arrS[i].value;
			} else {
				sch += ":" + arrS[i].value;
			}
		}
	}
	var hs = frmS.hs.value;
	if (hs != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "h" + hs;
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
		sch += "m" + pcs;
	}
	var isview = frmS.isview.value;
	if (isview != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "i" + isview;
	}
	frm.sch.value = sch;
	frm.submit();
}
function isviewUpdate(frm, is) {
	var isview = is.value;
	var ps_idx = frm.ps_idx.value;
	var pi_id = frm.pi_id.value;
	$.ajax({
		type : "POST",				
		url : "/cworld_admin/isviewUpdate",		
		data : {"pi_isview" : isview, "ps_idx" : ps_idx, "pi_id" : pi_id},		
		success : function(chkRs) {	
			if (chkRs == 1) {		
				alert("게시여부가 변경되었습니다.");
			} else {				
				alert("게시여부 변경 실패");
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
<table width="1000" id="pdtList">
<caption style="text-align:left; font-size:25px; font-weight:bold;">상 품 목 록</caption>
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
%>

<% } %>
	</select><br />
	특 별 상 품 : 
	<input type="checkbox" name="special" id="a" value="a" <% if (special.indexOf("a") >= 0 ) { %> checked="checked" <% } %>/>
	<label for="a">BEST</label>
	<input type="checkbox" name="special" id="b" value="b" <% if (special.indexOf("b") >= 0 ) { %> checked="checked" <% } %>/>
	<label for="b">NEW</label>
	<input type="checkbox" name="special" id="c" value="c" <% if (special.indexOf("c") >= 0 ) { %> checked="checked" <% } %>/>
	<label for="c">HOT</label>
	<input type="checkbox" name="special" id="d" value="d" <% if (special.indexOf("d") >= 0 ) { %> checked="checked" <% } %>/>
	<label for="d">SALE</label>
	<br />
	재 고 량 : <input type="text" name="hs" value="<%=hs %>" onkeyup="onlyNum(this);" size="7"/>
	게 시 여 부 :
	<select name="isview"> 
		<option value=""> 게 시 여 부 </option>
		<option value="y" <% if (isview.equals("y")) { %> selected="selected" <% } %>> 게 시 </option>
		<option value="n" <% if (isview.equals("n")) { %> selected="selected" <% } %>> 미 게 시 </option>
	</select>
	<br />
	상 품 명 : 
	<input type="text" name="pi_name" id="pi_name" placeholder="상품명 검색" value="<%=name %>" />
	<input type="button" value="상품 검색" class="btn" onclick="makeSch();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="검색초기화" class="btn resetSch" onclick="resetSch();" />	
	</fieldset>
	</form>
</td>
</tr>
<tr>
<td>
<!-- 상품 목록 및 페이징 -->
<table width="1000" cellpadding="0" cellspacing="0" id="pdtBox">
<% 
if (rcnt > 0) {
	String[] arrSp = {"a", "b", "c", "d"};

%>

<tr>
<th width="7%">상품코드</th>
<th width="10%">사진</th>
<th width="33%">상품명</th>
<th width="15%">가격</th>
<th width="10%">재고</th>
<th width="10%">옵션</th>
<th width="*">게시여부</th>
</tr>
<%

	for (int i = 0; i < productList.size(); i++) {
		ProductInfo pi = productList.get(i);
		out.println("<tr align=\"center\" valign=\"middle\" onmouseover=\"this.bgColor='#cfcfcf';\" onmouseout=\"this.bgColor='';\">");
		out.println("<td><span>" + pi.getPi_id() + "<span></td>");
%>
<% if (pi.getOpt().equals("a")) { %>
<td><a href='product_form_up?idx=<%=pi.getPs_idx() %>&id=<%=pi.getPi_id() %>'><img src="/cworld_admin/pdt_img/<%=pi.getPi_img1() %>" width="80" height="80" /></a></td>
<% } else if (pi.getOpt().equals("b")) { %>
<td><a href='product_form_up?idx=<%=pi.getPs_idx() %>&id=<%=pi.getPi_id() %>'><img src="/cworld_admin/pdt_img/<%=pi.getPi_img2() %>" width="80" height="80" /></a></td>
<% } else if (pi.getOpt().equals("c")) { %>
<td><a href='product_form_up?idx=<%=pi.getPs_idx() %>&id=<%=pi.getPi_id() %>'><img src="/cworld_admin/pdt_img/<%=pi.getPi_img3() %>" width="80" height="80" /></a></td>
<% } else if (pi.getOpt().equals("d")) { %>
<td><a href='product_form_up?idx=<%=pi.getPs_idx() %>&id=<%=pi.getPi_id() %>'><img src="/cworld_admin/pdt_img/<%=pi.getPi_img1() %>" width="80" height="80" /></a></td>
<% } else if (pi.getOpt().equals("r")) { %>
<td><a href='product_form_up?idx=<%=pi.getPs_idx() %>&id=<%=pi.getPi_id() %>'><img src="/cworld_admin/pdt_img/<%=pi.getPi_img1() %>" width="80" height="80" /></a></td>
<% } %>

<%
		out.println("<td align='left'><a href='product_form_up?idx=" + pi.getPs_idx() + "&id=" + pi.getPi_id() + "'><span>" + pi.getPi_name() + "</span></a>");
		for (int j = 0; j < arrSp.length; j++) {
			out.println("<div class=\"special\">");
			if (pi.getPi_special().indexOf(arrSp[j]) >= 0) {
%>
		<img src="/cworld_admin/img/sp_<%=arrSp[j] %>.png" width="20" height="14" align="absmiddle" />
<%
			}
			out.println("</div>");
		}
		out.println("</td>");
		out.println("<td><span>정가 : " + pi.getPi_price() + "<br />할인가 : " + pi.getPi_dcprice() + "<span></td>");
%>
<td><%=pi.getStock() %></td>
<td>
<% if (pi.getOpt().equals("a")) { %>
빨강
<% } else if (pi.getOpt().equals("b")) { %>
파랑
<% } else if (pi.getOpt().equals("c")) { %>
검정
<% } else if (pi.getOpt().equals("d")) { %>
기타
<% } else if (pi.getOpt().equals("r")) { %>
대여
<% } %>
</td>
<td>
<form name="frmIsview<%=i %>">
<select name="isview" onchange="isviewUpdate(this.form, this)">
	<option value="y" <% if (pi.getPs_isview().equals("y")) { %> selected="selected" <% } %>> 게 시 </option>
	<option value="n" <% if (pi.getPs_isview().equals("n")) { %> selected="selected" <% } %>> 미 게 시 </option>
</select>
<input type="hidden" name="ps_idx" value="<%=pi.getPs_idx() %>" />
<input type="hidden" name="pi_id" value="<%=pi.getPi_id() %>" />
</form>
</td>
<%
		out.println("</tr>");
	}
%>
</table>
<tr><td>
<table  width="100%">
<tr>
<td width="*" align="center">
<%
if (rcnt > 0) { 	// 게시글이 있으면 - 페이징 영역을 보여줌
	if (cpage == 1) {
		out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
	} else {
		out.println("<a href='product_list?cpage=1" + sargs + "'>[처음]</a>&nbsp;&nbsp;&nbsp;<a href='product_list?cpage=" + (cpage - 1) + sargs + "'>[이전]</a>&nbsp;&nbsp;");
	}
	spage = (cpage - 1) / bsize * bsize + 1; 		// 현재 블록에서의 시작 페이지 번호
	for (int i = 1, j = spage; i <= bsize && j <= pcnt; i++, j++) {
		// i : 블록에서 보여줄 페이지의 개수만큼 루프를 돌릴 조건으로 사용되는 변수
		// j : 실제 출력한 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 사용해야 함
		if (cpage == j) {
			out.println("&nbsp;<strong>" + j + "</strong>");
		} else {
			out.println("&nbsp;<a href='product_list?cpage=" + j + sargs + "'>" + j + "</a>");
		}	
	}
	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
	} else {
		out.println("<a href='product_list?cpage=" + (cpage + 1) + sargs + "'>&nbsp;&nbsp;[다음]</a><a href='product_list?cpage=" + pcnt + sargs + "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
	}
}
%>
</td>
<td width="10%" align="right"><input type="button" value="상품등록" onclick="location.href='product_in'"/></td>
</tr>
<%
} else {
	out.println("<tr height='45'><td align='center'>상품이 없습니다.</td></tr>");
}
%>
</table>
</td>
</tr>

</table>

</body>
</html>