package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;


@WebServlet("/qna_satis")
public class QnaSatisCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public QnaSatisCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int idx = Integer.parseInt(request.getParameter("idx"));
		String satis = request.getParameter("opt");
		
		QnaSatisSvc qnaSatisSvc = new QnaSatisSvc();
		int result = qnaSatisSvc.satisUp(idx, satis);
		
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
