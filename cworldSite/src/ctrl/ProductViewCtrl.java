package ctrl;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/product_view")
public class ProductViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ProductViewCtrl() {  super();  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String piid = request.getParameter("piid");
		PdtInfo pdtInfo = null;
		String jjimOX = "X";
		ProductViewSvc productViewSvc = new ProductViewSvc();
		ArrayList<ReviewInfo> reviewList = new ArrayList<ReviewInfo>();
		
		pdtInfo = productViewSvc.getProductView(piid);
		
		if (pdtInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('상품정보가 없습니다.'); history.back();");
			out.println("</script>");
			out.close();
		} else {
			int result = productViewSvc.readUpdate(piid);
			reviewList = productViewSvc.getReviewList(piid);
		}
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if(loginInfo != null) {
			JjimProcSvc jjimProcSvc = new JjimProcSvc();
			jjimOX = jjimProcSvc.amIJjim(loginInfo.getMi_id(), piid);
		}
		
		request.setAttribute("pdtInfo", pdtInfo);
		request.setAttribute("reviewList", reviewList);
		request.setAttribute("jjimOX", jjimOX);
		RequestDispatcher dispatcher =  request.getRequestDispatcher("product/product_view.jsp");
    	dispatcher.forward(request, response);
	}
}
