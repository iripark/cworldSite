<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
String piid = request.getParameter("piid");
PdtInfo pdtInfo = (PdtInfo)request.getAttribute("pdtInfo");
String jjimOX = (String)request.getAttribute("jjimOX");
ArrayList<PdtStock> pdtStockList = pdtInfo.getStockList();
ArrayList<ReviewInfo> reviewList = (ArrayList<ReviewInfo>)request.getAttribute("reviewList");
int realPrice = pdtInfo.getPi_price();
if (pdtInfo.getPi_dc() > 0){
	realPrice = pdtInfo.getPi_price()*(100 - pdtInfo.getPi_dc())/100;
}
Cookie cookie = new Cookie(piid, pdtInfo.getPi_img1());
cookie.setMaxAge(-1);   
response.addCookie(cookie);
%>
<style>
.star-ratings {
  color: #aaa9a9; 
  position: relative;
  unicode-bidi: bidi-override;
  width: max-content;
  -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
  -webkit-text-stroke-width: 1.3px;
  -webkit-text-stroke-color: #2b2a29;
}

.star-ratings-fill {
  color: #fff58c;
  padding: 0;
  position: absolute;
  z-index: 1;
  display: flex;
  top: 0;
  left: 0;
  overflow: hidden;
  -webkit-text-fill-color: gold;
}

.star-ratings-base {
  z-index: 0;
  padding: 0;
}
</style>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<script>

function buy(chk){
	// [장바구니 담기](c) 또는 [바로 구매](d) 버튼 클릭시 작업할 함수
	var frm = document.frmPdtDetail;	
	<%if (isLogin) { %>
		var opt = frm.ps_opt.value;
		if(<%=pdtStockList.get(0).getPs_opt().equals("r")%>){
			var period = frm.period.value;
		} else if (opt == ""){
			alert("옵션을 선택하세요."); return;
		}
		var cnt = parseInt(frm.cnt.value);
		var opt_cnt = frm.opt_cnt;
		if (opt_cnt[0].value != ""){
			if (cnt > opt_cnt[0].value){
				alert('재고가 선택하신 수량보다 적습니다.');
				return;
			}
		}
		
		if(chk == 'c'){
			var pi = "<%=pdtInfo.getPi_id() %>";
			var cnt = frm.cnt.value;
			$.ajax({
				type : "POST",			// 데이터 전송방법
				url : "/cworldSite/cart_proc_in",	// 전송한 데이터를 받을 서버의 URL로 컨트롤러(서블릿)를 의미
				data : {"piid" : pi , "psidx" : opt, "count" : cnt, "period" : period },
				success : function(chkRs){	// 장바구니 담기에
					if (chkRs == 0){	// 장바구니 담기에 실패했을 경우
						alert("장바구니 담기에 실패했습니다. 다시 시도해보세요.");
						return;
					} else {			// 장바구니 담기에 성공했을 경우
						if(confirm("장바구니에 담았습니다. \n장바구니로 이동하시겠습니까?")){
							location.href = "cart_view";
						}
					}
				}
			});
		} else {
			frm.action = "order_form";
			frm.submit();
		}	
	<%} else { %>
		var qs = "<%=request.getQueryString().replace('&', '$')%>";
		location.href="login_form.jsp?url=/cworldSite/product_view?" + qs;
	<%} %>	
}

$(function () {
	var curdate = new Date();
	var sdate = new Date();
	var exdate = new Date();
	sdate.setDate(curdate.getDate() + 1);
	exdate.setDate(curdate.getDate() + 3);
	$('input[name="period"]').daterangepicker({
	    "locale": {
	        "format": "YYYY-MM-DD",
	        "separator": " ~ ",
	        "applyLabel": "확인",
	        "cancelLabel": "취소",
	        "fromLabel": "From",
	        "toLabel": "To",
	        "customRangeLabel": "Custom",
	        "weekLabel": "W",
	        "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
	        "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
	    },
	    "minDate": sdate,
	    "maxSpan": {"days": 9 },
	    "startDate": sdate,
	    "endDate": exdate,
	    "drops": "down",
	    "alwayShowCalendars":true
	}, function (start, end, label) {
	    console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
	});
});

