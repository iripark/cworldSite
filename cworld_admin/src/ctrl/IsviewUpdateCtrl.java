package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;

@WebServlet("/isviewUpdate")
public class IsviewUpdateCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public IsviewUpdateCtrl() { super(); }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String isview = request.getParameter("pi_isview");
		int ps_idx = Integer.parseInt(request.getParameter("ps_idx"));
		String pi_id = request.getParameter("pi_id");
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		try {
			IsviewUpdateSvc isviewUpdateSvc = new IsviewUpdateSvc();
			int result = isviewUpdateSvc.isviewUp(isview, ps_idx, pi_id);
			out.println(result);
		} catch(Exception e) {
			e.printStackTrace();
			out.println(0);
		}
		out.close();
	}

}
