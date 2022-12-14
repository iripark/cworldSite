package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;


@WebServlet("/cart_proc_up")
public class CartProcUpCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public CartProcUpCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int ocidx = Integer.parseInt(request.getParameter("ocidx"));
		String optTmp = request.getParameter("opt").toString();
		int cnt = Integer.parseInt(request.getParameter("cnt"));

		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		OrderCart oc = new OrderCart();
		oc.setOc_idx(ocidx);
		oc.setMi_id(miid);
		oc.setOc_cnt(cnt);
		int opt = 0;
		if(optTmp.indexOf("^") > 0) {
			opt = Integer.parseInt(optTmp.substring(0, optTmp.indexOf("^")));
		} else {
			opt = Integer.parseInt(optTmp);
		}
		String kind = "";
		if(optTmp.indexOf("-") > 0) {
			kind = optTmp.substring(optTmp.indexOf("^") + 1, optTmp.indexOf("^" , optTmp.indexOf("^") + 1));		
			String date = optTmp.substring(optTmp.lastIndexOf("^") + 1);
			String[] arrD = date.split(" ");
			oc.setOcr_sdate(arrD[0]);
			oc.setOcr_edate(arrD[2]);
		} else {
			kind = optTmp.substring(optTmp.indexOf("^") + 1);
		}
		oc.setPs_idx(opt);
		
		CartProcUpSvc cartProcUpSvc = new CartProcUpSvc();
		int result = cartProcUpSvc.cartUpdate(kind, oc);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
		out.close();
	}

}
