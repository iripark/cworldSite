<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>

<%
request.setCharacterEncoding("utf-8");
ArrayList<PdtInfo> nrList = (ArrayList<PdtInfo>)request.getAttribute("nrList");
ArrayList<PdtInfo> brList = (ArrayList<PdtInfo>)request.getAttribute("brList");
ArrayList<PdtInfo> nbList = (ArrayList<PdtInfo>)request.getAttribute("nbList");
ArrayList<PdtInfo> bbList = (ArrayList<PdtInfo>)request.getAttribute("bbList");
int colnum = 3;
%>
<title>Insert title here</title>
<style>
/*슬라이드 배너*/
* {box-sizing: border-box;}
.mySlides {display: none;}
img {vertical-align: middle;}

/* Slideshow container */
.slideshow-container {
  width: 900px; height:302px;
  position: relative;
  top:-62px;
  margin: auto;
  border:pink solid 1px;
}

/* Caption text */
.text {
  color: #000000;
  font-size: 15px;
  padding: 8px 12px;
  position: absolute;
  top: 230px;
  bottom: 8px;
  width: 100%;
  text-align: center;
}

/* Number text (1/3 etc) */
.numbertext {
  color: #f2f2f2;
  font-size: 12px;
  padding: 8px 12px;
  position: absolute;
  top: 0;
}

/* The dots/bullets/indicators */
.dot {
  height: 15px;
  width: 15px;
  margin: 0 2px;
  background-color: #bbb;
  border-radius: 50%;
  display: inline-block;
  transition: background-color 0.6s ease;
  position:absolute; top:270px;
}

#dot1 { left:415px; }
#dot2 { left:439px; }
#dot3 { left:463px; }
.active {
  background-color: #717171;
}

/* Fading animation */
.fade {
  -webkit-animation-name: fade;
  -webkit-animation-duration: 1.5s;
  animation-name: fade;
  animation-duration: 1.5s;
}

@-webkit-keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

@keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

/* On smaller screens, decrease text size */
@media only screen and (max-width: 300px) {
  .text {font-size: 11px}
}

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
<script>
function showList(menu) {
	var m1 = document.getElementById("m1");
	var m2 = document.getElementById("m2");
	var m3 = document.getElementById("m3");
	var m4 = document.getElementById("m4");
	var t1 = document.getElementById("inTa1");
	var t2 = document.getElementById("inTa2");
	var t3 = document.getElementById("inTa3");
	var t4 = document.getElementById("inTa4");
	var arr = ["m1", "m2", "m3", "m4"];
	for (var i = 0 ; i < arr.length ; i++){
		if (menu == arr[i]){
			eval("m" + (i + 1)).style.background = "green";
			eval("t" + (i + 1)).style.display = "block";
		} else { 
			eval("m" + (i + 1)).style.background = "pink";
			eval("t" + (i + 1)).style.display = "none";
		}
	}
}
</script>
<div class="content" align="center"><br/><br/><br/>
<div class="slideshow-container">
	<div class="mySlides fade">
	  <div class="numbertext">1 / 3</div>
	  <a href="#"><img src="/cworldSite/img/slide_1.jpg" style="width:100%; height:300px;"></a>
	  <div class="text"> </div>
	</div>
	<div class="mySlides fade">
	  <div class="numbertext">2 / 3</div>
	   <a href="#"><img src="/cworldSite/img/slide_2.jpg" style="width:100%; height:300px;"></a>
	  <div class="text"> </div>
	</div>
	<div class="mySlides fade">
	  <div class="numbertext">3 / 3</div>
	   <a href="#"><img src="/cworldSite/img/slide_3.jpg" style="width:100%; height:300px;"></a>
	  <div class="text"> </div>
	</div>
	<div style="text-align:center">
	  <span id="dot1" class="dot" onclick="clearInterval(repeatSlides); slideIndex=0; showSlides(); repeatSlides = setInterval(showSlides, 3000);"></span> 
	  <span id="dot2" class="dot" onclick="clearInterval(repeatSlides); slideIndex=1; showSlides(); repeatSlides = setInterval(showSlides, 3000);"></span> 
	  <span id="dot3" class="dot" onclick="clearInterval(repeatSlides); slideIndex=2; showSlides(); repeatSlides = setInterval(showSlides, 3000);"></span> 
	</div>
