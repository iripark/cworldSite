<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<OrderCart> cartList = (ArrayList<OrderCart>)request.getAttribute("cartList");

if (!isLogin){
	out.println("<script>");
	out.println("alert('잘못된 경로입니다.');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}
%>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script> 
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<script>
function cartDel(ocidx){
// 장바구니 내의 특정 상품을 삭제하는 함수
   if(confirm("정말 삭제하시겠습니까?")){
      $.ajax({
         type : "POST",
         url : "/cworldSite/cart_proc_del",
         data : {"ocidx" : ocidx},
         success : function(chkRs){
            if(chkRs == 0){
               alert("상품 삭제에 실패했습니다. \n다시시도하세요");
            }
            location.reload();
         }
      });
   }
}

function cartUp(ocidx, opt, cnt){
// 장바구니 내의 특정 상품 옵션 및 수량을 변경시키는 함수
// cnt가 0이면 옵션 변경, opt가 빈문자열이면 수량 변경을 의미
   $.ajax({
      type : "POST",
      url : "/cworldSite/cart_proc_up",
      data : {"ocidx" : ocidx, "opt" : opt, "cnt" : cnt },
      success : function(chkRs){
         location.reload();
      }
   });
}

function setCount(chk, ocidx){
// 옵션 내 수량 변경	
	var frm = document.frmCart;
	var cnt = parseInt(eval("frm.cnt" + ocidx + ".value"));
	
	if(chk == "+" && cnt < 100){
		cartUp(ocidx, 0, cnt + 1);
	} else if ( chk == "-" && cnt > 1){
		cartUp(ocidx, 0, cnt - 1);
	}
}
function chkAll(obj){
   var arrOcidx = document.frmCart.ocidxs;   
   for(var i = 1; i < arrOcidx.length ; i++){
      arrOcidx[i].checked = obj.checked;
   }
}
function chkk(num){
   var arrOcidx = document.frmCart.ocidxs;
   var a = document.frmCart.all;
   if (arrOcidx[num].checked == false){
      a.checked = arrOcidx[num].checked;
   }
   // 다 체크되면 전체도 체크 되게
   var arrCh = true;
   for ( var i = 1; i < arrOcidx.length ; i++ ) { 
      if(arrOcidx[i].checked == false)   
         { arrCh = false; }
   }
   a.checked = arrCh;
}

 function getSelectedValues(){ // 체크 박스들 중 선택된 체크박스들의 값들을 쉼표로 구분하여 문자열로 리턴하는 함수
   chk = document.frmCart.ocidxs;
    var idxs = "";   // chk 배열에서 선택된 체크박스의 값들을 누적 저장할 변수
    for ( var i = 0 ; i < chk.length ; i++ ){
       if(chk[i].checked){
          idxs += "," + chk[i].value;
       }
    }
    return idxs.substring(1);
 }
 
 function chkDel(){ // 선택한 상품 삭제
   var ocidx = getSelectedValues(); // 위에 만든 함수
   // 선택한 oc_idx값들이 쉼표를 기준으로 ex) '1,2,3,4' 문자열로 저장됨
   if (ocidx == ""){
      alert("상품을 선택해주세요.");
   } else {
      cartDel(ocidx);
   }
 }
 
 function chkBuy(){   // 선택한 상품 구매
    var ocidx = getSelectedValues();
    if (ocidx == ""){
         alert("상품을 선택해주세요.");
      } else {
         document.frmCart.submit(ocidx);
         // 선택한 상품 데이터를 가지고 order_form으로 submit
      }
 }
 
 function allBuy(){   // 전체 상품 구매
   var arrOcidx = document.frmCart.ocidxs;   
   for(var i = 1; i < arrOcidx.length ; i++){
      arrOcidx[i].checked = true;
   }
   chkBuy();
 }


</script>
<style>
#cartTableBox td, #cartTableBox tr { border-collapse:collapse; border-bottom:1px solid black; }
</style>
</head>
<body>
<div class="content" align="center">
<form name="frmCart" method="post" action="order_form">
<input type="hidden" name="ocidxs" value=""/>
<input type="hidden" name="kind" value="c"/>
<br/><br/><div style="text-align:left; margin-left:50px;">
<span style="font-size:2em; font-weight:bold; ">장바구니</span></div><br/><br/>
<%if ( cartList.size() > 0 ){ %>
<table width="800" cellpadding="0" cellspacing="0" border="0" id="cartTableBox">
<tr align="center" height="45"><td><input type="checkbox" name="all" id="all" onclick="chkAll(this);" checked="checked"/></td>
<td>상품이미지</td><td>상품명</td><td>옵션</td><td>수량</td><td>가격</td><td>배송비</td><td>비고</td>
 <%int total = 0; // 총 구매가격의 누적치를 저장할 변수
   for (int i = 0 ; i < cartList.size(); i++){ 
      OrderCart oc = cartList.get(i);
      int ocidx = oc.getOc_idx();
      int realPrice = oc.getRealPrice();  
%>
<tr align="center">
<td width="5%">
<input type="checkbox" name="ocidxs" value="<%=oc.getOc_idx()%>" onclick="chkk(<%=i+1%>);" checked="checked"/>
</td><td width="15%">
   <a href="product_view?cpage=1&piid=<%=oc.getPi_id() %>">
   <%
   String pdtImg = oc.getPi_img1();
   if (oc.getPs_opt().equals("b")) pdtImg = oc.getPi_img2();
   else if (oc.getPs_opt().equals("c")) pdtImg = oc.getPi_img3();%>
   <img src="pdt_img/<%=pdtImg %>" width="100" height="100"/></a>
</td>
<td width="25%">
   <a href="product_view?cpage=1&piid=<%=oc.getPi_id() %>">
   <%=oc.getPi_name()%></a></td>
<td width="20%">
<% if (!oc.getPs_opt().equals("r")) {%>
<p align="center">구매 옵션</p><br/>
<select name="opt<%=ocidx%>" onchange="cartUp(<%=ocidx%>, this.value + '^' + 'b', 0);">
   <% ArrayList<PdtStock> stockList = oc.getStockList(); 
      for(int j = 0 ; j < stockList.size(); j++ ){
    	  PdtStock ps = stockList.get(j);
    	  String tmp="";
    	  String optName = "";
    	  
    	  if(ps.getPs_opt().equals("a"))  		optName = "빨강";
    	  else if(ps.getPs_opt().equals("b"))	optName = "파랑";
    	  else if(ps.getPs_opt().equals("c"))	optName = "검정";
    	  else if(ps.getPs_opt().equals("d"))	optName = "";
    	  tmp = optName + " (재고량 : " + ps.getPs_stock() + "개)";
   		  String disabled = "", selected = "";
          if(ps.getPs_stock() <= 0 ){
              disabled = " disable='disabled'";
              tmp = optName + " (품절)";
          }
          if(ps.getPs_idx() == oc.getPs_idx()){ 
             selected = " selected='selected'";
    	  	  
         	}%>
      <option value="<%=ps.getPs_idx() %>" <%=disabled + selected %>><%=tmp %></option>
   <%   }%></select>
<% } else {%>
<br/><p align="center">대여 기간</p> ( <%=oc.getOcr_period() %>박 <%=oc.getOcr_period() + 1 %>일)<br/>
<script>

$(function () {
	var curdate = new Date();
	var sdate = new Date();
	var exdate = new Date();
	sdate.setDate(curdate.getDate() + 1);
	exdate.setDate(curdate.getDate() + 3);
	$('input[name="period<%=ocidx%>"]').daterangepicker({
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
	    "maxSpan": {"days": 10 },
	    "startDate":"<%=oc.getOcr_sdate() %>",
	    "endDate":"<%=oc.getOcr_edate() %>",
	    "drops": "down",
	    "alwayShowCalendars":true
	}, function (start, end, label) {
	    console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
	});
});
</script>
	<input type="text" id="period<%=ocidx%>" name="period<%=ocidx%>" value="<%=oc.getOcr_sdate() %> ~ <%=oc.getOcr_edate() %>" onchange="cartUp(<%=ocidx%>, <%=oc.getPs_idx() %> + '^' + 'p' + '^' + this.value, 0);"/>
	
<% } %>
   </td>
<td width="12%">
<input type="button" id="deCnt" value="-"  onclick="setCount(this.value, <%=ocidx %>);"/>
<input type="text" name="cnt<%=ocidx %>" value="<%=oc.getOc_cnt() %>" style="width:30px; text-align:right;" readonly="readonly"/>
<input type="button" id="asCnt" value="+" onclick="setCount(this.value, <%=ocidx %>);"/>
  </td>
<td width="10%">  <% if (!oc.getPs_opt().equals("r")) {%><%=realPrice*oc.getOc_cnt() %>원</td><%} 
 else {%><%=realPrice/2*oc.getOcr_period()*oc.getOc_cnt() %>원</td><%} %>
 <td width="8%"><%=oc.getPi_dfee()*oc.getOc_cnt() %>원</td>
<td width="5%"><input type="button" value="삭제" onclick="cartDel(<%=ocidx%>);"/></td>
</tr>
<%      if (oc.getPs_opt().equals("r")) {
			realPrice = (realPrice/2*oc.getOcr_period()) ;
		}
		total += (realPrice + oc.getPi_dfee())*oc.getOc_cnt() ; 
   }%>
   </table>
   <p align="right" style="width:800px; font-size:20px;"><br />총 구매 가격 : <%=total %>원 </p>
   <p align="center" style="width:800px; font-size:15px;">
      <input type="button" value="선택상품 삭제" onclick="chkDel();"/>
      <input type="button" value="선택상품 구매" onclick="chkBuy();"/>
      <input type="button" value="전체 구매" onclick="allBuy();"/>
   </p> 
   
<% } else { %>
<table width="800">
<tr><td align='center' colspan='8' height='450'><br/><br/><br/><br/>
<img src='/cworldSite/img/order_cart_empty.png' width="200" height="200"/>&nbsp;&nbsp;&nbsp;<br/><br/><br/>
<span style="font-size:2em;">장바구니에 상품이 없습니다.</span><br/>원하는 상품을 장바구니에 담아보세요!<br/></td></tr></table>
<% } %>
</form>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>