$(document).ready(function(){
	$("#img1, #img2, #img3").on("mouseover",function(){
		$("#bigImg").attr("src",$(this).attr("src"));
		// #bigImg 객체의 src 속성 값을 변경
		// 이벤트를 일으킨 객체(this)의 src 속성 값을 #bigImg 객체의 src 속성에 넣음
	});
});
var diff = 2;
function howLong(obj){
	var arr = obj.value.split(" ~ ");
	var sDay = new Date(arr[0]);
	var eDay = new Date(arr[1]);
	diff = (eDay - sDay)/(24*60*60*1000);
	if( diff < 2 ){
		eDay.setDate(sDay.getDate() + 2);
		arr[0] = sDay.getFullYear() + "-" + ((sDay.getMonth() + 1) > 9 ? (sDay.getMonth() + 1).toString() : "0" + (sDay.getMonth() + 1)) + "-" + (sDay.getDate() > 9 ? sDay.getDate().toString() : "0" + sDay.getDate().toString());
		arr[1] = eDay.getFullYear() + "-" + ((eDay.getMonth() + 1) > 9 ? (eDay.getMonth() + 1).toString() : "0" + (eDay.getMonth() + 1)) + "-" + (eDay.getDate() > 9 ? eDay.getDate().toString() : "0" + eDay.getDate().toString());
		obj.value = arr[0] + ' ~ ' + arr[1];
		diff = 2
		alert('최소 선택기한은 2박 3일 입니다.');
	}
	$(".periods").html( diff + "박 " + (diff + 1) + "일" );
	$("#pPrice").html(diff/2*<%=realPrice%>);
	$("#total").html(diff/2*<%=realPrice%> + <%=pdtInfo.getPi_dfee()%>);
}
function setCount(chk){
	var real = <%=realPrice%>;
	var fr = document.frmPdtDetail;
	var cnt = parseInt(fr.cnt.value);
	var dfee = <%=pdtInfo.getPi_dfee()%>
		
	if(chk == "+" && cnt < 100)		{	fr.cnt.value = cnt + 1;	} 
	else if(chk == "-" && cnt > 1) 	{	fr.cnt.value = cnt - 1; }

	var total = document.getElementById("total");
	total.innerHTML = ((real + dfee) * fr.cnt.value) / 2 * diff;
}

$(function () {
	$('.pdtVDiv > a').click(function (){
    	$('html, body').animate({scrollTop: $(this.hash).offset.top}, 300);
    });
});

function jjimClick(){
	if ('<%=loginInfo%>' == 'null'){
		alert('로그인 후 이용가능합니다.');
		return;
	} else {
		var piid = "<%=pdtInfo.getPi_id()%>";
		$.ajax({
			type : "POST",			// 데이터 전송방법
			url : "/cworldSite/jjim_proc",	// 전송한 데이터를 받을 서버의 URL로 컨트롤러(서블릿)를 의미
			data : {"piid" : piid },
			success : function(chkjj){	// 장바구니 담기에
				location.reload();
			}
		});	
	}
}

</script>
</head>
<body>
<div class="content pdtview" align="center">
<br/>
<h2 align="left">상품 상세 화면</h2>
<br/>
<table width="900" cellpadding="5">
<tr>
	<td width="300">
	<table width="100%" >
		<tr><td colspan="3" align="center">
		<img src="/cworldSite/pdt_img/<%=pdtInfo.getPi_img1()%>" width="280" height="280" id="bigImg"  style="margin:3px;"/></td></tr>
		<tr>
			<td>
			<table width="100%" style="margin-bottom:36px; border:3px pink solid;">
			<tr style=" border:1px pink solid;">
			<td width="33.3%" align="center">
			<img src="/cworldSite/pdt_img/<%=pdtInfo.getPi_img1()%>" width="90" height="90" id="img1"	onclick="showBig('<%=pdtInfo.getPi_img1()%>')"/></td>
			<% if (pdtInfo.getPi_img2() != null && !pdtInfo.getPi_img2().equals("")){ %>
			<td width="33.3%" align="center">
			<img src="/cworldSite/pdt_img/<%=pdtInfo.getPi_img2()%>" width="90" height="90" id="img2"	onclick="showBig('<%=pdtInfo.getPi_img2()%>')"/></td>
			<%}else{ %><td width="33.3%"></td><%} %>
			<% if (pdtInfo.getPi_img3() != null && !pdtInfo.getPi_img3().equals("")){ %>
			<td width="33.3%" align="center">
			<img src="/cworldSite/pdt_img/<%=pdtInfo.getPi_img3()%>" width="90" height="90" id="img3"	onclick="showBig('<%=pdtInfo.getPi_img3()%>')"/></td>
			<%}else{ %><td width="33.3%"></td><%} %>
			</tr>
			</table>
	</table></td>
