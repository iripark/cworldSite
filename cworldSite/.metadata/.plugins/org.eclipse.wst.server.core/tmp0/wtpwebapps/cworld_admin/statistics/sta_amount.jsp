<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String am = (String)request.getAttribute("amount");
String sch = (String)request.getAttribute("sch");
String[] amount = am.split(",");

int pa = 0, sa = 0, ra = 0;
for (int i = 0; i < amount.length; i++) {
	String[] tmp = amount[i].split(":");
	if(tmp[0].equals("S")) {
		sa = Integer.parseInt(tmp[1]);
	} else if(tmp[0].equals("P")) {
		pa = Integer.parseInt(tmp[1]);
	} else if(tmp[0].equals("R")) {
		ra = Integer.parseInt(tmp[1]);
	}
}
String sd = "", ed = "";
if (sch != null && !sch.equals("")) {
	
	String[] arrSch = sch.split(",");
	for (int i = 0; i < arrSch.length; i++) {
		char c = arrSch[i].charAt(0);
		if (c == 'r') {
			sd = arrSch[i].substring(1, arrSch[i].indexOf(':'));
			ed = arrSch[i].substring(arrSch[i].indexOf(':') + 1);		
		}
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script> 
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> 
<script>
var config = {
	type: 'pie',
	data: {
		datasets: [{
			data: [<%=ra %>, <%=sa %>, <%=pa %>], 
			backgroundColor: [
				window.chartColors.red,
				window.chartColors.orange,
				window.chartColors.yellow,
				
			],
			label: '분류별 판매량'
		}],
		labels: ["대여", "판매", "패키지"]
		
	},
	options: { responsive:true, title:{ display:true, text:'<%if (!sd.equals("") || !ed.equals("")) { out.print(sd + " ~ " + ed + " 기간 분류별 판매량 "); } else {%>최근 30일 분류별 판매량<%}%>' } }
};
window.onload = function() {
	var ctx = document.getElementById('chart-area').getContext('2d');
	window.myPie = new Chart(ctx, config);
	 var minutes = 10;

	  var fiveMinutes = (60 * minutes) - 1,
	    display = document.querySelector('#MyTimer');
	  startTimer(fiveMinutes, display);
};
function makeSch() {
	var frmM = document.memSchFrm;
	var frm = document.frmHidden;
	var sch = "";
	var sd = frmM.sd.value;
	var ed = frmM.ed.value;
	if (sd != "" && ed != "" && sd == ed) {
		alert("같은날짜를 선택했습니다.")
		history.href = "/cworld_admin/sta_amount";
		return false;
	}
	if (sd != "" || ed != "") {
		if (sch != "") {
			sch += ","
		}
		sch += "r" + sd + ":" + ed;
	}

	frm.sch.value = sch;
	frm.submit();
}
$(document).ready(function() {
	$.datepicker.regional['ko'] = {
		closeText: '닫기',
		prevText: '이전달',
		nextText: '다음달',
		currentText: '오늘',
		monthNames: ['1월','2월','3월','4월','5월','6월',
		'7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월',
		'7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		//buttonImage: "/images/kr/create/btn_calendar.gif",
		buttonImageOnly: true,
		// showOn :"both",
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd',
		firstDay: 0,
		isRTL: false,
		duration:200,
		showAnim:'show',
		showMonthAfterYear: false
		// yearSuffix: '년'
	};
	$.datepicker.setDefaults($.datepicker.regional['ko']);

	$( "#edusdate" ).datepicker({
		//defaultDate: "+1w",
		changeMonth: true,
		//numberOfMonths: 3,
		dateFormat:"yy-mm-dd",
		onClose: function( selectedDate ) {
			//$( "#eday" ).datepicker( "option", "minDate", selectedDate );
		}
	});
	$( "#eduedate" ).datepicker({
		//defaultDate: "+1w",
		changeMonth: true,
		//numberOfMonths: 3,
		dateFormat:"yy-mm-dd",
		onClose: function( selectedDate ) {
			//$( "#sday" ).datepicker( "option", "maxDate", selectedDate );
		}
	});
});
function resetSch() {
	var sch = "";
	var frm = document.frmHidden;
	frm.sch.value = sch;
	frm.submit();
}
</script>
<style>
#subnavi04 { display:block; }
</style>
</head>
<body>
<div class="contentDiv">
<table align="center" width="500">
<tr><td>
<form name="frmHidden">
	<input type="hidden" name="sch" value="<%=sch %>" />
</form>
<form name="memSchFrm" id="schFrm">
기간 : 
<input type="text" name="sd" id="edusdate" value="<%=sd %>" size="10" class="ipt" /> ~
<input type="text" name="ed" id="eduedate" value="<%=ed %>" size="10" class="ipt" />
<input type="button" value="검색" class="btn" onclick="makeSch();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="검색초기화" class="btn resetSch" onclick="resetSch();" />
</form>
</td></tr>
</table>
<div id="canvas-holder">
<canvas id="chart-area"></canvas>
</div>
</div>
</body>
</html>