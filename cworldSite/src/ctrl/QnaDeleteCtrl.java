package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;

@WebServlet("/qna_del")
public class QnaDeleteCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public QnaDeleteCtrl() { super(); }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		QnaDeleteSvc qnaDeleteSvc = new QnaDeleteSvc();
		int result = qnaDeleteSvc.qnaDelete(idx);
		
		response.setContentType("text/html; charset=utf-8"); 
		PrintWriter out = response.getWriter();
		
		try {
			out.println(result);
		} catch (Exception e) {
			out.println(result);
			e.printStackTrace();
		}
		out.close();
	}

}
