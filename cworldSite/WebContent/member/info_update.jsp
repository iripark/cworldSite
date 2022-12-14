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
request.setCharacterEncoding("utf-8");
LocalDate today = LocalDate.now();
int cyear = today.getYear();
int cmon = today.getMonthValue();
int cday = today.getDayOfMonth();
int lastDay = today.lengthOfMonth();

String[] arrDomain = {"naver.com", "nate.com", "gmail.com", "daum.net", "yahoo.com"}; 

%>

<script src="../js/date_change.js"></script>
<script>
$(document).ready(function(){
	$("#e2").change(function(){
		if ($(this).val() == ""){
			$("#e3").val("");
			$("#e3").attr("readonly",true);
		} else if ($(this).val() == "direct"){
			$("#e3").val("");
			$("#e3").focus();
			$("#e3").attr("readonly",false);
		} else{
			$("#e3").val($(this).val());
			$("#e3").attr("readonly",true);
		}	
	});
});

function chkDupPw(pwd){
	var uid = document.getElementById("uid").innerHTML;
	if(pwd.length >= 4){
		$.ajax({
			type : "POST",				// 데이터 전송방법
			url : "/cworldSite/dupPw",		// 전송한 데이터를 받을 서버의 URL로 컨트롤러(서블릿)를 의미
			data : {"uid" : uid, "pwd" : pwd },		// 지정한 url로 보낼 데이터의 이름과 값
			success : function(chkRt){	// 데이터를 보내 실행한 결과를 chkRs로 받아 옴
				var msg = "";			// 사용자에게 보여줄 메시지를 저장할 변수
				if (chkRt == 0){	// uid와 동일한 기존의 회원아이디가 없으면
					msg = "<span id='fontRed'>비밀번호가 일치하지 않습니다.</span>";
					$("#pwChk").val("n");	// 아이디 중복체크를 성공한 상태로 변경
				} else {			// uid와 동일한 기존의 회원아이디가 있으면
					msg = "<span id='fontBlue'>비밀번호가 일치합니다.</span>";
					$("#pwChk").val("y");
				}
				$("#pwMsg").html(msg);
			}
		});
	} else {
		$("#pwMsg").text("비밀번호는 4~20자로 입력하세요.");
		$("#pwChk").val("n");
	}
}

function chkEqualPw(pwd){
	var msg2 = "";
	$(document).ready(function(){
		$("#chkpw").keyup(function(){
			var a = $("#chkpw").val();
			var b = $("#mi_pw").val();
			if(a.length > 3 && a == b){
				msg2 = "<span id='fontBlue'>비밀번호가 확인 되었습니다.</span>";
				$("#newPwChk").val("y");	// 아이디 중복체크를 성공한 상태로 변경
			} else if (a != b) {			// uid와 동일한 기존의 회원아이디가 있으면
				msg2 = "<span id='fontRed'>비밀번호가 일치하지 않습니다.</span>";
				$("#newPwChk").val("n");
			} else if (a.length == 0 && b.length == 0){
				$("#newPwChk").val("c");
			}
			$("#pwEqualMsg").html(msg2);
		});
	});
}

