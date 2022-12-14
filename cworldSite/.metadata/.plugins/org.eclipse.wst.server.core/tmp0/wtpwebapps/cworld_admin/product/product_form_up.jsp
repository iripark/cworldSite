<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ProductInfo pi = (ProductInfo)request.getAttribute("pi");
String pcb_id = pi.getPcb_id();
String pcs_id = pi.getPcs_id();
String pi_id = pi.getPi_id();
String ps_opt = pi.getOpt();
String pi_name = pi.getPi_name();
String pi_special = pi.getPi_special();
int pi_cost = pi.getPi_cost();
int ps_stock = pi.getStock();
int pi_price = pi.getPi_price();
int pi_dc = pi.getPi_dc();
int pi_dcprice = pi.getPi_dcprice();
int pi_dfee = pi.getPi_dfee();
String pi_img1 = pi.getPi_img1();
String pi_img2 = pi.getPi_img2();
String pi_img3 = pi.getPi_img3();
String pi_desc = pi.getPi_desc();
String ps_isview = pi.getPs_isview();
if (pi_img2 == null) pi_img2 = "";
if (pi_img3 == null) pi_img3 = "";
ArrayList<PdtCtgrSmall> pcs = (ArrayList<PdtCtgrSmall>)request.getAttribute("pcs");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#subnavi01 { display:block; }
	body { margin:0; }
	table, th, td { border:1px solid black; padding:5px; font-size:12px; }
	td { padding-left:20px; }
	.pdt { width:650px; height:600; border-collapse:collapse; }
	.ipt { width:150px; }
	#product_name { width:250px; }
	.cata { width:156px; }
	.img { display:inline; }
	#subnavi01 { display:block; }
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
	function setSubName(y) {
		var tmp = y;
		if (y != "") {			
			$("#subName").val(tmp);
		}
	}
	function onlyNum(obj) {
		if (isNaN(obj.value)) {
			obj.value = "";
		}
	}
	function dsResult(x, y) {
		var a = Number(x);
		var b = Number(y);
		var result = a * (100 - b) / 100;
		if (x != "") {
			$("#ds").val(result);
		}	
	}
	function isImg(str) {
		var arrImg = ["jpg", "png", "gif", "jpeg"];
		var ext = str.substring(str.lastIndexOf(".") + 1);
		for (var i = 0; i < arrImg.length; i++) {
			if (arrImg[i] == ext) {
				return true;
			}
		}
	}
	function chkVal(frm) {
		if (frm.pcb_id.value == "") {
			alert("대분류를 선택하세요.");
			frm.pcb_id.focus();
			return false;
		}
		if (frm.pcs_id.value == "") {
			alert("소분류를 선택하세요.");
			frm.pcs_id.focus();
			return false;
		}
		if (frm.pi_id.value == "") {
			alert("상품코드를 입력하세요.");
			frm.pi_id.focus();
			return false;
		}
		if (frm.ps_opt.value == "") {
			alert("옵션을 선택하세요.");
			frm.ps_opt.focus();
			return false;
		}
		if (frm.pi_name.value == "") {
			alert("제품명을 입력하세요.");
			frm.pi_name.focus();
			return false;
		}
		if (frm.pi_cost.value == "") {
			alert("원가를 입력하세요.");
			frm.pi_cost.focus();
			return false;
		}
		if (frm.ps_stock.value == "") {
			alert("재고를 입력하세요.");
			frm.ps_stock.focus();
			return false;
		}
		if (frm.pi_price.value == "") {
			alert("정가를 입력하세요.");
			frm.pi_price.focus();
			return false;
		}
		if (frm.pi_dc.value == "") {
			alert("할인률을 입력하세요.");
			frm.pi_dc.focus();
			return false;
		}
		if (frm.pi_dfee.value == "") {
			alert("배송비를 입력하세요.");
			frm.pi_dfee.focus();
			return false;
		}
		if (frm.pi_img1.value != "" && !isImg(frm.pi_img1.value)) {
			alert("상품 이미지1의 확장자를 확인하세요.");
			return false;
		}
		if (frm.pi_img2.value != "" && !isImg(frm.pi_img2.value)) {
			alert("상품 이미지2의 확장자를 확인하세요.");
			return false;			
		}
		if (frm.pi_img3.value != "" && !isImg(frm.pi_img3.value)) {
			alert("상품 이미지3의 확장자를 확인하세요.");
			return false;			
		}
		if (frm.pi_desc.value != "" && !isImg(frm.pi_desc.value)) {
			alert("설명 이미지의 확장자를 확인하세요.");
			return false;
		}
		return true;
	}
