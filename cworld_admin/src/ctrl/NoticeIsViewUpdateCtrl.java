package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;

@WebServlet("/noticeUpdate")
public class NoticeIsViewUpdateCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public NoticeIsViewUpdateCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int idx = Integer.parseInt(request.getParameter("idx"));
		String isview = request.getParameter("isview");
		
		ListSvc listSvc = new ListSvc();
		int result = listSvc.isviewUpdate(idx, isview);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
		out.close();
	}

}
