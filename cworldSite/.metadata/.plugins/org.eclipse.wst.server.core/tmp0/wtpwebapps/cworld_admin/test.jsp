<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 

String aaa = "asd";
session.setAttribute("aaa", aaa);
session.setMaxInactiveInterval(3);
%>



<p>세션 ID : <%=session.getId() %></p>

<script>
location.href = "test2.jsp";
</script>