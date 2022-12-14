<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<script>

function chkAll(all){
	var arrTerms = document.frmCt.terms;
	for (var i = 0 ; arrTerms.length ; i++ ){
		arrTerms[i].checked = all.checked;
	}
}
function chk(num){
	var arrTerms = document.frmCt.terms;
	var allChk = document.frmCt.all;
	if (arrTerms[num-1].checked == false){	
		allChk.checked = arrTerms[num-1].checked; 
	}
	var arrChk = Boolean(true);
	for (var i = 0 ; i < arrTerms.length ; i++ ){
		if(arrTerms[i].checked == false ){
			arrChk = false;
		}
	}
	allChk.checked = arrChk;
}
function chkVal(fr){
	var chk = fr.terms;
	if (chk[0].checked == true && chk[1].checked == true){
			return true;
	} else {
		alert('필수항목을 체크해주세요.');
		return false;
	}
}

</script>
<body>
<div class="content">
<br/><br/>
<form name="frmCt" method="post" action="join_form.jsp" onsubmit="return chkVal(this);">
<span class="terms_title1"><input type="checkbox" name="all" value="all" id="all" onclick="chkAll(all);"/></span><span class="allterms"><label for="all">C월드 이용약관, 개인정보 수집 및 이용, 위치기반 서비스 이용약관(선택), 프로모션 정보 수신(선택)에 모두 동의합니다.</label></span>
<div class="terms_title" id="pos_terms"><input type="checkbox" name="terms" value="c1" id="c1" onclick="chk(1);"/>&nbsp; <label for="c1">C월드 이용약관 동의<span class="essential">(필수)</span></label></div>
<div class="terms">C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의C월드 이용약관 동의</div>
<br/>
<div class="terms_title"><input type="checkbox" name="terms" value="c2" id="c2" onclick="chk(2);"/>&nbsp; <label for="c2">개인정보 수집 및 이용 동의<span class="essential">(필수)</span></label></div>
<div class="terms">개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의개인정보 수집 및 이용 동의</div>
<br/>
<div class="terms_title"><input type="checkbox" name="terms" value="c3" id="c3" onclick="chk(3);"/>&nbsp; <label for="c3">위치기반 서비스 이용약관 동의<span class="optional">(선택)</span></label></div>
<div class="terms">위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 서비스 이용약관 동의위치기반 </div>
<br/>
<div class="terms_title"><input type="checkbox"  name="terms" value="c4"  id="c4" onclick="chk(4);"/>&nbsp; <label for="c4">프로모션 정보 수신 동의<span class="optional">(선택)</span></label></div>
<div class="terms">프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의프로모션 정보 수신 동의</div>
<br/>
<div id="tbtn">
<input type="submit" value="동의" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="취소" onclick="history.back();"/>
</div>
</form>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>