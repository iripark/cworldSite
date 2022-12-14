<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
request.setCharacterEncoding("utf-8");

int idx = (int)request.getAttribute("idx");
String gname = (String)request.getAttribute("gname");
String miid = loginInfo.getMi_id();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#gReviewInBox { 
	border-collapse:collapse; border-bottom:1px solid black; border-right:1px solid black;
	border-top:1px solid black; border-left:1px solid black;
 }
#gReviewInBox th, #gReviewInBox td { padding:8px 3px; }

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
function chkJVal(fr){
	var gr_title = fr.gr_title.value;
	var gr_content = fr.gr_content.value;
	
	if (gr_title == ""){ alert('제목을 입력하세요.');		return false; }
	if (gr_content == ""){ alert('내용을 입력하세요.');		return false; }
	if (frm.gr_img.value != "" && !isImg(frm.gr_img.value)) {
		alert("상품 이미지의 확장자를 확인하세요.");
		return false;			
	}
	return true;
}
</script>
</head>
<body>
<form name="frmReviewIn" action="g_review_proc_in" method="post" onsubmit="return chkVal(this);" enctype="multipart/form-data" >
<input type="hidden" name="idx" value="<%=idx %>" />
<input type="hidden" name="miid" value="<%=miid %>" />
<input type="hidden" name="gname" value="<%=gname %>" />
<input type="hidden" name="ip" value="<%=request.getRemoteAddr() %>" />
<div class="content" align="center">
<p style="width:600px; text-align:left;"><img src="/cworldSite/img/g_review_in.png" width="100" height="40"/></p>
<table width="600" id="gReviewInBox">
<tr align="center" height="45">
<th width="20%">작성자</th>
<td width="30%"><%=miid %></td>
<th width="20%">단체명</th>
<td width="30%"><%=gname %></td>
</tr>
<tr height="45">
<th align="center">제목</th>
<td colspan="3"><input type="text" name="gr_title" style="height:20px;"/></td>

</tr>
<tr height="200">
<th align="center">내용</th>
<td colspan="3"><textarea name="gr_content"></textarea></td>
</tr>
<tr height="45">
<th align="center">첨부파일</th>
<td colspan="3"><input type="file" name="gr_img" /></td>
</tr>
</table>
<br /><br />
<input type="submit" value="리뷰 등록" />
</div>
</form>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>