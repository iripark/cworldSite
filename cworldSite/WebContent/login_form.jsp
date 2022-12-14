<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
if (loginInfo != null){%>
	<script>
	alert('잘못된 경로로 들어오셨습니다.');
	history.back();
	</script>
<%
} 
request.setCharacterEncoding("utf-8");
Random rnd = new Random();
int randNum = rnd.nextInt(163) + 1;
%>

<div class="content" id="loginForm">
	<form name="frmlogin" action="login" method="post">
		<input type="hidden" name="url" value="<%=url %>"/>
		<h1>로그인</h1>
		<table width="300" cellpadding="10" id="loginTable">
			<tr>
			<td width="30%" height="50" align="center"><label for="uid">&nbsp;아이디</label></td>
			<td align="center"><input type="text" name="uid" id="uid" value="test1"/></td>
			</tr>
			<tr>
			<td height="50" align="right"><label for="pwd">비밀번호 &nbsp;</label></td>
			<td height="50" align="center">
			<input type="password" name="pwd" id="pwd" value="1234"/></td></tr>
			<tr><td colspan="2" align="center"  height="50"><input type="submit" value="로그인"/>
			</td>
			</tr>
			<tr>
			<td colspan="2" align="center"  height="50">
				<a href="/cworldSite/member/findId_form.jsp">아이디 찾기</a> | 
				<a href="/cworldSite/member/findPw_form.jsp">비밀번호 찾기</a> | 
				<a href="/cworldSite/member/join_contract.jsp">회원가입</a>
			</td>
			</tr>
		</table>
	</form>
</div>

</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>