<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
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
		if (frm.pi_img1.value == "") {	
			alert("상품 이미지는 최소 하나 등록해야 합니다.");
			frm.pi_img1.focus();
			return false;
		} else if (!isImg(frm.pi_img1.value)) {
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
		if (frm.pi_desc.value == "") {
			alert("설명 이미지를 등록하세요.");
			frm.pi_desc.focus();
			return false;
		} else if (!isImg(frm.pi_desc.value)) {
			alert("설명 이미지의 확장자를 확인하세요.");
			return false;
		}
		return true;
	}
function setOpt(b, opt) {
	if (b == "R" || b == "P") {
		$("#optId").val("r").prop("selectes", true);
	}
	if (b == "P") {
		$("#pcsId").val("P00").prop("selectes", true);
	}
}
</script>
</head>
<body>

<form name="productFrm" method="post" action="product_proc_in" onsubmit="return chkVal(this);">
<table align="center" class="pdt">
<caption style="text-align:left; font-size:25px; font-weight:bold;">상 품 등 록</caption>
<tr>
<th>상품 분류</th>
<td colspan="3">
	<select name="pcb_id" class="cata" onchange="setCategory(this.value, this.form.pcs_id); setOpt(this.value, this.form.ps_opt);">
		<option value=""> 대분류 선택 </option>
		<option value="R"> 대 여 </option>
		<option value="S"> 판 매 </option>
		<option value="P"> 패 키 지 </option>
	</select>
	<select name="pcs_id" class="cata" onchange="setSubName(this.value, this.form.pi_id);" id="pcsId">
		<option value=""> 소분류 선택 </option>
	</select>
	<input type="text" id="subName" name="pi_id" maxlength="6" size="5" />
	<select name="ps_opt" id="optId">
		<option value=""> 옵 션 선 택 </option>
		<option value="r"> 대 여 전 용 </option>
		<option value="a"> 빨 강 </option>
		<option value="b"> 파 랑 </option>
		<option value="c"> 검 정 </option>
		<option value="d"> 기 타 </option>
	</select>
</td>
</tr>
<tr><th>상품명</th><td colspan="3"><input type="text" name="pi_name" id="product_name" /></td></tr>
<tr>
<th>특별 상품</th>
<td colspan="3">
	<input type="checkbox" name="best" value="a" id="aa"/><label for="aa">BEST 상품</label>&nbsp;&nbsp;
	<input type="checkbox" name="new" value="b"  id="bb"/><label for="bb">NEW 상품</label>&nbsp;&nbsp;	
	<input type="checkbox" name="hot" value="c"  id="cc"/><label for="cc">HOT 상품</label>&nbsp;&nbsp;
	<input type="checkbox" name="sale" value="d"  id="dd"/><label for="dd">SALE 상품</label>
</td>
</tr>
<tr>
<th width="15%">원가</th><td width="35%"><input type="text" name="pi_cost" class="ipt" onkeyup="onlyNum(this);" /></td>
<th width="15%">재고</th><td width="35%"><input type="text" name="ps_stock" class="ipt" onkeyup="onlyNum(this);" /></td>
</tr>
<tr>
<th>정가</th><td><input type="text" name="pi_price" class="ipt" onkeyup="onlyNum(this);" /></td>
<th>할인율</th><td><input type="text" name="pi_dc" class="ipt" onkeyup="dsResult(this.form.pi_price.value, this.value);" maxlength="2"/></td>
</tr>
<tr>
<th>할인가</th><td><input type="text" name="pi_dcprice" class="ipt" id="ds" readonly="readonly"/></td>
<th>배송비</th><td><input type="text" name="pi_dfee" class="ipt" onkeyup="onlyNum(this);" /></td>
</tr>
<tr><th>이미지1</th><td><input type="file" name="pi_img1" class="ipt" /></td>
<th>이미지2</th><td><input type="file" name="pi_img2" class="ipt" /></td></tr>
<tr><th>이미지3</th><td><input type="file" name="pi_img3" class="ipt" /></td>
<th>설명이미지</th><td><input type="file" name="pi_desc" class="ipt" /></td></tr>

<tr>
<th>게시 여부</th>
<td colspan="3">
<select name="pi_isview">
	<option value="y" selected="selected"> 게 시 </option>
	<option value="n"> 미 게 시 </option>
</select>
</td>
</tr>
</table>
<p align="center">
	<input type="submit" value="상품 등록" />&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="reset" value="다시 입력" />&nbsp;&nbsp;&nbsp;&nbsp;
</p>
</form>
</body>
</html>