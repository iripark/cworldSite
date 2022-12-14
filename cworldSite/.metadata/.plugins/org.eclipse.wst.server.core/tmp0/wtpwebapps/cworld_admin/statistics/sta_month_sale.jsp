<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String ms = (String)request.getAttribute("monthSale");
String[] monthSale = ms.split(",");

int p1 = 0, p2 = 0, p3 = 0, p4 = 0, p5 = 0, p6 = 0, p7 = 0, p8 = 0, p9 = 0, p10 = 0, p11 = 0, p12 = 0;
int s1 = 0, s2 = 0, s3 = 0, s4 = 0, s5 = 0, s6 = 0, s7 = 0, s8 = 0, s9 = 0, s10 = 0, s11 = 0, s12 = 0;
int r1 = 0, r2 = 0, r3 = 0, r4 = 0, r5 = 0, r6 = 0, r7 = 0, r8 = 0, r9 = 0, r10 = 0, r11 = 0, r12 = 0;
for (int i = 0; i < monthSale.length; i++) {
	String[] tmp = monthSale[i].split(":");
	if (tmp[0].equals("1")) {
		if (tmp[1].equals("S")) {
			s1 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("R")) {
			r1 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("P")) {
			p1 = Integer.parseInt(tmp[2]);
		}
	} else if (tmp[0].equals("2")) {
		if (tmp[1].equals("S")) {
			s2 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("R")) {
			r2 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("P")) {
			p2 = Integer.parseInt(tmp[2]);
		}
	} else if (tmp[0].equals("3")) {
		if (tmp[1].equals("S")) {
			s3 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("R")) {
			r3 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("P")) {
			p3 = Integer.parseInt(tmp[2]);
		}
	} else if (tmp[0].equals("4")) {
		if (tmp[1].equals("S")) {
			s4 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("R")) {
			r4 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("P")) {
			p4 = Integer.parseInt(tmp[2]);
		}
	} else if (tmp[0].equals("5")) {
		if (tmp[1].equals("S")) {
			s5 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("R")) {
			r5 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("P")) {
			p5 = Integer.parseInt(tmp[2]);
		}
	} else if (tmp[0].equals("6")) {
		if (tmp[1].equals("S")) {
			s6 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("R")) {
			r6 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("P")) {
			p6 = Integer.parseInt(tmp[2]);
		}
	} else if (tmp[0].equals("7")) {
		if (tmp[1].equals("S")) {
			s7 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("R")) {
			r7 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("P")) {
			p7 = Integer.parseInt(tmp[2]);
		}
	} else if (tmp[0].equals("8")) {
		if (tmp[1].equals("S")) {
			s8 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("R")) {
			r8 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("P")) {
			p8 = Integer.parseInt(tmp[2]);
		}
	} else if (tmp[0].equals("9")) {
		if (tmp[1].equals("S")) {
			s9 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("R")) {
			r9 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("P")) {
			p9 = Integer.parseInt(tmp[2]);
		}
	} else if (tmp[0].equals("10")) {
		if (tmp[1].equals("S")) {
			s10 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("R")) {
			r10 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("P")) {
			p10 = Integer.parseInt(tmp[2]);
		}
	} else if (tmp[0].equals("11")) {
		if (tmp[1].equals("S")) {
			s11 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("R")) {
			r11 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("P")) {
			p11 = Integer.parseInt(tmp[2]);
		}
	} else if (tmp[0].equals("12")) {
		if (tmp[1].equals("S")) {
			s12 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("R")) {
			r12 = Integer.parseInt(tmp[2]);
		} else if (tmp[1].equals("P")) {
			p12 = Integer.parseInt(tmp[2]);
		}
	}
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
var config1 = {
	type: 'line',
	data: {
		labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
		datasets: [{
			label: '대여', 
			backgroundColor: window.chartColors.red,
			borderColor: window.chartColors.red,
			data: [<%=r1 %>, <%=r2 %>, <%=r3 %>, <%=r4 %>, <%=r5 %>, <%=r6 %>, <%=r7 %>, <%=r8 %>, <%=r9 %>, <%=r10 %>, <%=r11 %>, <%=r12 %>], 
			fill: false,
		}, {
			label: '판매', 
			fill: false,
			backgroundColor: window.chartColors.blue,
			borderColor: window.chartColors.blue,
			data: [<%=s1 %>, <%=s2 %>, <%=s3 %>, <%=s4 %>, <%=s5 %>, <%=s6 %>, <%=s7 %>, <%=s8 %>, <%=s9 %>, <%=s10 %>, <%=s11 %>, <%=s12 %>], 
		}, {
			label: '패키지', 
			fill: false,
			backgroundColor: window.chartColors.yellow,
			borderColor: window.chartColors.yellow,
			data: [<%=p1 %>, <%=p2 %>, <%=p3 %>, <%=p4 %>, <%=p5 %>, <%=p6 %>, <%=p7 %>, <%=p8 %>, <%=p9 %>, <%=p10 %>, <%=p11 %>, <%=p12 %>], 
		}]
	},
	options: {
		responsive: true,
		title: { display: true, text: '올해 월별 순이익' }, 
		tooltips: { mode: 'index', intersect: false }, 
		hover: { mode: 'nearest', intersect: true }, 
		scales: { 
			xAxes: [{ display:true, scaleLabel:{ display:true, labelString:'월별' } }],
			yAxes: [{ display:true, scaleLabel:{ display:true, labelString:'순이익' } }]
		}
	}
};
window.onload = function() {
	var ctx4 = document.getElementById('canvas4').getContext('2d');
	window.myLine = new Chart(ctx4, config1);
	 var minutes = 10;

	  var fiveMinutes = (60 * minutes) - 1,
	    display = document.querySelector('#MyTimer');
	  startTimer(fiveMinutes, display);
};

</script>
<style>
#subnavi04 { display:block; }

</style>
</head>
<body>
<div id="container2" class="contentDiv">
	<canvas id="canvas4"></canvas>
</div>
</body>
</html>