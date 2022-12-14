<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
session.invalidate();    
%>
    
<div class="content" align="center">
<div class="leave"><br/>
정상적으로 회원탈퇴를 완료 하였습니다.
</div>
<br/>
<input type="button" value="메인으로" onclick="location.href='/cworldSite/index.jsp';"/>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>