</script>
</head>
<body>
<form name="productFrm" method="post" action="product_proc_up" onsubmit="return chkVal(this);">
<input type="hidden" name="pcb_id" value="<%=pcb_id %>" />
<input type="hidden" name="pcs_id" value="<%=pcs_id %>" />
<input type="hidden" name="pi_id" value="<%=pi_id %>" />
<input type="hidden" name="ps_opt" value="<%=ps_opt %>" />
<table align="center" class="pdt">
<caption style="text-align:left; font-size:25px; font-weight:bold;">상 품 수 정</caption>
<tr>

</tr>
<tr><th>상품명</th><td colspan="3"><input type="text" name="pi_name" id="product_name" value="<%=pi_name %>" /></td></tr>
<tr>
<th>특별 상품</th>
<td colspan="3">
	<input type="checkbox" name="best" value="a" id="a"<% if (pi_special.indexOf("a") >= 0) { %> checked="checked" <% } %>/><label for="a">BEST 상품</label>&nbsp;&nbsp;
	<input type="checkbox" name="new" value="b" id="b"<% if (pi_special.indexOf("b") >= 0) { %> checked="checked" <% } %>/><label for="b">NEW 상품</label>&nbsp;&nbsp;	
	<input type="checkbox" name="hot" value="c" id="c"<% if (pi_special.indexOf("c") >= 0) { %> checked="checked" <% } %>/><label for="c">HOT 상품</label>&nbsp;&nbsp;
	<input type="checkbox" name="sale" value="d" id="d"<% if (pi_special.indexOf("d") >= 0) { %> checked="checked" <% } %>/><label for="d">SALE 상품</label>
</td>
</tr>
<tr>
<th width="15%">원가</th><td width="35%"><input type="text" name="pi_cost" class="ipt" onkeyup="onlyNum(this);" value="<%=pi_cost %>" /></td>
<th width="15%">재고</th><td width="35%"><input type="text" name="ps_stock" class="ipt" onkeyup="onlyNum(this);" value="<%=ps_stock %>" /></td>
</tr>
<tr>
<th>정가</th><td><input type="text" name="pi_price" class="ipt" onkeyup="onlyNum(this);" value="<%=pi_price %>" /></td>
<th>할인율</th><td><input type="text" name="pi_dc" class="ipt" onkeyup="dsResult(this.form.pi_price.value, this.value);" value="<%=pi_dc %>" maxlength="2"/></td>
</tr>
<tr>
<th>할인가</th><td><input type="text" name="pi_dcprice" class="ipt" id="ds" readonly="readonly" value="<%=pi_dcprice %>" /></td>
<th>배송비</th><td><input type="text" name="pi_dfee" class="ipt" onkeyup="onlyNum(this);" value="<%=pi_dfee %>" /></td>
</tr>
<tr><th>이미지1</th><td><img src="/cworld_admin/pdt_img/<%=pi_img1 %>" width="50" height="50" class="img"/><%=pi_img1 %><br /><input type="file" name="pi_img1" class="ipt" /></td>
<th>이미지2</th><td><% if (pi_img2 != null && !pi_img2.equals("")) { %> <img src="/cworld_admin/pdt_img/<%=pi_img2 %>" width="50" height="50" class="img"/><%=pi_img2 %><br/><% } %><input type="file" name="pi_img2" class="ipt" /></td></tr>
<tr><th>이미지3</th><td><% if (pi_img3 != null && !pi_img3.equals("")) { %> <img src="/cworld_admin/pdt_img/<%=pi_img3 %>" width="50" height="50" class="img"/><%=pi_img3 %> <br/><% } %><input type="file" name="pi_img3" class="ipt" /></td>
<th>설명이미지</th><td><img src="/cworld_admin/pdt_img/<%=pi_desc %>" width="50" height="50" class="img"/><%=pi_desc %><br/><input type="file" name="pi_desc" class="ipt" /></td></tr>
<input type="hidden" value="<%=pi_img1 %>" name="img1"/>
<input type="hidden" value="<%=pi_img2 %>" name="img2"/>
<input type="hidden" value="<%=pi_img3 %>" name="img3"/>
<input type="hidden" value="<%=pi_desc %>" name="desc"/>
<tr>
<th>게시 여부</th>
<td colspan="3">
<select name="pi_isview">
	<option value="y" <% if (ps_isview.equals("y")) { %> selected="selected" <% } %>> 게 시 </option>
	<option value="n" <% if (ps_isview.equals("n")) { %> selected="selected" <% } %>> 미 게 시 </option>
</select>
</td>
</tr>
</table>
<p align="center">
	<input type="submit" value="상품 수정" />&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="reset" value="다시 입력" />&nbsp;&nbsp;&nbsp;&nbsp;
</p>
</form>
</body>
</html>