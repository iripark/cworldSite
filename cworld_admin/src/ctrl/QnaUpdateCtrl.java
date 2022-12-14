package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;

@WebServlet("/qnaUp")
public class QnaUpdateCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public QnaUpdateCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int idx = Integer.parseInt(request.getParameter("idx"));
		String isview = request.getParameter("is");
		
		QnaUpdateSvc qnaUpdateSvc = new QnaUpdateSvc();
		int result = qnaUpdateSvc.qnaUpdate(idx, isview);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
		out.close();
	}

}
