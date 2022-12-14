<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#addrInBox { 
	border-collapse:collapse; border-bottom:1px solid black; border-right:1px solid black;
	border-top:1px solid black; border-left:1px solid black;
 }
#addrInBox th, #addrInBox td { padding:8px 3px; }
</style>
<script>
function chkJVal(fr){
	var name = fr.ma_name.value;
	var receiver = fr.ma_receiver.value;
	var phone1 = fr.p2.value;
	var phone2 = fr.p3.value;
	var zip = fr.ma_zip.value;
	var addr1 = fr.ma_addr1.value;
	var addr2 = fr.ma_addr2.value;
	if (name != "" && receiver != "" && phone1.length() > 2 && phone2.length() > 2 && zip.length() == 5 && addr1 != "" && addr2 != ""){
			return true;
	} else {
		alert('작성하지 않은 항목이 있습니다. 확인해주세요.');
		return false;
	}
}
</script>
</head>
<body>
<form name="frmAddrIn" action="addr_proc_in" method="post" onsubmit="return chkJVal(this);">
<div class="content" align="center">
<div style="font-size:2em; font-weight:bold; margin:20px; display:inline-block; 
width:600px; text-align:left;">배송지 등록</div>
<table width="600" id="addrInBox">
<tr>
<th width="15%">&nbsp;배송지명</th>
<td><input type="text" name="ma_name" style="padding:1px; width:192px; height:30px; border:pink;"/></td>
</tr>
<tr>
<th width="15%">&nbsp;이름</th>
<td><input type="text" name="ma_receiver" style="padding:1px; width:192px; height:30px; border:pink;"/></td>
</tr>
<tr>
<th width="15%">&nbsp;우편번호</th>
<td><input type="text" id="postcode" name="ma_zip" size="5" maxlength="5" style="padding:1px; padding-bottom:0px; width:80px; height:30px; border:pink; text-align:center" readonly="readonly"/> 
<input type="button" value="우편번호 검색" onclick="execDaumPostcode();" style="padding:1px; width:107px; height:30px; background:pink; border:pink; text-align:center"/></td>
</tr>
<tr>
<th>&nbsp;주소</th>
<td><input type="text" name="ma_addr1" id="address" size="40" style="padding:1px; width:320px; height:30px; border:pink;" readonly="readonly"/></td>
</tr>
<tr>
<th>&nbsp;상세주소</th>
<td><input type="text" name="ma_addr2" id="detailAddress" size="40" style="padding:1px; width:320px; height:30px; border:pink;"/> <input type="hidden" id="extraAddress" placeholder="참고항목" style="padding:1px; width:63px; height:30px; border:pink;">
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
</td>
</tr>
<tr>
<th></th>
<td><input type="checkbox" name="ma_basic" id="ma_basic" value="y" /><label for="ma_basic">&nbsp;기본 배송지로 지정</label></td>
</tr>
<tr>
<th>&nbsp;휴대폰</th>
<td>
<select name="p1" style="padding:1px; width:50px; height:30px; border:0px;">
	<option value="010">010</option>
	<option value="011">011</option>
	<option value="016">016</option>
	<option value="019">019</option>
</select> - <input type="text" name="p2" id="p2" size="1" maxlength="4" style="width:50px; height:28px; text-align:center; border:0px;"/> - <input type="text" name="p3" id="p3" size="1" maxlength="4" style="width:50px; height:28px; text-align:center; border:0px;"/>
</td>
</tr>
</table>
<br />
<input type="submit" value="배송지 등록" style="width:150px; height:40px; background:pink; border:0px;"/>
</div>
</form>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>