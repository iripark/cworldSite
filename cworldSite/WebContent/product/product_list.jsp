<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_header.jsp" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
ArrayList<PdtInfo> productList = (ArrayList<PdtInfo>)request.getAttribute("productList");
ArrayList<PdtCtgrSmall> smallList = (ArrayList<PdtCtgrSmall>)request.getAttribute("smallList");

int cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize();
int bsize = pageInfo.getBsize();
int rcnt = pageInfo.getRcnt();
int pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage();

String args = "", sargs = "", oargs = "", vargs = "";
String pcb = pageInfo.getPcb(), pcs = pageInfo.getPcs(), sch = pageInfo.getSch(), v = pageInfo.getV(), o = pageInfo.getO(), special = pageInfo.getSpecial();

if(pcb != null && !pcb.equals("")) sargs += "&pcb=" + pcb;
if(pcs != null && !pcs.equals("")) sargs += "&pcs=" + pcs;
if(sch != null && !sch.equals("")) sargs += "&sch=" + sch;
if(o != null && !o.equals("")) oargs += "&o=" + o;
if(v != null && !v.equals("")) vargs += "&v=" + v;
args = "&cpage=" + cpage + sargs + oargs + vargs;	// 상품상세보기 링크용 쿼리스트링


String name = "", sp="", ep="", chkSpecial = "";
if (sch != null && !sch.equals("")){
	String[] arrSch = sch.split(",");	// 각 검색조건(상품명, 가격대, 특별상품여부) 별로 잘라 배열에 저장
	for (int i = 0; i < arrSch.length; i++) {
		char c = arrSch[i].charAt(0);
		if (c == 'n') { 
			name = arrSch[i].substring(1);
		} else if(c == 'p') {	// 가격대 검색일 경우
			sp = arrSch[i].substring(1, arrSch[i].indexOf('~')); 
			ep = arrSch[i].substring(arrSch[i].indexOf("~") + 1);
		} else if (c == 'l'){
			chkSpecial = arrSch[i].substring(1);
		}
	}
}

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
#cpage { font-weight:bold; }
</style>
<script>
function onlyNum(obj) {
	if (isNaN(obj.value)) {
		obj.value = "";
	}
}
function resetList(){
	document.frmPdtList2.sch.value = "";
	document.frmPdtList2.submit();
}
function makeSch() {
// makeSch() 함수에서 만들 검색 문자열 : ntest,p10000~20000,la:b:c
	var frm = document.frmPdtList;
	var sch = "";
	var name = frm.pi_name.value;
	if(name != ""){	sch = "n" + name; }
	
	var sp = frm.sp.value;
	var ep = frm.ep.value;
	if (sp != "" || ep != "") {
		if (sch != "") 	sch += ",";
		sch += "p" + sp + "~" + ep;
	}
	var special = frm.pi_special;
	var isFirst = true;
	for ( var i = 0 ; i < special.length ; i++){
		if(special[i].checked){
			if(isFirst){
				isFirst = false;
				if(sch != "") sch += ",";
				sch+= "l" + special[i].value;
			} else {
				sch+= ":" + special[i].value;
			}
		}
	}
	var pcb = frm.pcb.value;
	var pcs = frm.pcs.value;
	
	if (pcb == null) {
		pcb = "";
	}
	if (pcb != null && pcb != "") {
		
		if (pcs == null) {
			pcs = "";
			
		} else if (pcs != null && pcs != "") {
			pcs = frm.pcs.value;
			
		}
	}
	
	document.frmPdtList2.pcs.value = pcs;
	document.frmPdtList2.sch.value = sch;
	document.frmPdtList2.pcb.value = pcb;
	document.frmPdtList2.submit();
}
var arrR = new Array();		// R 대분류의 소분류 목록을 저장할 배열
arrR[0] = new Option("", " 소분류 선택 ");
arrR[1] = new Option("R01", " 텐 트 ");
arrR[2] = new Option("R02", " 타 프 / 쉘 터 ");
arrR[3] = new Option("R03", " 침 구 ");
arrR[4] = new Option("R04", " 의 자 / 테 이 블 ");
arrR[5] = new Option("R05", " 화 기 용 품 ");
arrR[6] = new Option("R06", " 식 기 용 품 ");

