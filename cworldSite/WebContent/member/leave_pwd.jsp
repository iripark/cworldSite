<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
if (loginInfo == null){%>
<script>
alert('잘못된 경로로 들어오셨습니다.');
history.back();
</script>
<%} 

request.setCharacterEncoding("utf-8");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name="frmLeave" action="/cworldSite/member_proc_del" method="post">
<input type="hidden" name="uid" value="<%=loginInfo.getMi_id() %>"/>
<div class="content" align="center">
	<p>회원탈퇴를 원하실 경우<br/>비밀번호를 입력하세요.</p>
	<input type="password" name="pwd" id="pwd"/><br/>
	<input type="button" value="취소" onclick="history.back();"/>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="submit" value="확인"/>
</div>
</form>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>