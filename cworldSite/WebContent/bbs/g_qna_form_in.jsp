<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String[] arrDomain = {"naver.com", "nate.com", "gmail.com", "daum.net", "yahoo.com"}; 
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#gQnaInBox { 
	border-collapse:collapse; border-bottom:1px solid black; border-right:1px solid black;
	border-top:1px solid black; border-left:1px solid black;
 }
#gQnaInBox th, #gQnaInBox td { padding:8px 3px; }
</style>
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
	var p1 = fr.p2.value;
	var p2 = fr.p3.value;
	var gq_title = fr.gq_title.value;
	var gq_content = fr.gq_content.value;

	if (gq_title == ""){ alert('제목을 입력하세요.');		return false; }
	if (gq_content == ""){ alert('내용을 입력하세요.');		return false; }
	if (p1.length < 3 || p2.length < 3){ alert('전화번호를 확인하세요.');		return false; }
	return true;
}
</script>
</head>
<body>
<div class="content" align="center">
<p style="width:600px; text-align:left;">
<img src="/cworldSite/img/group_qna_in.png" width="100" height="40"/>
</p><br />
<form name="frmGQna" action="g_qna_proc_in" method="post" onsubmit="return chkJVal(this);">
<table width="600" cellpadding="5" id="gQnaInBox">
<tr height="45">
<th width="10%">작성자</th>
<td width="30%"><%=loginInfo.getMi_id()%></td>
<th width="10%">단체명</th>
<td width="50%"><input type="text" name="gq_gname"></td>
</tr>
<tr height="45">
<th>연락처</th>
<td><select name="p1">
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="019">019</option>
		</select> - <input type="text" name="p2" id="p2" size="1" maxlength="4"/>
		- <input type="text" name="p3" id="p3" size="1" maxlength="4"/></td>
<th> 이메일 </th>
<td><input type="text" name="e1" size="4" maxlength="20" /> @
		<input type="text" name="e3" id="e3" size="8" maxlength="20" readonly="true" />
		<select name="e2" id="e2" >
			<option value="" >도메인 선택</option>
			<% for (int i = 0 ; i < arrDomain.length ; i++){ %>
			<option value="<%=arrDomain[i] %>"><%=arrDomain[i] %></option>
			<%} %>
			<option value="direct">직접 입력</option>
		</select>
</td>
</tr>
<tr height="45">
<th>글제목</th><td colspan="3"><input type="text" name="gq_title"/></td>
</tr>
<tr>
<th>글내용</th><td colspan="3"><textarea name="gq_content" rows="10" cols="65" style="resize:none;"></textarea></td>
</tr>
<tr>
<td colspan="4" align="center" height="45">
   <input type="submit" value="글  등록" />
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <input type="reset" value="다시 입력" />
</td></tr>
</table>
</form>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>