var arrS = new Array();		// S 대분류의 소분류 목록을 저장할 배열
arrS[0] = new Option("", " 소분류 선택 ");
arrS[1] = new Option("S01", " 텐 트 ");
arrS[2] = new Option("S02", " 타 프 / 쉘 터 ");
arrS[3] = new Option("S03", " 침 구 ");
arrS[4] = new Option("S04", " 의 자 / 테 이 블 ");
arrS[5] = new Option("S05", " 화 기 용 품 ");
arrS[6] = new Option("S06", " 식 기 용 품 ");

var arrP = new Array();		// P 대분류의 소분류 목록을 저장할 배열
arrP[0] = new Option("", " 소분류 선택 ");
arrP[1] = new Option("P00", " 패 키 지 ");
function setCategory(x, target) {
	for (var i = target.options.length - 1; i > 0; i--) {
		target.options[i] = null;
	} 
	if (x != "") {	
		var arr = eval("arr" + x);
		for (var i = 0; i < arr.length; i++) {
			target.options[i] = new Option(arr[i].value, arr[i].text);
		}		
		target.options[0].selected = true;
	}
}
</script>
</head>

<body>
<div class="content" align="center">
<br/>
<div align="left">
<div style="font-size:1.5em; font-weight:bold;">
<%if (pcb != null && pcb.equals("P"))		{%>풀세트패키지 대여 <% }
else if (pcb != null && pcb.equals("R"))	{%>캠핑용품 대여<% }
else if (pcb != null && pcb.equals("S")) 	{%>캠핑용품 구매<% }%></div>
</br>
<%if (smallList.size() > 0){ 	// 대분류가 선택되었으면%>
<% for (int i = 0 ; i < smallList.size() ; i++ ){
	PdtCtgrSmall small = smallList.get(i);
%><a href="product_list?pcb=<%=small.getPcb_id() %>&pcs=<%=small.getPcs_id() %><%=oargs + vargs %>"><div class="smallCata" align="center" <% if (pcs != null && pcs.equals(small.getPcs_id())){%> id="pcs"<%} %> ><%=small.getPcs_name() %></div></a><%	} %>
<%} %> </div>
<br/><br/>
<table width="900" style="border:3px solid pink;">
<tr>
<td width="*" valign="top">
	<!-- 검색조건 입력폼 -->
	<form name="frmPdtList2">
	<input type="hidden" name="pcb" value="<%=pcb %>" />

	<input type="hidden" name="pcs" value="<%=pcs %>" />
	<% if (pcb != null && !pcb.equals("")){ %>
	<%} %>
	<input type="hidden" name="o" value="<%=o %>" />
	<input type="hidden" name="v" value="<%=v %>" />
	<input type="hidden" name="sch" value="<%=sch %>" />
	</form>
	<form name="frmPdtList">
	<div>
		<br/>
		<table id="pdtSch" cellpadding="5"><tr><th width="20%" height="50">상품 분류</th>
		<td ><select name="pcb" class="pdtCata" onchange="setCategory(this.value, this.form.pcs);">
			<option value="">대분류 선택</option>
			<option value="P" <%if(pcb != null && pcb.equals("P")) { %> selected="selected" <% } %>>풀세트패키지 대여</option>
			<option value="R" <%if(pcb != null && pcb.equals("R")) { %> selected="selected" <% } %>>캠핑용품 대여</option>
			<option value="S" <%if(pcb != null && pcb.equals("S")) { %> selected="selected" <% } %>>캠핑용품 구매</option>
		</select>
		<select name="pcs" class="pdtCata">
			<option value="">소분류 선택</option>
