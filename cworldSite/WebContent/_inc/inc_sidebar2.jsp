<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cworld에 오신것을 환영합니다.</title>
<link rel="shortcut icon" href="/cworldSite/img/favicon.ico" type="image/x-icon" />
<link rel="icon" href="/cworldSite/img/favicon.ico" type="image/x-icon" />
<style>
#sideMenu { 
      width:200px; height:100%; z-index:10001;
      position:fixed; top:0px; right:0px; background:#656565;
      background:rgba(0, 0, 0, 0.5); color:#fff;
   }
#sideMenu ul { 
   position:absolute; 
   top:420px; right:30px; padding:0; margin-top:40px;
}
#sideMenu li {
   margin:0 0 20px; 
   list-style-type:none; 
}
#sideMenu li a { 
   color:white; font-weight:bold; 
   text-decoration:none; font-size:1.2em;
}
#sideMenu button { background:rgba(0, 0, 0, 0); border:none; cursor:pointer;}
#btnMenu { position:absolute; top:170px; right:192px }
#historyborder {  position:absolute; margin-left:17px; width:200px; height:160px; top:65px; padding:0; overflow:hidden;}
#historyList { position:absolute; width:200px; height:400px; top:-20px; margin:0; }
#historyList img { margin-bottom:3px; }
#linksList { position:absolute; top:285px; right:10px; }

#arrowbtns { position:absolute; top:230px; right:60px; z-index:10000;}

</style>
<script src="/cworldSite/js/jquery-3.6.1.js"></script>
<script>
$(document).ready(function(){
	$("#btnMenu").click(function(){
		$("#sideMenu").toggleClass("close");
		// #sideMenu 객체에 'open' 이라는 클래스를 이벤트 발생시 마다 추가와 삭제를 번갈아가면서 실행
		if($("#sideMenu").attr("class") == "close"){
		// if ($("#sideMenu").hasClass("open") { // 으로 쓰는것이 간편
			$("#imgMenu").attr("src", "/cworldSite/img/left_open.png");
			$("#sideMenu").animate({right:"-200px"}, 300);
		}
		else {
			$("#imgMenu").attr("src", "/cworldSite/img/left_close.png");
			$("#sideMenu").animate({right:0 }, 300);
		}
	});
});
var locationIdx = 0;
$(document).ready(function(){
	$("#arrow1").click(function(){
		locationIdx--;
		if( locationIdx >= 0){
			$("#historyList").animate({top: -20-locationIdx*80 + "px"},300);	
		} else {
			locationIdx = 0;
		}	
	});
	$("#arrow2").click(function(){
		locationIdx++;
		if( locationIdx <= 2){
			$("#historyList").animate({top: -20-locationIdx*80 + "px"},300);
		} else {
				locationIdx = 2;
		}
	});
});
</script>
</head>
<body>
<div id="sideMenu">
	<br/>
	<img src="/cworldSite/img/ico_history_pdt2.png" width="200" height="50"/> <br/>
	<div id="historyborder">
		<div align="left" id="historyList">
         <% ArrayList<String> history = new ArrayList<String>();
         String ck = request.getHeader("Cookie");
         if(ck != null){
            Cookie cookies[] = request.getCookies();
            if(cookies.length > 1){
               for(int i = cookies.length - 1 ; i >= 0  ; i--){
                  if (!cookies[i].getName().equals("JSESSIONID"))      history.add(cookies[i].getValue());      
               }
               for (int i = 0, j = 1; i < history.size() && j <= 8  ; i++, j++){
                  if(i % 2 == 0){ %><br/><%} %>
                  <a href="product_view?piid=<%=history.get(i).substring(0, 6)%>">
                  <img src="/cworldSite/pdt_img/<%=history.get(i)%>" width="80" height="80"></a>
               <%} %>
         <%   } else {
            %>    <br/> <br/>최근 본 상품이<br/> 존재하지 않습니다.<%
            }
         } else { %>
         <br/> <br/> 최근 본 상품이<br/> 존재하지 않습니다.
      <%   } %>   
      </div>
	</div>	
	<br/>
	<div align="center" id="arrowbtns">
		<img src="/cworldSite/img/icon_arrow_1.png" id="arrow1" width="30" height="30"/>&nbsp;&nbsp;&nbsp;
		<img src="/cworldSite/img/icon_arrow_2.png" id="arrow2" width="30" height="30"/>
	</div>
	<br/>
	
	<div align="center" id="linksList" style="text-vertical-align:center;" >
		<a href="/cworldSite/cart_view"/><div align="center" style="display:table-cell; vertical-align:middle; width:90px; height:40px; background:gray;">장바구니</div></a> <a href="/cworldSite/g_qna_list?cpage=1"/><div style="display:table-cell; vertical-align:middle; width:90px; height:40px; background:gray;">단체행사 문의</div></a><br/>
		<a href="https://www.weather.go.kr/w/index.do" target="_blank"/><div style="display:table-cell; width:90px; vertical-align:middle; height:40px; background:gray;">날씨정보</div></a> <a href="https://booking.naver.com/booking/3/bizes/151304/items/2759486" target="_blank" /><div style="display:table-cell; vertical-align:middle; width:90px; height:40px; background:gray;">자매캠핑장</div></a>
	</div>
	</br/>
	<ul>
		<li>고객센터 <br/>1588-1111</li>
		
		<li><운영시간 안내><br/>평일 : 09:00~17:30<br/>
		점심시간 : 12:30 ~ 13:30<br/>
		토, 일, 공휴일 휴무</li>
		<li><입금계좌><br/>
		시어은행<br/>111-222-333333
		<br/>머니은행<br/>	222-333-444444</li>
		
	</ul>
	<button id="btnMenu"><img src="/cworldSite/img/left_close.png" id="imgMenu" width="30"/></button>
</div>
</body>
</html>