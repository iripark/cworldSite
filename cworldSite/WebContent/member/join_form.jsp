<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
if (isLogin){
	out.println("<script>");
	out.println("alert('잘못된 경로입니다.');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}
request.setCharacterEncoding("utf-8");
String[] terms = request.getParameterValues("terms");
String agree = "n";
for (int i = 0 ; i < terms.length;i++){
	if(terms[i].equals("c4")){
		agree = "y";
	}
}

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

function chkDupId(uid){
	uid = uid.replace(/[^0-9A-Za-z]/g,'');
	$("#mi_id").val(uid);
	if(uid.length >= 4){
		$.ajax({
			type : "POST",				// 데이터 전송방법
			url : "/cworldSite/dupId",		// 전송한 데이터를 받을 서버의 URL로 컨트롤러(서블릿)를 의미
			data : {"uid" : uid},		// 지정한 url로 보낼 데이터의 이름과 값
			success : function(chkRs){	// 데이터를 보내 실행한 결과를 chkRs로 받아 옴
				var msg = "";			// 사용자에게 보여줄 메시지를 저장할 변수
				if (chkRs == 0){	// uid와 동일한 기존의 회원아이디가 없으면
					msg = "<span id='fontBlue'>사용할 수 있는 아이디입니다.</span>";
					$("#idChk").val("y");	// 아이디 중복체크를 성공한 상태로 변경
				} else {			// uid와 동일한 기존의 회원아이디가 있으면
					msg = "<span id='fontRed'>이미 사용중인 아이디입니다.</span>";
					$("#idChk").val("n");
				}
				$("#idMsg").html(msg);
			}
		});
	} else {
		$("#idMsg").text("아이디는 4~20자로 입력하세요.");
		$("#idChk").val("n");
	}
}

function chkEqualPw(pwd){
	var msg2 = "";
	$(document).ready(function(){
		$("#chkpw").keyup(function(){
			var a = $("#chkpw").val();
			var b = $("#mi_pw").val();
			if(a == b){
				msg2 = "<span id='fontBlue'>비밀번호가 확인 되었습니다.</span>";
				$("#pwChk").val("y");	// 아이디 중복체크를 성공한 상태로 변경
			} else {			// uid와 동일한 기존의 회원아이디가 있으면
				msg2 = "<span id='fontRed'>비밀번호가 일치하지 않습니다.</span>";
				$("#pwChk").val("n");
			}
			$("#pwMsg").html(msg2);
		});
	});
}

function chkJVal(fr){
	var id = fr.idChk.value;
	var pw = fr.pwChk.value;
	var name = fr.mi_name.value;
	var p1 = fr.p2.value;
	var p2 = fr.p3.value;
	var e1 = fr.e1.value;
	var e3 = fr.e3.value;
	var zip = fr.ma_zip.value;
	var addr1 = fr.ma_addr1.value;
	if (id == "n"){		alert('아이디를 확인하세요.');			return false;	}
	if (pw == "n"){		alert('비밀번호를 확인하세요.');		return false;	}
	if (name.length < 2){		alert('이름을 확인하세요.');		return false;	}
	if (p1.length < 3 || p2.length < 3){ alert('전화번호를 확인하세요.');		return false; }
	if (e1.length < 4 || e3.indexOf(".") <= 0 || e3.indexOf(".") >= e3.length - 1 ){		alert('이메일을 확인하세요.');		return false;	}
	if (zip.length != 5 || addr1.length < 2){ alert('주소를 확인하세요.');		return false; }
		return true;
}
</script>
<div class="content" id="joinFormBox" align="center">
	<h2>회원가입 폼</h2>
	<hr/>
	<form name="frmmJoin" action="../memberProcIn" method="post" onsubmit="return chkJVal(this);">
	<input type="hidden" name="kind" value="in"/>
	<input type="hidden" name="mi_adv" value="<%=agree %>"/>
	<input type="hidden" name="idChk" id="idChk" value="n"/>
	<input type="hidden" name="pwChk" id="pwChk" value="n"/>
		<br/>
		<br/>
		<br/>
	<div id="joinForm">
		<table>
		<tr>
		<th width="25%"><label for="mi_id">아이디</label></th>
		<td width="*"><input type="text" name="mi_id" id="mi_id" maxlength="20" onkeyup="chkDupId(this.value);" style="padding:5px; width:185px; height:20px; border:pink;"/>
		<span id="idMsg" style="font-size:0.8em;"></span>
		</td>
		</tr>
		<tr>
		<th><label for="mi_pw">비밀번호</label></th>
		<td><input type="password" name="mi_pw" id="mi_pw" maxlength="20" style="padding:5px; width:185px; height:20px; border:pink;"/>
		<span id="pwMsg" style="font-size:0.8em;"></span></td>
		</tr>
		<tr>
		<th><label for="mi_chkpw">비밀번호 확인</label></th>
		<td><input type="password" name="chkpw" id="chkpw" maxlength="20" onkeyup="chkEqualPw(this.value);" style="padding:5px; width:185px; height:20px; border:pink;"/>
		</td>
		</tr>
		<tr>
		<th><label for="mi_name">이름</label>	</th>
		<td><input type="text" name="mi_name" id="mi_name" maxlength="20" style="padding:5px; width:185px; height:20px; border:pink;"/></td>
		<tr>
		<th>
		<span>성별</span>
		</th>
		<td><label for="m">남자</label>
		<input type="radio" name="mi_gender" value="m" id="m" checked/>
		<label for="f">여자</label>
		<input type="radio" name="mi_gender" value="f" id="f"/>
		</td>
		</tr>
		<tr>
		<th><span>생년월일</span></th>
		<td>
		<select name="by" onchange="resetday(this.value, this.form.bm.value, this.form.bd);" style="padding:2px; width:60px; height:30px; border:pink; text-align:center;">
		<% for (int i = 1930; i <= cyear; i++){ %>
			<option value="<%=i %>" <% if (i== cyear) { %> selected=selected<% } %>><%=i %></option>
		<%} %>
		</select>년
		<select name="bm" onchange="resetday(this.form.by.value, this.value, this.form.bd);" style="padding:1px; width:40px; height:30px; border:pink; text-align:center;">
		<% for (int i = 1; i <= 12 ; i++){ 
			String bm = i + "";
			if (i < 10){ bm = "0" + i; }
			%>
			<option value="<%=bm %>" <% if (i== cmon) { %> selected=selected<% } %>><%=bm %></option>
		<% } %>
		</select>월
		<select name="bd" style="padding:1px; width:40px; height:30px; border:pink; text-align:center;">
		<% for (int i = 1; i <= lastDay  ; i++){
			String bd = i + "";
			if (i < 10){ bd = "0" + i; } %>
			<option value="<%=bd %>" <% if (i== cday) { %> selected=selected<% } %>><%=bd %></option>
		<% } %>
		</select>일
		</td></tr>
		<tr>
		<th><span>휴대폰</span></th>
		<td>
		<select name="p1" style="padding:1px; width:50px; height:30px; border:pink; text-align:center;">
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="019">019</option>
		</select> - <input type="text" name="p2" id="p2" size="1" maxlength="4" style="padding:1px; width:50px; height:30px; border:pink; text-align:center;"/>
		- <input type="text" name="p3" id="p3" size="1" maxlength="4" style="padding:1px; width:50px; height:30px; border:pink; text-align:center;"/>
		</td>
		</tr>
		<tr>
		<th><span>이메일</span></th>
		<td><input type="text" name="e1" size="4" maxlength="20" style="padding:1px; width:80px; height:30px; border:pink;"/> @
		<input type="text" name="e3" id="e3" size="8" maxlength="20" readonly="true" style="padding:1px; width:90px; height:30px; border:pink;"/>
		<select name="e2" id="e2" style="padding:2px; width:100px; height:32px; border:pink;">
			<option value="" >도메인 선택</option>
			<% for (int i = 0 ; i < arrDomain.length ; i++){ %>
			<option value="<%=arrDomain[i] %>"><%=arrDomain[i] %></option>
			<%} %>
			<option value="direct">직접 입력</option>
		</select>
		</td>
		</tr>
		</table>
		<br/>
				
		<table>
		<tr>
		<th width="25%">
		우편번호</th><td><input type="text" id="postcode" name="ma_zip" size="5" maxlength="5" style="padding:1px; padding-bottom:0px; width:80px; height:30px; border:pink; text-align:center" readonly="readonly"/>
		<input type="button" value="우편번호 검색" onclick="execDaumPostcode();" style="padding:1px; width:107px; height:30px; background:pink; border:pink; text-align:center"/></td>
		</tr>
		<tr>
		<th>주소</th><td><input type="text" name="ma_addr1" id="address" size="40" style="padding:1px; width:320px; height:30px; border:pink;" readonly="readonly"/></td></tr>
		<tr>
		<th>상세 주소</th><td><input type="text" name="ma_addr2" id="detailAddress" size="40" style="padding:1px; width:250px; height:30px; border:pink;"/> <input type="hidden" id="extraAddress" placeholder="참고항목" style="padding:1px; width:60px; height:30px; border:pink;">
		</td></tr>
		</table>
		<div id="wrap" style="display:none; border:1px solid; width:500px; height:300px; margin:5px 0; position:relative">
			<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer; position:absolute; right:0px; top:-1px; z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
		</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
// 우편번호 찾기 찾기 화면을 넣을 element
var element_wrap = document.getElementById('wrap');

function foldDaumPostcode() {
    // iframe을 넣은 element를 안보이게 한다.
    element_wrap.style.display = 'none';
}

function execDaumPostcode() {
    // 현재 scroll 위치를 저장해놓는다.
    var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
    new daum.Postcode({
        oncomplete: function(data) {
            // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();

            // iframe을 넣은 element를 안보이게 한다.
            // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
            element_wrap.style.display = 'none';

            // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
            document.body.scrollTop = currentScroll;
        },
        // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
        onresize : function(size) {
            element_wrap.style.height = size.height+'px';
        },
        width : '100%',
        height : '100%'
    }).embed(element_wrap);

    // iframe을 넣은 element를 보이게 한다.
    element_wrap.style.display = 'block';
}
</script>
		<br/>
		<div align="center">
			<input type="submit" name="submit" value="회원가입" style="padding:1px; width:200px; height:40px; background:pink; border:pink;"/>
		</div>
	</div>
</form>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>