package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;
import java.util.*;

@WebServlet("/product_form_up")
public class ProductFormUpCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ProductFormUpCtrl() { super(); }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String pi_id = request.getParameter("id");
		int ps_idx = Integer.parseInt(request.getParameter("idx"));
		ProductFormUpSvc productFormUpSvc = new ProductFormUpSvc();
		ProductInfo pi = productFormUpSvc.getPdtInfo(pi_id, ps_idx);
		
		ProductListSvc productListSvc = new ProductListSvc();
		ArrayList<PdtCtgrSmall> pcs = productListSvc.getSmallList(pi.getPcb_id());
		
		if (pi != null) {
			request.setAttribute("pi", pi);
			request.setAttribute("pcs", pcs);
			RequestDispatcher dispatcher = request.getRequestDispatcher("product/product_form_up.jsp");
			dispatcher.forward(request, response);
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script> alert('아이디와 암호를 확인하세요.'); history.back(); </script>");
			out.close();
		}
		
		
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
