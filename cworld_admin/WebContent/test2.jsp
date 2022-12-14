<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String aaa = (String)session.getAttribute("aaa");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<p>세션 ID : <%=session.getId() %></p>
<%=aaa %>
</body>
</html>