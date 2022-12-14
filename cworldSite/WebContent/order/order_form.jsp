<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
if(!isLogin){
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어오셨습니다.'); history.back();");
	out.println("</script>");
	out.close();	
}
request.setCharacterEncoding("utf-8");
ArrayList<OrderCart> buyList = (ArrayList<OrderCart>)request.getAttribute("buyList");
ArrayList<MemberAddr> addrList = (ArrayList<MemberAddr>)request.getAttribute("addrList");
int mipoint = (int)request.getAttribute("mipoint");

if(!isLogin || buyList.size() == 0 || addrList.size() == 0){
// 로그인이 안됐거나, 구매할 상품이 없거나, 배송지 정보가 없으면
	out.println("<script> alert('잘못된 경로로 들어오셨습니다.'); history.back(); </script>");
	out.close();	
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function chkJVal(fr){
	var name = fr.oi_rname.value;
	var p1 = fr.p2.value;
	var p2 = fr.p3.value;
	var zip = fr.oi_rzip.value;
	var addr1 = fr.oi_raddr1.value;
	var payment = fr.oi_payment.value;
	if (name.length < 2){		alert('이름을 확인하세요.');		return false;	}
	if (p1.length < 3 || p2.length < 3){ alert('전화번호를 확인하세요.');		return false; }
	if (zip.length != 5 || addr1.length < 2){ alert('주소를 확인하세요.');		return false; }
	if (payment == null || payment == ""){  alert('결제방법을 선택하세요.');		return false;  }
		return true;
}
function chAddr(val){
	var frm = document.frmOrder;
	var arr = val.split("|");
	frm.oi_rname.value = arr[0];
	frm.p1.value = arr[1];
	frm.p2.value = arr[2];
	frm.p3.value = arr[3];
	frm.oi_rzip.value = arr[4];
	frm.oi_raddr1.value = arr[5];
	frm.oi_raddr2.value = arr[6];
}
$(document).ready(function(){
	$("#upoint").change(function(){
		$("#upoint").val($("#upoint").val().replace(/[^0-9]/g,''));
		if ($("#upoint").val() > <%=mipoint %>){
			$("#upoint").val(<%=mipoint %>);
		}
		$("#uPointView").html($("#upoint").val());
		$("#orderPrice").html($("#total").html() - $("#upoint").val());
	});
});
</script>
</head>
<body>
<div class="content" align="center">
<h2>대여 및 판매 상품 주문</h2>
<table width="800" cellpadding="5" border="1">
<tr align="center"><td>상품이미지</td><td>상품명</td><td>구매/대여</td><td>옵션</td><td>수량</td><td>가격</td><td>배송료</td></tr>
<%	
String ocidxs = "";
int total = 0; // 총 구매가격의 누적치를 저장할 변수
int totalP = 0;	// 총 상품가격
int totalD = 0;	// 총 배송비용
for (int i = 0 ; i < buyList.size(); i++){ 
	OrderCart oc = buyList.get(i);
	int ocidx = oc.getOc_idx();
	ocidxs += "," + ocidx;
	int realPrice = oc.getPi_price() * oc.getOc_cnt();
	int dfeeByCnt = oc.getPi_dfee() * oc.getOc_cnt();
	if (oc.getPi_dc() > 0){
		realPrice = (oc.getPi_price()*(100 - oc.getPi_dc())/100) * oc.getOc_cnt();
	}
	String optName = "";
	String rentOrBuy = "구매";
	  if(oc.getPs_opt().equals("a"))  		optName = "빨강";
	  else if(oc.getPs_opt().equals("b"))	optName = "파랑";
	  else if(oc.getPs_opt().equals("c"))	optName = "검정";
	  else if(oc.getPs_opt().equals("d"))	optName = "텐트 외 상품";
	  else {
		  realPrice = realPrice/2 * oc.getOcr_period();
		  optName = "(" + oc.getOcr_sdate() + " ~ " + oc.getOcr_edate() + ")" +
		  "<br/>" + oc.getOcr_period() + "박" + (oc.getOcr_period() + 1) + "일";
		  rentOrBuy = "대여";
		  
	  }
%>
<tr align="center">
<%
   String pdtImg = oc.getPi_img1();
   if (oc.getPs_opt().equals("b")) pdtImg = pdtImg.substring(0, 6) + 2 + pdtImg.substring(7);
   else if (oc.getPs_opt().equals("c")) pdtImg = pdtImg.substring(0, 6) + 3 + pdtImg.substring(7);%>
<td width="15%"><img src="pdt_img/<%=pdtImg %>" width="100" height="100"/></td>
<td width="15%"><%=oc.getPi_name()%></td>
<td width="10%"><%=rentOrBuy %></td>
<td width="20%"><%=optName %></td>
<td width="5%"><%=oc.getOc_cnt() %></td>
<td width="10%"><%=realPrice %>원</td>
<td width="10%"><%=dfeeByCnt%>원</td>
</tr>
<%		totalP += realPrice;
		totalD += dfeeByCnt; 
		total = totalP + totalD; 
} 
ocidxs = (ocidxs.indexOf(',') >= 0 ? ocidxs.substring(1) : ocidxs);
%>
</table>
<br/><p align="center" style="width:500px; font-size:20px;">
선택상품 금액&nbsp;&nbsp;&nbsp;+&nbsp;&nbsp;&nbsp;총 배송비&nbsp;&nbsp;&nbsp;=&nbsp;&nbsp;&nbsp;주문금액
<br> <%=totalP %>원&nbsp;&nbsp;&nbsp;+&nbsp;&nbsp;&nbsp;<%=totalD %>원&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;<%=total %>원 </p><br/><br/><br/>
<hr/>
<h2>배송지 정보</h2>
<form name="frmOrder" action="order_proc_in" method="post" onsubmit="return chkJVal(this);">
<input type="hidden" name="total" value="<%=total %>" />
<input type="hidden" name="kind" value="<%=request.getParameter("kind") %>" />
<input type="hidden" name="piid" value="<%=request.getParameter("piid") %>" />
<input type="hidden" name="opt" value="<%=request.getParameter("opt") %>" />
<input type="hidden" name="ocidxs" value="<%=ocidxs %>" />
<input type="hidden" name="ps_idx" value="<%=buyList.get(0).getPs_idx() %>" />
<input type="hidden" name="baro_cnt" value="<%=buyList.get(0).getOc_cnt() %>" />
<input type="hidden" name="period" value="<%=buyList.get(0).getOcr_sdate()%> ~ <%=buyList.get(0).getOcr_edate()%>"/>


<table width="800" cellpadding="5">
<tr height="50"><th width="30%" align="center">배송지 선택</th>
<td width="*">
	<select onchange="chAddr(this.value);">
<%
String rname = "", zip = "", addr1 = "", addr2 = "";
String[] phone = new String[3];
for (int i = 0; i < addrList.size() ; i++ ){
	MemberAddr ma = addrList.get(i);
	if ( i == 0){
		rname = ma.getMa_receiver();
		phone = ma.getMa_phone().split("-");
		zip = ma.getMa_zip();
		addr1 = ma.getMa_addr1();
		addr2 = ma.getMa_addr2();
	}
	String tmp = ma.getMa_receiver() + "|" + ma.getMa_phone().replace('-','|');
	tmp += "|" + ma.getMa_zip() + "|" + ma.getMa_addr1() + "|" + ma.getMa_addr2();
	
	out.println("<option value = \"" + tmp + "\">");
	out.println(ma.getMa_name() + " - " + ma.getMa_addr1() + " " + ma.getMa_addr2());
	out.println("</option>");
}
%>
	</select>
</td>
</tr>
<tr height="50">
<th >수취인명</th><td><input type="text" name="oi_rname" size="12" value="<%=rname %>" /></td>
</tr>
<tr height="50"><th>전화번호</th>
<td >
	<select name="p1">
		<option value="010" <%if(phone[0].equals("010")){%> selected="selected" <% } %>>010</option>
		<option value="011" <%if(phone[0].equals("011")){%> selected="selected" <% } %>>011</option>
		<option value="016" <%if(phone[0].equals("016")){%> selected="selected" <% } %>>016</option>
		<option value="019" <%if(phone[0].equals("019")){%> selected="selected" <% } %>>019</option>	
	</select> -
	<input type="text" name="p2" value="<%=phone[1] %>" onkeyup="onlyNum(this);" size="1" maxlength="4"/>
	- <input type="text" name="p3" value="<%=phone[2] %>" onkeyup="onlyNum(this);" size="1" maxlength="4"/>
</td>
</tr>
<tr height="50">
<th>우편번호</th><td><input type="text" id="postcode" name="oi_rzip" value="<%=zip %>" size="5" maxlength="5" style="padding:1px; padding-bottom:0px; width:80px; height:30px; border:pink; text-align:center" readonly="readonly"/> 
<input type="button" value="우편번호 검색" onclick="execDaumPostcode();" style="padding:1px; width:107px; height:30px; background:pink; border:pink; text-align:center"/></td>
</tr>
<tr height="50">
<th rowspan="2">주소</th><td>	<input type="text" name="oi_raddr1" id="address" size="40" style="padding:1px; width:320px; height:30px; border:pink;" readonly="readonly" value="<%=addr1 %>"/></td>
</tr>
<tr height="50">
<td><input type="text" name="oi_raddr2" id="detailAddress" size="40" style="padding:1px; width:320px; height:30px; border:pink;" value="<%=addr2 %>"/> <input type="hidden" id="extraAddress" placeholder="참고항목" style="padding:1px; width:63px; height:30px; border:pink;">

<div id="wrap" style="display:none; border:1px solid; width:500px; height:300px; margin:5px 0; position:relative">
			<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer; position:absolute; right:0px; top:-1px; z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
</div>
</td>
</tr>
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
<tr>
<th>택배 메모</th>
<td><br/><textarea name="oi_memo" placeholder="배송시 요청사항을 입력해주세요."></textarea><br/></td>
</tr>
</table>
<br/><br/><br/>
<h2>결제 정보</h2>
<table width="800" cellpadding="5" border="1">
<tr align="center" height="50">
<td width="35%">총 추문 금액</td><td width="30%">소모 포인트</td><td width="30%">총 결제예정금액</td>
</tr>
<tr align="center" height="50"><td><span id="total"><%=total %></span> 원 </td>
<td><span id="uPointView">0</span> pt</td>
<td><span id="orderPrice"><%=total %></span> 원</td></tr>
<tr align="center">
	<td width="100%" height="50" colspan="3" align="center">
	포인트 사용 : <input type="text" name="upoint" id="upoint" style="text-align:right" value="0"/>pt
	(보유 포인트 :<%=mipoint %> pt )</td>
</tr>
<tr>
<td colspan="3" align="center" height="50">적립 예정 포인트 : <%=total/100*2 %> pt(총 주문금액의 2%)</td>
<input type="hidden" name="spoint" value="<%=total/100*2 %>"/>
</tr>
<tr  align="center"><td colspan="3">( 포인트 사용시 주의사항) </td></tr>
<tr><td colspan="3" align="center">결제 방법<br/><br/>
	<input type="radio" name="oi_payment" value="a" id="payA"/> 
	<label for="payA"> 카드 결제 </label> &nbsp;&nbsp;&nbsp;
	<input type="radio" name="oi_payment" value="b" id="payB"/>
	<label for="payB"> 휴대폰 결제 </label> &nbsp;&nbsp;&nbsp;
	<input type="radio" name="oi_payment" value="c" id="payC"/>
	<label for="payC"> 무통장 입금 </label><br/>
</td></tr>

</table>
<br/>
<p style="width:800px; text-align:center;">
	<input type="submit" value="결제하기"/>
	<br/><br/>
</p>
</form>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>