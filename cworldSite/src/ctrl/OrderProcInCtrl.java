package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/order_proc_in")
public class OrderProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public OrderProcInCtrl() {super();}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		String kind = request.getParameter("kind");
		int total = Integer.parseInt(request.getParameter("total"));
		
		// 배송지 및 결제 정보 (장바구니(c), 바로구매(d) 공통)
		String oi_rname = request.getParameter("oi_rname");
		String p1 = request.getParameter("p1");
		String p2 = request.getParameter("p2");
		String p3 = request.getParameter("p3");
		String rphone = p1 + "-" + p2 + "-" + p3;
		String oi_rzip = request.getParameter("oi_rzip");
		String oi_raddr1 = request.getParameter("oi_raddr1");
		String oi_raddr2 = request.getParameter("oi_raddr2").trim().replace("'","''");
		String oi_memo = request.getParameter("oi_memo").trim().replace("'","''");
		String payment = request.getParameter("oi_payment");
		String status = "b";
		String upoint = request.getParameter("upoint");
		int oi_upoint = 0;
		if (upoint == null || upoint.equals("")) {
			oi_upoint = 0;
		} else {
			oi_upoint = Integer.parseInt(request.getParameter("upoint"));
		}
		int oi_spoint = Integer.parseInt(request.getParameter("spoint"));
		if (payment.equals("c"))  status = "a"; // 무통장입금일 경우 입금대기
		
		OrderInfo oi = new OrderInfo();
		oi.setMi_id(miid);
		oi.setOi_rname(oi_rname);
		oi.setOi_rphone(rphone);
		oi.setOi_rzip(oi_rzip);
		oi.setOi_raddr1(oi_raddr1);
		oi.setOi_raddr2(oi_raddr2);
		oi.setOi_memo(oi_memo);
		oi.setOi_payment(payment);
		oi.setOi_pay(total);
		oi.setOi_spoint(oi_spoint);
		oi.setOi_upoint(oi_upoint);
		oi.setOi_status(status);
		
		OrderProcInSvc orderProcInSvc = new OrderProcInSvc();
		String result = null;
		// 실행결과 배열로 주문번호와 적용된 레코드 개수, 적용되었어야할 레코드 개수를 문자열 배열으로 묶어서 저장
		if (kind.equals("c")) { // 장바구니를 통한 구매(c)일 경우
			String[] arr = request.getParameter("ocidxs").split(",");
			// 장바구니 테이블의 인덱스 번호들을 쉼표를 기준으로 배열로 받음
			String where = " and a.mi_id = '" + oi.getMi_id() + "' and (";
			for (int i = 0 ; i < arr.length ; i++) {
				if (i == 0)	where += "a.oc_idx = " + arr[i];
				else		where += " or a.oc_idx = " + arr[i];
			}
			where += ")";

			result = orderProcInSvc.orderInsert(oi, where);
		
		} else {	// 바로구매(d)일 경우
			String piid = request.getParameter("piid");
			int psidx = Integer.parseInt(request.getParameter("ps_idx"));
			int cnt = Integer.parseInt(request.getParameter("baro_cnt"));
			if (piid.charAt(0) != 'S') {
				String period = request.getParameter("period");
				String arrP[] = period.split(" ~ ");
				String sdate = arrP[0];
				String edate = arrP[1];
				oi.setOrd_sdate(sdate);
				oi.setOrd_edate(edate);
				oi.setOrd_cnt(cnt);	
			} else {
				oi.setOsd_cnt(cnt);
			}
			oi.setPs_idx(psidx);
			oi.setPi_id(piid);
			String where = "";
			result = orderProcInSvc.orderInsert(oi);
		}
		
		String[] arr = result.split(":");
		String oi_id = arr[0];	// 구매완료된 주문번호
		int rcount = Integer.parseInt(arr[1]);	// 실제 적용된 레코드 개수
		int target = Integer.parseInt(arr[2]);	// 적용되었어야 할 레코드 개수

		if (rcount == target) {	// 정상적으로 구매가 완료되었으면
			response.sendRedirect("/cworldSite/order/order_after.jsp?oiid=" + oi_id);
		} else {	// 비정상적으로 구매가 완료되었으면
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script> alert('구매에 실패했습니다.'); history.back(); </script>");
			out.close();
		}
	}
}
