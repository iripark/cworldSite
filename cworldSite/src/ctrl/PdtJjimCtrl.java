package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/pdt_jjim")
public class PdtJjimCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public PdtJjimCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String piid = request.getParameter("piid");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		
		PdtJjimSvc pdtJjimSvc = new PdtJjimSvc();
		int result = pdtJjimSvc.jjimInsert(miid, piid);
		
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
