package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;

@WebServlet("/isRturnUpdate")
public class IsReturnCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public IsReturnCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int idx = Integer.parseInt(request.getParameter("ord_idx"));
		String isRe = request.getParameter("isReturn");
		int cnt = Integer.parseInt(request.getParameter("cnt"));
		int psidx = Integer.parseInt(request.getParameter("psidx"));
		System.out.println(psidx + "ctrl");
		
		ProductIsReturnSvc productIsReturnSvc = new ProductIsReturnSvc();
		int result = productIsReturnSvc.isReturnUpdate(idx, isRe, cnt, psidx);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
		out.close();
	}

}