function chkJVal(fr){
	var pw = fr.pwChk.value;
	var newPw = fr.newPwChk.value;
	var p1= fr.p2.value;
	var p2 = fr.p3.value;
	var e1 = fr.e1.value;
	var e3 = fr.e3.value;
	var mi_pw = fr.mi_pw.value;
	
	if (pw == "n"){		alert('기존 비밀번호를 확인하세요.');		return false;	}
	if (p1.length < 3 || p2.length < 3){ alert('전화번호를 확인하세요.');		return false; }
	if (e1.length < 4 || e3.indexOf(".") <= 0 || e3.indexOf(".") >= e3.length - 1 ){
		alert('이메일을 확인하세요.');		return false;	
	}
	if(mi_pw.length >= 4 && newPw =='y'){
			return true;
	}
	if (mi_pw.length < 1 && newPw =='c'){
		return true;
	} 
}
</script>
<div class="content" id="infoUpFormBox" align="center">
	<br/><br/><h2 style="text-align:left; margin-left:200px;">회원정보 수정</h2>
	<hr/>
	<form name="frmInfoUp" action="../member_proc_up" method="post" onsubmit="return chkJVal(this);">
	<input type="hidden" name="pwChk" id="pwChk" value="n"/>
	<input type="hidden" name="newPwChk" id="newPwChk" value="c"/>
		<br/>
		<br/>
		<br/>
	<div id="infoUpForm">
		<table width="450" cellpadding="5" style="border:pink 1px solid;">
		<tr>
		<th width="25%"><label for="mi_id">아이디</label></th>
		<td width="*"><span id="uid"><%=loginInfo.getMi_id() %></span>
		</td>
		</tr>
		<tr>
		<th><label for="ori_pw">기존 비밀번호*</label></th>
		<td><input type="password" name="ori_pw" id="ori_pw" maxlength="20" onkeyup="chkDupPw(this.value);" />
		<span id="pwMsg" style="font-size:0.8em;"></span></td>
		</tr>
		<tr>
		<th><label for="mi_pw">새 비밀번호</label></th>
		<td><input type="password" name="mi_pw" id="mi_pw" maxlength="20"/>
		<span id="pwEqualMsg" style="font-size:0.8em;"></span></td>
		</tr>
		<tr>
		<th><label for="mi_chkpw">새 비밀번호 확인</label></th>
		<td><input type="password" name="chkpw" id="chkpw" maxlength="20" onkeyup="chkEqualPw(this.value);"/>
		</td>
		</tr>
		<tr>
		<th><label for="mi_name">이름</label>	</th>
		<td><%=loginInfo.getMi_name() %></td>
		<tr>
		<th>
		<span>성별</span>
		</th>
		<td><%=loginInfo.getMi_gender().equals("m") ? "남자" : "여자" %>
		</td>
		</tr>
		<% 	String by = loginInfo.getMi_birth().substring(0,4);
		String bm = loginInfo.getMi_birth().substring(5,7);	
		String bd = loginInfo.getMi_birth().substring(8);	%>
		<tr><th>생년월일</th><td><%=by %>년 <%=bm %>월 <%=bd %>일</td></tr>
		<tr><th>휴대폰</th><td>
		<% String cell[] = loginInfo.getMi_phone().split("-"); 	%>
		<select name="p1">
			<option value="010" <%if(cell[0].equals("010")){%>selected="selected"  <%}%>> 010 </option>
			<option value="011" <%if(cell[0].equals("011")){%>selected="selected"  <%}%>> 011 </option>
			<option value="016" <%if(cell[0].equals("016")){%>selected="selected"  <%}%>> 016 </option>
			<option value="019"  <%if(cell[0].equals("019")){%>selected="selected"  <%}%>> 019 </option>
		</select>
		- <input type="text" name="p2" id="p2" size="1" maxlength="4" value="<%=cell[1]%>"/>
		- <input type="text" name="p3" id="p3" size="1" maxlength="4" value="<%=cell[2]%>"/>
		</td>
		</tr>
		<tr>
		<%String arrMail[] = loginInfo.getMi_mail().split("@"); %>
		<th><span>이메일</span></th>
		<td><input type="text" name="e1" size="4" maxlength="20" value="<%=arrMail[0]%>"/> @
		<input type="text" name="e3" id="e3" size="8" maxlength="20" value="<%=arrMail[1]%>"/>
		<select name="e2" id="e2">
			<option value="" >도메인 선택</option>
			<% for (int i = 0 ; i < arrDomain.length ; i++){ %>
			<option value="<%=arrDomain[i] %>"><%=arrDomain[i] %></option>
			<%} %>
			<option value="direct" selected="selected">직접 입력</option>
		</select>
		</td>
		</tr>
		</table>
		<br/>
		<div align="center">
			<input type="submit" value="회원정보 수정" style="padding:1px; width:200px; height:40px; background:pink; border:pink;"/>
		</div>
	</div>
</form>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>