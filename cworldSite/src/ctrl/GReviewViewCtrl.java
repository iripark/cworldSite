package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/g_review_view")
public class GReviewViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public GReviewViewCtrl() { super(); }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int idx = Integer.parseInt(request.getParameter("idx"));
		int cpage = Integer.parseInt(request.getParameter("cpage"));
		GReviewViewSvc GReviewViewSvc = new GReviewViewSvc();
		GReviewInfo gri = GReviewViewSvc.getGReviewInfo(idx);
		if (gri != null) {
			request.setAttribute("gri", gri);
			RequestDispatcher dispatcher = request.getRequestDispatcher("bbs/g_review_view.jsp");
			dispatcher.forward(request, response);
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어왔습니다.');");
			out.println("history.back();");
			out.println("</script>");
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
