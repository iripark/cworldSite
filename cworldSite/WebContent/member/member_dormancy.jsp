<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<% String[] arrDomain = {"naver.com", "nate.com", "gmail.com", "daum.net", "yahoo.com"};  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
$(document).ready(function(){
	$("#e2").change(function(){
		if ($(this).val() == ""){
			$("#e3").val("");
			$("#e3").attr("readonly",true);
		} else if ($(this).val() == "direct"){
			$("#e3").val("");
			$("#e3").focus();
			$("#e3").attr("readonly",false);
		} else{
			$("#e3").val($(this).val());
			$("#e3").attr("readonly",true);
		}	
	});
});
function chkJVal(fr){
	var e1 = fr.e1.value;
	var e3 = fr.e3.value;
	if (e1.length < 4 || e3.indexOf(".") <= 0 || e3.indexOf(".") >= e3.length - 1 ){		alert('이메일을 확인하세요.');		return false;	}
		return true;
}
</script>
</head>
<body>
<div class="content" align="center">

	<form name="frmlogin" action="/cworldSite/member_dormancy" method="post" onsubmit="return chkJVal(this);">
		<h1>휴면계정입니다.<br/>휴면상태를 푸시려면 인증이 필요합니다.</h1>
		<table width="600" cellpadding="10" >
			<tr>
			<td width="30%" height="50" align="center"><label for="uid">&nbsp;이메일</td>
			<td>
			<input type="text" name="e1" size="4" maxlength="20" style="padding:1px; width:80px; height:30px; border:pink;"/> @
		<input type="text" name="e3" id="e3" size="8" maxlength="20" readonly="true" style="padding:1px; width:90px; height:30px; border:pink;"/>
		<select name="e2" id="e2" style="padding:2px; width:100px; height:32px; border:pink;">
			<option value="" >도메인 선택</option>
			<% for (int i = 0 ; i < arrDomain.length ; i++){ %>
			<option value="<%=arrDomain[i] %>"><%=arrDomain[i] %></option>
			<%} %>
			<option value="direct">직접 입력</option>
		</select>
			</td>
			</tr>
			<tr><td colspan="2" align="center"  height="50"><input type="submit" value="인증하기"/>
			</td>
			</tr>
		</table>
	</form>
</div>


</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>