</div>
<script>
var slideIndex = 0;
function showSlides() {
    var slides = document.getElementsByClassName("mySlides");
    var dots = document.getElementsByClassName("dot");
    for (var i = 0; i < slides.length; i++) {
    	slides[i].style.display = "none";  
    }
    slideIndex++;
    if (slideIndex > slides.length) {slideIndex = 1}    
    for (var i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
    }
    slides[slideIndex-1].style.display = "block";  
    dots[slideIndex-1].className += " active";
     // Change image every 2 seconds
}
showSlides();
var repeatSlides = setInterval(showSlides, 3000);
</script>
<table id="videos" border="1" width="900" height="260">
<tr><td align="center" valign="center">
<iframe width="440" height="250" src="https://www.youtube.com/embed/RcK3p2_UdIY" title="YouTube video player" frameborder="1" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe><br/>텐트 설치법</td>
<td align="center">
<iframe width="440" height="250" src="https://www.youtube.com/embed/hg5TROvFIoc" title="YouTube video player" frameborder="1" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe><br/>캠핑장 안내</td>
</table>
<br/><br/>

<div id="indexDivId">
<div id="m1" style="background:green;" onclick="showList(this.id);">신상품 대여</div><div id="m2" style="background:pink;" onclick="showList(this.id);">인기상품 대여</div><div id="m3" style="background:pink;" onclick="showList(this.id);">신상품 구매</div><div id="m4" style="background:pink;" onclick="showList(this.id);">인기상품 구매</div>
</div>
<br/>
<table width="900" align="center" id="inTa1">
<%
if(nrList.size() > 0){
	for(int i = 0 ; i < nrList.size() ; i++){
		if(i%colnum == 0){ out.println("<tr>"); }
			int realPrice = nrList.get(i).getRealPrice();
			String pcb = nrList.get(i).getPi_id().substring(0,1);
			String pcs = nrList.get(i).getPi_id().substring(0,3);
			String args = "&pcb="+pcb+"&pcs="+pcs;
			%>
			<td width="300" height="400" align="center" onmouseover="this.bgColor='#efefef';" onmouseout="this.bgColor='';">
			<a href="product_view?piid=<%=nrList.get(i).getPi_id() + args %>">
			<img src="pdt_img/<%=nrList.get(i).getPi_img1()%>" width="280" height="280" border="0"/>
			<br/><br/>
			<% String conABCD = nrList.get(i).getPi_special();
			if(conABCD != null && !conABCD.equals("")){
				if (conABCD.contains("a")){%>	<img src="/cworldSite/img/icon_special_best.png" width="30" height="20"/>	<% 	} 
				if (conABCD.contains("b")){	%>	<img src="/cworldSite/img/icon_special_new.png" width="30" height="20"/>	<% 	} 
				if (conABCD.contains("c")){	%>	<img src="/cworldSite/img/icon_special_hot.png" width="30" height="20"/>	<% 	} 
				if (conABCD.contains("d")){%>	<img src="/cworldSite/img/icon_special_sale.png" width="30" height="20"/>	<% 	} 
			}	%>
			<%=nrList.get(i).getPi_name() %></a>
			<%if(nrList.get(i).getPi_dc() > 0){ %>
			<br/><del><%=nrList.get(i).getPi_price() %>원</del>&nbsp;
			<%=nrList.get(i).getPi_dc() %>% 할인!!
			<%} %>
			<br/><%=realPrice %>원
			<br/>판매 : <%=nrList.get(i).getPi_srcnt() %>ea
			<br/><div class="star-ratings" style="display:inline-block;">
			<div class="star-ratings-fill space-x-2 text-lg" style="width: <%=nrList.get(i).getPi_score()*20 %>%;">
				<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
			</div>
			<div class="star-ratings-base space-x-2 text-lg">
				<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
			</div>
		</div>&nbsp;
		( <%=nrList.get(i).getPi_score() %> / 5.0 )<br/><br/>
			</td>
	<%		
			if (( i + 1 ) % colnum > 0 && i + 1 == nrList.size()){
				for( int k = 0 ; k < colnum - (nrList.size() % 3) ; k++){
					out.println("<td width='300'></td>");
				}
			}
			if(i % colnum == colnum - 1){
			out.println("</tr>");
			}

		} 
}else {
	out.println("<tr><td>상품이 없습니다.</td><tr>");
}
%>
</table>
<table width="900" align="center" id="inTa2" style="display:none;">
<%
if(brList.size() > 0){
	for(int i = 0 ; i < brList.size() ; i++){
		if(i%colnum == 0){ out.println("<tr>"); }
			int realPrice = brList.get(i).getRealPrice();
			String pcb = brList.get(i).getPi_id().substring(0,1);
			String pcs = brList.get(i).getPi_id().substring(0,3);
			String args = "&pcb="+pcb+"&pcs="+pcs;
			%>
			<td width="300" height="400" align="center" onmouseover="this.bgColor='#efefef';" onmouseout="this.bgColor='';">
			<a href="product_view?piid=<%=brList.get(i).getPi_id() + args %>">
			<img src="pdt_img/<%=brList.get(i).getPi_img1()%>" width="280" height="280" border="0"/>
			<br/><br/>
			<% String conABCD = brList.get(i).getPi_special();
			if(conABCD != null && !conABCD.equals("")){
				if (conABCD.contains("a")){%>	<img src="/cworldSite/img/icon_special_best.png" width="30" height="20"/>	<% 	} 
				if (conABCD.contains("b")){	%>	<img src="/cworldSite/img/icon_special_new.png" width="30" height="20"/>	<% 	} 
				if (conABCD.contains("c")){	%>	<img src="/cworldSite/img/icon_special_hot.png" width="30" height="20"/>	<% 	} 
				if (conABCD.contains("d")){%>	<img src="/cworldSite/img/icon_special_sale.png" width="30" height="20"/>	<% 	} 
			}	%>
			<%=brList.get(i).getPi_name() %></a>
			<%if(brList.get(i).getPi_dc() > 0){ %>
			<br/><del><%=brList.get(i).getPi_price() %>원</del>&nbsp;
			<%=brList.get(i).getPi_dc() %>% 할인!!
			<%} %>
			<br/><%=realPrice %>원
			<br/>판매 : <%=brList.get(i).getPi_srcnt() %>ea
			<br/><div class="star-ratings" style="display:inline-block;">
				<div class="star-ratings-fill space-x-2 text-lg" style="width: <%=brList.get(i).getPi_score()*20 %>%;">
					<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
				</div>
				<div class="star-ratings-base space-x-2 text-lg">
					<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
				</div>
			</div>&nbsp;
			( <%=brList.get(i).getPi_score() %> / 5.0 )<br/><br/>
			</td>
		<%		
			if (( i + 1 ) % colnum > 0 && i + 1 == brList.size()){
				for( int k = 0 ; k < colnum - (brList.size() % 3) ; k++){
					out.println("<td width='300'></td>");
				}
			}
			if(i % colnum == colnum - 1){
			out.println("</tr>");
			}

		} 
}else {
	out.println("<tr><td>상품이 없습니다.</td><tr>");
}
%>
</table>
<table width="900" align="center" id="inTa3"  style="display:none;">
<%
if(nbList.size() > 0){
	for(int i = 0 ; i < nbList.size() ; i++){
		if(i%colnum == 0){ out.println("<tr>"); }
			int realPrice = nbList.get(i).getRealPrice();
			String pcb = nbList.get(i).getPi_id().substring(0,1);
			String pcs = nbList.get(i).getPi_id().substring(0,3);
			String args = "&pcb="+pcb+"&pcs="+pcs;
			%>
			<td width="300" height="400" align="center" onmouseover="this.bgColor='#efefef';" onmouseout="this.bgColor='';">
			<a href="product_view?piid=<%=nbList.get(i).getPi_id() + args %>">
			<img src="pdt_img/<%=nbList.get(i).getPi_img1()%>" width="280" height="280" border="0"/>
			<br/><br/>
			<% String conABCD = nbList.get(i).getPi_special();
			if(conABCD != null && !conABCD.equals("")){
				if (conABCD.contains("a")){%>	<img src="/cworldSite/img/icon_special_best.png" width="30" height="20"/>	<% 	} 
				if (conABCD.contains("b")){	%>	<img src="/cworldSite/img/icon_special_new.png" width="30" height="20"/>	<% 	} 
				if (conABCD.contains("c")){	%>	<img src="/cworldSite/img/icon_special_hot.png" width="30" height="20"/>	<% 	} 
				if (conABCD.contains("d")){%>	<img src="/cworldSite/img/icon_special_sale.png" width="30" height="20"/>	<% 	} 
			}	%>
			<%=nbList.get(i).getPi_name() %></a>
			<%if(nbList.get(i).getPi_dc() > 0){ %>
			<br/><del><%=nbList.get(i).getPi_price() %>원</del>&nbsp;
			<%=nbList.get(i).getPi_dc() %>% 할인!!
			<%} %>
			<br/><%=realPrice %>원
			<br/>판매 : <%=nbList.get(i).getPi_srcnt() %>ea
			<br/><div class="star-ratings" style="display:inline-block;">
			<div class="star-ratings-fill space-x-2 text-lg" style="width: <%=nbList.get(i).getPi_score()*20 %>%;">
				<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
			</div>
			<div class="star-ratings-base space-x-2 text-lg">
				<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
			</div>
		</div>&nbsp;
		( <%=nbList.get(i).getPi_score() %> / 5.0 )<br/><br/>
		</td>
	<%		
			if (( i + 1 ) % colnum > 0 && i + 1 == nbList.size()){
				for( int k = 0 ; k < colnum - (nbList.size() % 3) ; k++){
					out.println("<td width='300'></td>");
				}
			}
			if(i % colnum == colnum - 1){
			out.println("</tr>");
			}

		} 
}else {
	out.println("<tr><td>상품이 없습니다.</td><tr>");
}
%>
</table>
<table width="900" align="center" id="inTa4"  style="display:none;">
<%

