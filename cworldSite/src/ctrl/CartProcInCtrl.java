package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/cart_proc_in")
public class CartProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public CartProcInCtrl() {   super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String piid = request.getParameter("piid");
		int psidx = Integer.parseInt(request.getParameter("psidx"));
		int count = Integer.parseInt(request.getParameter("count"));
		String period = request.getParameter("period");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		int result = 0;
		CartProcInSvc cartProcInSvc = new CartProcInSvc();
		if ( period == null || period.equals("")) {
			result = cartProcInSvc.cartInsert(miid, piid, psidx, count);
		} else {
			String[] arrDate = period.split(" ");
			
			result = cartProcInSvc.cartInsert(miid, piid, psidx, count, arrDate[0], arrDate[2]);
		}
		
		response.setContentType("text.html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
	}
}
