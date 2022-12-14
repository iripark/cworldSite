<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#subnavi03 { display:block; }
</style>
</head>
<body>
<form name="frm" action="notice_proc_in" method="post">
<table width="600" cellpadding="10" cellspacing="0" align="center">
<caption style="text-align:left; font-size:25px; font-weight:bold;">공 지 사 항 등 록</caption>
<tr>
<th width="15%">분류</th>
<td width="35%">
	<select name="ctgr">
		<option value="a">공 지 사 항</option>
		<option value="b">이 벤 트</option>
	</select>
</td>
<th>게시여부</th>
<td>
	<select name="isview">
		<option value="n">미 게 시</option>
		<option value="y">게 시</option>
	</select>
</td>
</tr>
<tr>
<th width="15%">글제목</th>
<td colspan="3">
	<input type="text" name="nl_title" size="63" />
</td>
</tr>
<tr>
<th>글내용</th><td colspan="3"><textarea name="nl_content" rows="10" cols="65" style="resize:none;"></textarea></td>
</tr>
<tr>
<td colspan="4" align="center">
	<input type="submit" value="글  등록" />
</td>
</tr>
</table>
</form>
</body>
</html>