if(bbList.size() > 0){
	for(int i = 0 ; i < bbList.size() ; i++){
		if(i%colnum == 0){ out.println("<tr>"); }
			int realPrice = bbList.get(i).getRealPrice();
			String pcb = bbList.get(i).getPi_id().substring(0,1);
			String pcs = bbList.get(i).getPi_id().substring(0,3);
			String args = "&pcb="+pcb+"&pcs="+pcs;
			%>
			<td width="300" height="400" align="center" onmouseover="this.bgColor='#efefef';" onmouseout="this.bgColor='';">
			<a href="product_view?piid=<%=bbList.get(i).getPi_id() + args %>">
			<img src="pdt_img/<%=bbList.get(i).getPi_img1()%>" width="280" height="280" border="0"/>
			<br/><br/>
			<% String conABCD = bbList.get(i).getPi_special();
			if(conABCD != null && !conABCD.equals("")){
				if (conABCD.contains("a")){%>	<img src="/cworldSite/img/icon_special_best.png" width="30" height="20"/>	<% 	} 
				if (conABCD.contains("b")){	%>	<img src="/cworldSite/img/icon_special_new.png" width="30" height="20"/>	<% 	} 
				if (conABCD.contains("c")){	%>	<img src="/cworldSite/img/icon_special_hot.png" width="30" height="20"/>	<% 	} 
				if (conABCD.contains("d")){%>	<img src="/cworldSite/img/icon_special_sale.png" width="30" height="20"/>	<% 	} 
			}	%>
			<%=bbList.get(i).getPi_name() %></a>
			<%if(bbList.get(i).getPi_dc() > 0){ %>
			<br/><del><%=bbList.get(i).getPi_price() %>원</del>&nbsp;
			<%=bbList.get(i).getPi_dc() %>% 할인!!
			<%} %>
			<br/><%=realPrice %>원
			<br/>판매 : <%=bbList.get(i).getPi_srcnt() %>ea
			<br/><div class="star-ratings" style="display:inline-block;">
				<div class="star-ratings-fill space-x-2 text-lg" style="width: <%=bbList.get(i).getPi_score()*20 %>%;">
					<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
				</div>
				<div class="star-ratings-base space-x-2 text-lg">
					<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
				</div>
			</div>&nbsp;
			( <%=bbList.get(i).getPi_score() %> / 5.0 )<br/><br/>
			</td>
	<%		
			if (( i + 1 ) % colnum > 0 && i + 1 == bbList.size()){
				for( int k = 0 ; k < colnum - (bbList.size() % 3) ; k++){
					out.println("<td width='300'></td>");
				}
			}
			if(i % colnum == colnum - 1){
			out.println("</tr>");
			}

		} 
}else {
	out.println("<tr><td>상품이 없습니다.</td><tr>");
}

%>
</table>
</div>

</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>