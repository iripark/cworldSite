package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;

@WebServlet("/memberPointUpdate")
public class MemberPointUpdateCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MemberPointUpdateCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String miid = request.getParameter("miid");
		int point = Integer.parseInt(request.getParameter("point"));
		
		MemberPointUpdateSvc memberPointUpdateSvc = new MemberPointUpdateSvc();
		int result = memberPointUpdateSvc.memPointUpdate(miid, point);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
		out.close();
		
	}

}
