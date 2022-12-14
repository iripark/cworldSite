package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;


@WebServlet("/basic_up")
public class BasicUpCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public BasicUpCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		BasicUpSvc basicUpSvc = new BasicUpSvc();
		int result = basicUpSvc.basicUp(miid, idx);
		
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
