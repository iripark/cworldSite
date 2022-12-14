package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;

@WebServlet("/reviewUp")
public class ReviewUpdateCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ReviewUpdateCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int idx = Integer.parseInt(request.getParameter("idx"));
		String isview = request.getParameter("is");
		
		ReviewUpdateSvc reviewUpdateSvc = new ReviewUpdateSvc();
		int result = reviewUpdateSvc.reviewUpdate(idx, isview);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
		out.close();
	}

}
