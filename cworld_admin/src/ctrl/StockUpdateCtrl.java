package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;

@WebServlet("/stockUpdate")
public class StockUpdateCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public StockUpdateCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String ps_idx = request.getParameter("psidx");
		String ps_stock = request.getParameter("psstock");
		System.out.println("ps_idx : " + ps_idx);
		System.out.println("ps_stock : " + ps_stock);
		StockUpdateSvc stockUpdateSvc = new StockUpdateSvc();
		int result = stockUpdateSvc.stockUp(ps_idx, ps_stock);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
		out.close();
	}

}