<% if (pcb != null && !pcb.equals("") && pcs != null && !pcs.equals("")) { 
	for (int i = 0; i < smallList.size(); i++) {
		PdtCtgrSmall ps = smallList.get(i); 
%>
		<option value="<%=ps.getPcs_id() %>" <%if(pcs != null && pcs.equals(ps.getPcs_id())) { %> selected="selected" <% } %>><%=ps.getPcs_name() %></option>
<%	} 
} %>
		</select></td></tr>
		<tr><th height="50">가격대</th><td>
		<input type="text" name="sp" class="price" value="<%=sp %>" onkeyup="onlyNum(this);" /> ~
		<input type="text" name="ep" class="price" value="<%=ep %>" onkeyup="onlyNum(this);" />
		</td></tr>
		<tr><th height="50">상품명</th><td><input type="text" name="pi_name" id="pi_name" class="pdtCata" value="<%=name %>" />
		<input type="button" value="상품 검색" class="pdtBtn" onclick="makeSch();" style="border:0; background:pink; width:150px; height:30px;"/>
		<input type="button" value="조건 초기화" class="pdtBtn" onclick="resetList();" style="border:0; background:pink; width:150px; height:30px;"/>
		</td></tr>
		<tr><th>특별상품</th>
		<td height="50">
		
		<input type="checkbox" name="pi_special" id="a" value="a" <%if (chkSpecial.indexOf("a") >= 0){ %> checked="checked"<%} %>><label for="a">&nbsp;BEST</label>&nbsp;&nbsp;
		<input type="checkbox" name="pi_special" id="b" value="b" <%if (chkSpecial.indexOf("b") >= 0){ %> checked="checked"<%} %>><label for="b">&nbsp;NEW</label>&nbsp;&nbsp;
		<input type="checkbox" name="pi_special" id="c" value="c" <%if (chkSpecial.indexOf("c") >= 0){ %> checked="checked"<%} %>><label for="c">&nbsp;HOT</label>&nbsp;&nbsp;
		<input type="checkbox" name="pi_special" id="d" value="d" <%if (chkSpecial.indexOf("d") >= 0){ %> checked="checked"<%} %>><label for="d">&nbsp;Sale</label>
		<tr><td colspan="2"><br/></td></tr>
		</table>
	</div>
	</form>
</td>
</tr>
</table>
<!-- 상품 목록 및 페이징 -->
<%
   String imgList = "/cworldSite/img/ico_l.png";
   String imgGall = "/cworldSite/img/ico_g.png";
   if(v.equals("g")){    imgGall = "/cworldSite/img/ico_g_on.png"; }
   else          {   imgList = "/cworldSite/img/ico_l_on.png"; }
   String lnk = "onclick=\"location.href='product_list?cpage=1";
   String lnkList = lnk + sargs + oargs + "&v=l';\" class=\"hand\"";
   String lnkGall = lnk + sargs + oargs + "&v=g';\" class=\"hand\"";
%>
<table width="900" callpadding="5" style="margin-top:10px;">
   <tr><td colspan="3" align="right" style="border:3px solid pink; padding:5px;">
      <select name="o" onchange="location.href='product_list?cpage=1<%=sargs + vargs%>&o=' + this.value;">
         <option value="">상품 정렬 기준</option>
         <option value="a" <% if(o.equals("a")) {%> selected="selected" <%} %>>신상품</option>
         <option value="b" <% if(o.equals("b")) {%> selected="selected" <%} %>>인기순</option>
         <option value="c" <% if(o.equals("c")) {%> selected="selected" <%} %>>할인율</option>
         <option value="d" <% if(o.equals("d")) {%> selected="selected" <%} %>>낮은 가격순</option>
         <option value="e" <% if(o.equals("e")) {%> selected="selected" <%} %>>높은 가격순</option>
         <option value="f" <% if(o.equals("f")) {%> selected="selected" <%} %>>평점순</option>
         <option value="g" <% if(o.equals("g")) {%> selected="selected" <%} %>>리뷰순</option>
         <option value="h" <% if(o.equals("h")) {%> selected="selected" <%} %>>조회순</option>      
      </select>&nbsp;&nbsp;&nbsp;
      <img src="<%=imgList %>" width="18" height="22" align="absmiddle" <%=lnkList %>/>
      <img src="<%=imgGall %>" width="18" height="22" align="absmiddle" <%=lnkGall %>/>
   </td></tr><tr><td height="10"></td></tr></table>
