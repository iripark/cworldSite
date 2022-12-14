<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
if (loginInfo != null){%>
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
<div class="content" id="findPwAfter" align="center">
		<h1>비밀번호 찾기</h1>
		<table width="600">
			<tr><td align="center" width="100%" height="200">
				회원님이 등록하신 이메일로<br/> 임시비밀번호를 전송했습니다.<br/><br/>
			<input type="button" value="로그인" onclick="location.href = 'login_form.jsp';"/>
			</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>