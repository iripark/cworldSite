<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#qnaBox { 
	border-collapse:collapse; border-bottom:1px solid black; border-right:1px solid black;
	border-top:1px solid black; border-left:1px solid black;
 }
#qnaBox th, #qnaBox td { padding:8px 3px; }
#qnaBox th { text-align:center; }
</style>
<script>
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
	if (frm.ctgr.value == "") {
		alert("분류를 선택하세요.");
		frm.ctgr.focus();
		return false;
	}
	if (frm.title.value == "") {
		alert("제목을 입력하세요.");
		frm.title.focus();
		return false;
	}
	if (frm.content.value == "") {
		alert("내용을 입력하세요.");
		frm.content.focus();
		return false;
	}
	if (frm.ql_img1.value != "" && !isImg(frm.ql_img1.value)) {
		alert("상품 이미지1의 확장자를 확인하세요.");
		return false;			
	}
	return true;
}
</script>
</head>
<body>
<div class="content" align="center">
<form name="frmQna" action="qna_proc_in" method="post" enctype="multipart/form-data" onsubmit="return chkVal(this)">
<input type="hidden" name="ip" value="<%=request.getRemoteAddr() %>" />
<p style="width:600px; text-align:left;"><img src="/cworldSite/img/mp_qna.png" width="100" height="40"/></p>
<br />
<table width="600" align="center" id="qnaBox">
<tr>
<th width="25%">문의 분류</th>
<td colspan="3" width="*">
	<select name="ctgr">
		<option value="">분 류 선 택</option>
		<option value="a">회 원 관 련</option>
		<option value="b">상 품 관 련</option>
		<option value="c">결 제 관 련</option>
		<option value="d">기 타</option>
	</select>
</td>
</tr>
<tr>
<th>제 목</th>
<td colspan="3">
<input type="text" name="title" style="width:400px;"/>
</td>
</tr>
<tr>
<th>내 용</th>
<td colspan="3">
<textarea style="width:400px; height:200px;" name="content"></textarea>
</td>
</tr>
<tr>
<th>첨부 파일</th>
<td colspan="3">
<input type="file" name="ql_img1" />
</td>
</tr>
</table>
<br />
<p><input type="submit" value="문의하기" /></p>
</form>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>