<%
int colnum = 3;
if(pcb != null && pcb.equals("P")) colnum = 2;
int rownum = psize / colnum;
if (rcnt > 0 && productList.size() > 0) {  // 검색된 상품목록이 있을 경우 
   %><table width="900" callpadding="5" style="margin-top:10px;">
   <%
   if(v.equals("g")){
		for(int i = 0 ; i < productList.size() ; i++){
			if(i%colnum == 0){ out.println("<tr>"); }
			PdtInfo pi = productList.get(i);
			int realPrice = pi.getRealPrice();
			String conABCD = pi.getPi_special();
			%>
			<td width="<%=900/colnum %>" align="center" onmouseover="this.bgColor='#efefef';" onmouseout="this.bgColor='';">
			<a href="product_view?piid=<%=pi.getPi_id() + args %>">
			<img src="pdt_img/<%=pi.getPi_img1()%>" width="<%=900/colnum - 20 %>" height="<%=900/colnum - 20 %>" border="0"/>
			<br/><br/>
			<% if(conABCD != null && !conABCD.equals("")){
				if (conABCD.contains("a")){%>	<img src="/cworldSite/img/icon_special_best.png" width="30" height="20"/>	<% 	} 
				if (conABCD.contains("b")){	%>	<img src="/cworldSite/img/icon_special_new.png" width="30" height="20"/>	<% 	} 
				if (conABCD.contains("c")){	%>	<img src="/cworldSite/img/icon_special_hot.png" width="30" height="20"/>	<% 	} 
				if (conABCD.contains("d")){%>	<img src="/cworldSite/img/icon_special_sale.png" width="30" height="20"/>	<% 	} 
			}	%>
			<%=pi.getPi_name() %></a>
			<%if(pi.getPi_dc() > 0){ %>
			<br/><del><%=pi.getPi_price() %>원</del>&nbsp;
			<%=pi.getPi_dc() %>% 할인!!
			<%} %>
			<br/>
			<%if (pi.getPi_id().charAt(0) != 'S'){ out.println("2박 3일 대여 요금 - "); }%>
			<%=realPrice %>원
			
			<br/>판매 : <%=pi.getPi_srcnt() %>ea
			<br/>
			<div class="star-ratings" style="display:inline-block;">
				<div class="star-ratings-fill space-x-2 text-lg" style="width: <%=pi.getPi_score()*20 %>%;">
					<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
				</div>
				<div class="star-ratings-base space-x-2 text-lg">
					<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
				</div>
			</div>
			<%=pi.getPi_score() %> / 5.0<br/><br/></td>
			
	<%		
			if (( i + 1 ) % colnum > 0 && i + 1 == productList.size()){
				for( int k = 0 ; k < colnum - (productList.size() % 3) ; k++){
					out.println("<td width='" + 900/colnum + "'></td>");
				}
				out.println("</tr>");
			}
			if(i % colnum == colnum - 1){
			out.println("</tr>");}
		}
	} else { %>
</table>
<table width="900" style="border-collapse: collapse;">
	<tr style="border-bottom:3px double pink;">
	<td width="20%" align="center" height="30">상품 이미지</td><td width="30%" align="center">상품명</td>
	<td align="center">가격</td><td align="center">판매 횟수</td></tr>
<%		for ( int i = 0 ; i < productList.size(); i++ ){
			int realPrice = productList.get(i).getRealPrice();
			%><tr style="border-bottom:1px solid pink;" onmouseover="this.bgColor='#efefef';" onmouseout="this.bgColor='';" align="center">
			<td width="20%" height='100'>
				<a href="product_view?piid=<%=productList.get(i).getPi_id() + args %>">
				<img src="pdt_img/<%=productList.get(i).getPi_img1()%>" width="80" height="80" border="0"/></a>
			</td>
			<td width="30%"> <a href="product_view?piid=<%=productList.get(i).getPi_id() + args %>"><%=productList.get(i).getPi_name() %></a>
			<br/><div class="star-ratings" style="display:inline-block;">
				<div class="star-ratings-fill space-x-2 text-lg" style="width: <%=productList.get(i).getPi_score()*20 %>%;">
					<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
				</div>
				<div class="star-ratings-base space-x-2 text-lg">
					<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
				</div>
			</div>
			( <%=productList.get(i).getPi_score() %> / 5.0 )
			<td>
			<% if (productList.get(i).getPi_dc() > 0){ %>
				<del><%=productList.get(i).getPi_price() %>원</del>&nbsp;
				<%=productList.get(i).getPi_dc() %>% 할인!!<br/>
			<% } %>
			<%if (productList.get(i).getPi_id().charAt(0) != 'S'){ out.println("2박 3일 대여 요금 - "); }%>	
			<%=realPrice %>원</td>
			<td>판매 : <%=productList.get(i).getPi_srcnt() %>ea</td>
			
<%		} %>

</table><table width="900" style="border:3px solid pink;">
<%	}
	String tmpArgs = sargs + oargs + vargs;
	out.println("<tr><td colspan='3' align='center'>");
	spage = (cpage - 1)/bsize*bsize + 1;	// 현재 블록에서의 시작페이지 번호
	pcnt = (rcnt / psize);
	if(rcnt % psize != 0)	pcnt = (rcnt / psize) + 1;
	if (cpage == 1) {
		out.println("[&lt;&lt;]&nbsp;&nbsp;&nbsp;[&lt;]&nbsp;&nbsp;");
	} else {
		out.println("<a href='product_list?cpage=1" + tmpArgs + "'>[&lt;&lt;]</a>");
		out.println("&nbsp;&nbsp;&nbsp;");
		out.println("<a href='product_list?cpage="+ (cpage - 1) + tmpArgs + "'>[&lt;]</a>");
		out.println("&nbsp;");
	}
	for (int i = 1, j = spage; i <= bsize && j <= pcnt ; i++, j++){
		// i : 블록에서 보여줄 페이지의 개수만큼 루프를 돌릴 조건으로 사용되는 변수
		// j : 실제 출력한 페이지 번호로 전체 페이지 개수(마지막 페이지 번호를 점지 않게 사용해야 함)
		if ( cpage == j ){
			out.println("&nbsp;<strong id='cpage'>" + j + "</strong>&nbsp;");
		} else {
			out.println("&nbsp;<a href='product_list?cpage=" + j + tmpArgs +"'>" + j + "</a>&nbsp;");		
		}
	}		
	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[&gt;]&nbsp;&nbsp;&nbsp;[&gt;&gt;]");
	} else {
		out.println("&nbsp;&nbsp;");
		out.println("<a href='product_list?cpage="+ (cpage + 1) + tmpArgs + "'>[&gt;]</a>");
		out.println("&nbsp;&nbsp;&nbsp;");
		out.println("<a href='product_list?cpage=" + pcnt + tmpArgs + "'>[&gt;&gt;]</a>");
	}
	out.println("</td></tr>");


} else {	// 검색된 상품 목록이 없을 경우
	%>
	<%
	out.println("<table width='900' callpadding='5' style=\"border:3px solid pink; margin-top:10px;\" ><tr><td align='center' valign='center' height='200'>검색된 상품이 없습니다.</td></tr>");
}
%>

</table>
</div>
</body>
</html>
<%@ include file="../_inc/inc_footer.jsp" %>

