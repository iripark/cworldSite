package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;

@WebServlet("/memberExitUpdate")
public class MemberExitUpdateCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MemberExitUpdateCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String miid = request.getParameter("miid");
		
		MemberExitUpdateSvc memberExitUpdateSvc = new MemberExitUpdateSvc();
		int result = memberExitUpdateSvc.memberExit(miid);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
		out.close();
	}

}
