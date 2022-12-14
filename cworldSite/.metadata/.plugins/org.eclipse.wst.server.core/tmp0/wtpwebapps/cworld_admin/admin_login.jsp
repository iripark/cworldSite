<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cworld 어드민 로그인</title>
<link rel="shortcut icon" href="/cworldSite/img/favicon.ico" type="image/x-icon" />
<link rel="icon" href="/cworldSite/img/favicon.ico" type="image/x-icon" />
<style>
#btn { width:100px; height:50px;}
#uid, #pwd { border:none; border-bottom:1px black solid; text-align:right; width:200px; font-size:1.2em; }
#adminLoginBox { 
	width:500px; height:500px; position:absolute; top:50%; left:50%; margin-left:-250px; margin-top:-300px; 
	text-align:center; 
}
</style>
</head>
<body>
<div id="adminLoginBox" align="center">
<img src="/cworld_admin/img/cworld_logo.jpg" width="200" height="200" />
<form name="frmLogin" action="admin_login" method="post">
<table width="450" height="160" align="center" id="login_form" cellpadding="5" cellspacing="5">
<tr><td align="center" width="30%">아이디</td><td width="65%"><input type="text" name="uid" id="uid" value="admin1" /></td>
<td rowspan="2" align="center" width="*"><input id="btn" type="submit" value="로그인" /></td>
</tr>
<tr><td align="center">비밀번호</td><td><input type="password" name="pwd" id="pwd" value="1234" /></td></tr>
</table>
</form>
</div>
</body>
</html>