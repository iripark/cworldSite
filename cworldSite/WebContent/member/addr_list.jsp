<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
request.setCharacterEncoding("utf-8");
if (!isLogin){
	out.println("<script>");
	out.println("alert('잘못된 경로입니다.');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}
ArrayList<MemberAddr> al = (ArrayList<MemberAddr>)request.getAttribute("addrList");
int maxAddr = al.size();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#addrBox { width:800px; }
#addrBox th, #addrBox td { border-bottom:1px black solid; border-collapse:collapse; }
#addrBox th { text-align:center;}
#addrUpBtn { width:80px; height:30px; font-size:1.2em; background-color:#c00; border:none; color:white; }
</style>
<script>
function chkAll(obj) {
	var arrChk = document.frmAddr.chk;
	for (var i = 0; i < arrChk.length; i++) {
		arrChk[i].checked = obj.checked;
	}
}
function chBasic(idx) {	
	if (confirm("기본 주소를 변경하시겠습니까?")) {
		$.ajax({
			type : "POST",				
			url : "/cworldSite/basic_up",		
			data : {"idx" : idx},		
			success : function(chkRs) {			
				if (chkRs == 0) {	// 옵션 변경에 실패 했을 경우
					alert("기본주소 변경에 실패했습니다.");
				} 
				location.reload();
			}
		});
	}
}
function getSelectedValues() {	
// 체크박스들 중 선택된 체크박스 들의 값들을 쉼표로 구분하여 문자열로 리턴하는 함수
	var chk = document.frmAddr.chk;
	var idxs = "";	// chk컨트롤 배열에서 선택된 체크박스의 값들을 누적 저장할 변수(ex 1,2,3)
	for (var i = 0; i < chk.length; i++) {
		if(chk[i].checked) {
			idxs += "," + chk[i].value;
		}
	}
	return idxs.substring(1);	
}
function chkDel() {
	var ocidx = getSelectedValues();
	if(ocidx == "") {
		alert("삭제할 상품을 선택하세요.");
	} else {
		addrDel(ocidx);
	}
}
function addrDel(idx) {	
	if (confirm("선택한 주소를 삭제하시겠습니까?")) {
		$.ajax({
			type : "POST",				
			url : "/cworldSite/basic_del",		
			data : {"idx" : idx},		
			success : function(chkRs) {			
				if (chkRs == 0) {	// 옵션 변경에 실패 했을 경우
					alert("선택한 주소 삭제에 실패했습니다.");
				} 
				location.reload();
			}
		});
	}
}
function chkCount(num) {
	if (num > 4) {
		alert("배송지 등록은 5개까지 할 수 있습니다.")
		location.reload();
	} else {
		location.href = "addr_form_in";
	}
}
</script>
</head>
<body>
<form name="frmAddr">
<input type="hidden" name="chk" value="" />
<div class="content" align="center">
<p style="width:800px; text-align:left;">
<img src="/cworldSite/img/mp_addr.png" width="100" height="40"/>
</p>
<p style="width:800px; text-align:right;">
<input type="button" name="addrIn" value="배송지 등록" onclick="chkCount(<%=maxAddr %>)"; />
</p>
<br />

<table width="800" align="center" id="addrBox" cellpadding="0" cellspacing="0">
<tr height="40">
<th width="10%">선택</th>
<th width="10%">번호</th>
<th width="20%">배송지명</th>
<th width="40%">주소</th>
<th width="*">기본주소 변경</th>
</tr>
<% 
int num = 0;
for (int i = 0; i < al.size(); i++) {
	num++;
	MemberAddr ma = al.get(i);
%>

<tr height="40">
<input type="hidden" name="<%=i %>" value="<%=ma.getMa_idx() %>" />
<td align="center"><input type="checkbox" name="chk" value="<%=ma.getMa_idx() %>" <% if (ma.getMa_basic().equals("y")) { %> disabled="disabled" <% } %>/></td>
<td align="center"><%=num %></td>
<td><%=ma.getMa_name() %></td>
<td><%=ma.getMa_addr1() + "   " + ma.getMa_addr2() %></td>
<td align="center">
<% if (ma.getMa_basic().equals("n")) { %><input type="button" name="ch" value="변경" id="addrUpBtn" onclick="chBasic(<%=ma.getMa_idx() %>);" /><% } %>
</td>
</tr>
<%
	
}
%>
</table>
<br />
<table width="800" align="center">
<tr>
<td align="left">
&nbsp;&nbsp;<input type="button" value="선택 삭제" class="addrDelBtn" onclick="chkDel();" />
</td>
<td align="right">
<input type="button" value="마이페이지" class="mpBtn" onclick="location.href='member_page';" />&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</form>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>