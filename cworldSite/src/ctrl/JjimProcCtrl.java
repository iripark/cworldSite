package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;
import java.util.*;

@WebServlet("/jjim_proc")
public class JjimProcCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public JjimProcCtrl() { super(); }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		String piid = request.getParameter("piid");
		
		response.setContentType("text/html; charset=utf-8"); 
		PrintWriter out = response.getWriter();
		try {
			JjimProcSvc jjimProcSvc = new JjimProcSvc();
			int result = jjimProcSvc.jjimClick(miid, piid);
			out.println(result);
		} catch (Exception e) {
			out.println(0);
			e.printStackTrace();
		}	
	}

}
