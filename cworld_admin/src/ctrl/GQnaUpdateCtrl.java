package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;

@WebServlet("/gqnaUp")
public class GQnaUpdateCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L; 
    public GQnaUpdateCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String kind = request.getParameter("kind");
		String value = request.getParameter("is");
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		GQnaUpdateSvc gQnaUpdateSvc = new GQnaUpdateSvc();
		int result = gQnaUpdateSvc.gqnaUpdate(kind, value, idx);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
		out.close();
	}

}