<td width="*">
	<form name ="frmPdtDetail" action="order_cart" method="post">
	<input type="hidden" name="kind" value="d"/>
	<input type="hidden" name="piid" value="<%=piid%>"/>
	<table width="100%" cellpadding="10">
	<tr>
	<th colspan="2" height="60" style="font-size:1.5em; font-weight:bold; border-bottom:3px pink solid; text-align:center;">
		<a href="product_list?cpage=1&pcb=<%=pdtInfo.getPcb_id() %>">
		<%=pdtInfo.getPcbName() %></a>&nbsp; ->&nbsp; 
		<a href="product_list?cpage=1&pcb=<%=pdtInfo.getPcb_id() %>&pcs=<%=pdtInfo.getPcs_id() %>">
		<%=pdtInfo.getPcsName() %></a></th>
	</tr>
	<tr height="60">
	<th width="30%" style="text-align:center;">상품명</th><td width="*">
	<% String conABCD = pdtInfo.getPi_special();
	if(conABCD != null && !conABCD.equals("")){
		if (conABCD.contains("a")){%>	<img src="/cworldSite/img/icon_special_best.png" width="30" height="20"/>	<% 	} 
		if (conABCD.contains("b")){	%>	<img src="/cworldSite/img/icon_special_new.png" width="30" height="20"/>	<% 	} 
		if (conABCD.contains("c")){	%>	<img src="/cworldSite/img/icon_special_hot.png" width="30" height="20"/>	<% 	} 
		if (conABCD.contains("d")){%>	<img src="/cworldSite/img/icon_special_sale.png" width="30" height="20"/>	<% 	} 
	}	%>
	<%=pdtInfo.getPi_name() %></td>
	</tr>
	<tr height="60">
	<th style="text-align:center;">구매후기</th><td>
	<div class="star-ratings" style="display:inline-block;">
		<div class="star-ratings-fill space-x-2 text-lg" style="width: <%=pdtInfo.getPi_score()*20 %>%;">
			<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
		</div>
		<div class="star-ratings-base space-x-2 text-lg">
			<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
		</div>
	</div>
	
	 (<%=pdtInfo.getPi_score() %>&nbsp;/&nbsp;5.0)
	<a href="#pr3"><span style="color:blue; margin-left:10px;">(후기 <%=pdtInfo.getPi_review() %> 개)</span></a>
	<span style="color:red; margin-left:10px;">주문 <%=pdtInfo.getPi_srcnt() %> 건</span>
	</td>
	</tr>
