package ctrl;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;

@WebServlet("/dupPw")
public class DupPwCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public DupPwCtrl() {  super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uid = request.getParameter("uid").trim().toLowerCase();
		String pwd = request.getParameter("pwd").trim().toLowerCase();
		response.setContentType("text/html; charset=utf-8"); 
		PrintWriter out = response.getWriter();
		
		try {
			DupPwSvc dupPwSvc = new DupPwSvc();
			int result = dupPwSvc.chkDupPw(uid, pwd);
			out.println(result);
		} catch (Exception e) {
			out.println(1);
			e.printStackTrace();
		}
	}
}

