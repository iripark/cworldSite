package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/addr_proc_in")
public class AddrProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AddrProcInCtrl() { super(); }
 
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		String miid = loginInfo.getMi_id();
		String ma_name = request.getParameter("ma_name");
		String ma_receiver = request.getParameter("ma_receiver");
		String ma_zip = request.getParameter("ma_zip");
		String ma_addr1 = request.getParameter("ma_addr1");
		String ma_addr2 = request.getParameter("ma_addr2");
		String ma_phone = request.getParameter("p1") + "-" + request.getParameter("p2") + "-" + request.getParameter("p3");
		String ma_basic = request.getParameter("ma_basic");
		if (ma_basic == null) {
			ma_basic = "n";
		}
		
		MemberAddr ma = new MemberAddr();
		ma.setMi_id(miid);
		ma.setMa_name(ma_name);
		ma.setMa_receiver(ma_receiver);
		ma.setMa_zip(ma_zip);
		ma.setMa_addr1(ma_addr1);
		ma.setMa_addr2(ma_addr2);
		ma.setMa_phone(ma_phone);
		ma.setMa_basic(ma_basic);
		
		AddrProcInSvc addrProcInSvc = new AddrProcInSvc();
		addrProcInSvc.addrInsert(ma);
		
		response.sendRedirect("addr_ctrl");
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