<% if (piid.charAt(0) == 'R' || piid.charAt(0) == 'P'){ %>
	<tr>
	<th height="60" style="text-align:center;">가격</th><td>
	<%if (pdtInfo.getPi_dc() > 0) {%>
		할인전 : <del><%=pdtInfo.getPi_price() %>원</del>&nbsp;&nbsp;
		할인율 : <%=pdtInfo.getPi_dc() %>%!! &nbsp;&nbsp;<br/>
	<%} %>
		2박 3일 기준가 : <span id="price"><%=realPrice %></span>원<br/>
		<span class="periods"></span> 가격 : <span id="pPrice"></span>원<br/>
	</td>
	</tr>
	<tr>
	<th height="60" style="text-align:center;">배송비</th><td><%=pdtInfo.getPi_dfee() %>원</td></tr>
	<tr>
	<th height="45" style="text-align:center;">대여기간</th><td>	
	<input type="text" name="period" id="period" value="" size="20" onchange="howLong(this);"/>
	&nbsp;&nbsp;&nbsp;<span class="periods"></span><br/>
	(대여가능 상품 수 : <input type="text" name="opt_cnt" value="<%=pdtStockList.get(0).getPs_stock() %>" size="1" readonly="readonly" style="border:0px; background:0px;" /> 개 남음)
	<input type="hidden" name="ps_opt" value="<%=pdtStockList.get(0).getPs_idx() %>"/>
	<br/> 
	</td>
	<%} else { %>
	<tr>
	<th height="60" style="text-align:center;">가격</th><td>
	<%if (pdtInfo.getPi_dc() > 0) {%>
		할인전 : <del><%=pdtInfo.getPi_price() %>원</del>&nbsp;&nbsp;
		할인율 : <%=pdtInfo.getPi_dc() %>%!! &nbsp;&nbsp;<br/>
	<%} %>
		판매가 : <span id="price"><%=realPrice %></span>원</td>
	</tr>
	<tr>
	<th height="60" style="text-align:center;">배송비</th><td><%=pdtInfo.getPi_dfee() %>원</td></tr>
	<tr>
	<th height="40" style="text-align:center;">옵션</th><td>
	<select name="ps_opt">
		<option value="" align="center">옵션 선택</option>
	<% for(int i = 0; i < pdtStockList.size(); i ++){ 
		String oTmp = "";
		if(pdtStockList.get(i).getPs_opt().equals("a")) oTmp="빨강";
		else if(pdtStockList.get(i).getPs_opt().equals("b")) oTmp="파랑";
		else if(pdtStockList.get(i).getPs_opt().equals("c")) oTmp="검정";
		else if(pdtStockList.get(i).getPs_opt().equals("d")) oTmp="";
			
		String tmp = oTmp + " (재고량 : " + pdtStockList.get(i).getPs_stock() + "개 남음)";
		String disabled = "";
		if(pdtStockList.get(i).getPs_stock() <= 0) {
			disabled = " disabled='disabled'";
			tmp = oTmp + " (품절) ";
		}
	%>
		<option value="<%=pdtStockList.get(i).getPs_idx() %>" align="center" <%=disabled %>><%=tmp %>
		</option>
	<%} %>
	</select></td>
	<%} %>
	</tr>
	<tr>
	<th height="40" style="text-align:center; border-bottom:1px pink double;">수량</th>
	<td style="border-bottom:1px pink double;">
	<input type="button" id="deCnt" name="opt" value="-"  onclick="setCount(this.value);"/>
	<input type="text" name="cnt" id="cnt" style="width:30px; text-align:right;" value="1" readonly="true"/>
	<input type="button" id="asCnt" name="opt" value="+" onclick="setCount(this.value);"/>
	</td>
	</tr>
	<tr>
	<td colspan="2" align="right" height="40" style="font-size:1.2em; font-weight:bold;">
		<%=(piid.charAt(0) == 'S'? "구매" : "대여")%>가격 :<span id="total">	<%=realPrice + pdtInfo.getPi_dfee()%></span>원</td>
	</tr>
	<tr><td align="center" height="60" colspan="2">
	<%  boolean isSoldout = true;
		for(int i = 0; i < pdtStockList.size(); i ++){  
			if (pdtStockList.get(i).getPs_stock() > 0){
				isSoldout = false;
			}
		}
		if(isSoldout){	%>
		<input type="button" value="바로 <%=(piid.charAt(0) == 'S'? "구매" : "대여")%>(품절)" class="smt" style="width:150px; height:40px; background:darkgray; border:0; font-size:1.2em;"/>&nbsp;&nbsp;
	<input type="button" value="장바구니 담기(품절)" class="smt" style="width:150px; height:40px; background:darkgray; border:0; font-size:1.2em;"/>&nbsp;&nbsp;
	<%} else { %>
		<input type="button" value="바로 <%=(piid.charAt(0) == 'S'? "구매" : "대여")%>" class="smt" onclick="buy('d');" style="width:150px; height:40px; background:lightpink; border:0; font-size:1.2em;"/>&nbsp;&nbsp;
	<input type="button" value="장바구니 담기" class="smt" onclick="buy('c');" style="width:150px; height:40px; background:pink; border:0; font-size:1.2em;"/>&nbsp;&nbsp;
	<%} %>
	<div onclick="jjimClick();" style="border:1px pink solid; width:150px; height:30px; display:inline-block; padding-top:10px;">
	<img src="/cworldSite/img/icon-jjim<%=jjimOX %>.png" width="20" height="20" style="vertical-align: middle;"/>
	<span style="vertical-align: bottom; font-size:1.2em;">&nbsp;좋아요 &nbsp;<%=pdtInfo.getPi_jjim() %> </span></div></td>
	</tr>
	</table>
	<input type="hidden" name="opt_cnt" value=""/>
	<input type="hidden" name="opt_cnt" value=""/>
	</form>
	</td>
	</tr>
	</table>
	<br/><br/><br/><br/>
	
