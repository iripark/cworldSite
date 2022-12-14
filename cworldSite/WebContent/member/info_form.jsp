<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
if (!isLogin){
	out.println("<script>");
	out.println("alert('잘못된 경로입니다.');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}
%>

<div class="content" id="memberinfo" align="center">

	<br/><br/><h2 style="text-align:left; margin-left:200px;">회원정보</h2>
	<hr/>
		<br/>
		<p style="width:500px; text-align:right;">
<input type="button" value="마이페이지" class="mpBtn" onclick="location.href='/cworldSite/member_page'" />
</p>
<br />
	<div id="mi">
		<table>
		<tr>
		<th width="25%">아이디</th><td width="*"><%=loginInfo.getMi_id() %></td></tr>
		<tr><th>이름</th>	<td><%=loginInfo.getMi_name() %></td></tr>
		<tr><th>성별</th>	<td><%=loginInfo.getMi_gender().equals("m") ? "남자" : "여자" %></td></tr>
	<% 	String by = loginInfo.getMi_birth().substring(0,4);
		String bm = loginInfo.getMi_birth().substring(5,7);	
		String bd = loginInfo.getMi_birth().substring(8);
		
		%>
		<tr><th>생년월일</th><td><%=by %>년 <%=bm %>월 <%=bd %>일</td></tr>
		<tr><th>휴대폰</th><td><%=loginInfo.getMi_phone() %></td></tr>
		<tr><th>이메일</th><td><%=loginInfo.getMi_mail() %></td></tr>
		</table>

		<br/>
		<div align="center">
			<input type="button" value="회원정보수정" onclick="location.href='/cworldSite/member/info_update.jsp';" style="padding:1px; width:200px; height:40px; background:pink; border:pink;"/>
		</div>
		<div align="right" style="width: 500px;">
			<input type="button" value="회원탈퇴" onclick="location.href='/cworldSite/member/leave_pwd.jsp';"/>
			
		</div>
	</div>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>