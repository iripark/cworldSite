<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
ArrayList<MemberInfo> memberList = (ArrayList<MemberInfo>)request.getAttribute("memberList");
MemberInfo mi = null;

int cpage = pageInfo.getCpage(), psize = pageInfo.getPsize(), bsize = pageInfo.getBsize();
int rcnt = pageInfo.getRcnt(), pcnt = pageInfo.getPcnt(), spage = pageInfo.getSpage();
String memUid = (String)request.getAttribute("memLast");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#subnavi02 { display:block; }
a { text-decoration:none; color:black; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:none; color:black; }
.icoX { position:absolute; top:15px; right:15px; }
#lastBox th, #lastBox td { border-bottom:1px black solid; border-collapse:collapse; }
</style>
<script>
function memStatusUpdate(str) {
	if (str != "") {
		var uid = str;
		$.ajax({
			type : "POST",				
			url : "/cworld_admin/memberStatusUpdate",		
			data : {"uid" : uid},		
			success : function(chkRs) {	
				if (chkRs > 0) {		
					alert("휴면 처리가 완료되었습니다.");
					location.reload();
				} else {				
					alert("휴면 처리 실패");
				}
			}
		});
	} else {
		alert("휴면 처리할 계정이 없습니다.");
	}
}
</script>
</head>
<body>
<table align="center" width="700" cellpadding="0" cellspacing="0" id="lastBox">
<caption style="text-align:left; font-size:25px; font-weight:bold;">장기 미접속자 목록</caption>
<tr height="45">
<th width="15%" height="35" >아이디</th><th width="15%">이름</th><th width="35%">메일주소</th><th width="35%">최종로그인</th>
</tr>
<%
if(memberList.size() > 0) {
	for (int i = 0; i < memberList.size(); i++) {
		mi = memberList.get(i);
		
		
		ArrayList<AddrInfo> al = mi.getAddrList();
%>
<tr align="center" onmouseover="this.bgColor='#cfcfcf';" onmouseout="this.bgColor='';" height="45">
<td height="35" ><%=mi.getMi_id() %></td>
<td ><%=mi.getMi_name() %></td>
<td ><%=mi.getMi_mail() %></td>
<td  ><%=mi.getMi_last() %></td>
</tr>
<%
	}
%>
</table>
<table width="700" align="center">
<tr align="center"><td width="*">
<%
	if (rcnt > 0) { 	// 게시글이 있으면 - 페이징 영역을 보여줌
		if (cpage == 1) {
			out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
		} else {
			out.println("<a href='member_last?cpage=1'>[처음]</a>&nbsp;&nbsp;&nbsp;<a href='member_last?cpage=" + (cpage - 1) + "'>[이전]</a>&nbsp;&nbsp;");
		}
		spage = (cpage - 1) / bsize * bsize + 1; 		// 현재 블록에서의 시작 페이지 번호
		for (int k = 1, j = spage; k <= bsize && j <= pcnt; k++, j++) {
			if (cpage == j) {
				out.println("&nbsp;<strong>" + j + "</strong>");
			} else {
				out.println("&nbsp;<a href='member_last?cpage=" + j + "'>" + j + "</a>");
			}	
		}
		if (cpage == pcnt) {
			out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
		} else {
			out.println("<a href='member_last?cpage=" + (cpage + 1) + "'>&nbsp;&nbsp;[다음]</a><a href='member_last?cpage=" + pcnt + "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
		}
	}
%>
</td>
<td width="7%">
<br />
<input type="button" value="일괄 휴면 처리" onclick="memStatusUpdate('<%=memUid %>')"/>
</td>
</tr>
</table>

<%
} else {
	out.println("<tr height='45'><td colspan='11' align='center'>회원이 없습니다.</td></tr></table>");
}
%>

</body>
</html>