<div class="pdtVDiv">
	<a href="#pd1"><div id="pd1" class="pd pvd1" style="background:green; color:#fff;">상품 상세정보</div></a><a href="#pb2"><div id="pb1" class="pb pvd1" style="background:pink;">상품 구매안내</div></a><a href="#pr3"><div id="pr1" class="pr pvd1" style="background:pink;">상품 사용후기</div></a>
</div>
<div class="pdtvc">
	<img src="/cworldSite/pdt_img/<%=pdtInfo.getPi_desc()%>" width="900"  id="descImg" style="min-height:400px;"/>
</div>
<br/><br/><br/>
<div class="pdtVDiv">
	<a href="#pd1"><div id="pd2" class="pd pvd2" style="background:pink;">상품 상세정보</div></a><a href="#pb2"><div id="pb2" class="pb pvd2" style="background:green; color:#fff;">상품 구매안내</div></a><a href="#pr3"><div id="pr2" class="pr pvd2" style="background:pink;">상품 사용후기</div></a>
</div>	
<div class="pdtvc">	
	<img src="/cworldSite/img/order_notice.png" width="900" style="padding:0; margin:0;"/>
</div>
<br/><br/><br/>
<div class="pdtVDiv">
	<a href="#pd1"><div id="pd3" class="pd pvd3" style="background:pink;">상품 상세정보</div></a><a href="#pb2"><div id="pb3" class="pb pvd3" style="background:pink;">상품 구매안내</div></a><a href="#pr3"><div id="pr3" class="pr pvd3" style="background:green; color:#fff;">상품 사용후기</div></a>
</div>
<div class="pdtvc" id="pdtReviewBox">
<%if (reviewList.size() > 0 ) { %>
	<table width="100%">
<%	for (int i = 0 ; i < reviewList.size() ; i++ ){
		ReviewInfo ri = reviewList.get(i); %>
		<tr><td class="pvrt"><br/>
		<span style="font-size:1.2em; font-weight:bold;"><%=ri.getMi_id() %></span> 
		<span style="color:gray;"><%=ri.getRl_date() %></span>
		&nbsp;&nbsp; 
		<div class="star-ratings" style="display:inline-block;">
			<div class="star-ratings-fill space-x-2 text-lg" style="width: <%=ri.getRl_score()*20 %>%;">
				<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
			</div>
			<div class="star-ratings-base space-x-2 text-lg">
				<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
			</div>
		</div>&nbsp;
		( <%=ri.getRl_score() %> / 5.0 )<br/>
		 <%=ri.getRl_pname() %><br/><br/></td></tr>
		<%if (!ri.getRl_img().equals("")){ %>
		<tr><td class="pvrt">
		<img src="/cworld_admin/upload_review/<%=ri.getRl_img() %>" width="200" height="200" border="0"/></td></tr>
		<%}  %>
		<tr><td class="pvrt" style="border-bottom:pink 1px solid"><br/><%=ri.getRl_title() %><br/><br/><%=ri.getRl_content() %><br/><br/></td></tr>	
<%	} %>
	</table>
<%} else {%>
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>작성된 이용후기 정보가 없습니다.
<%} %>
</div>

</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>