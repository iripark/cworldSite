package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;

@WebServlet("/admin_login")
public class AdminLoginCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminLoginCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uid = request.getParameter("uid").trim();
		String pwd = request.getParameter("pwd").trim();
		
		AdminLoginSvc adminLoginSvc = new AdminLoginSvc();
		AdminInfo loginInfo = adminLoginSvc.getLoginAdmin(uid, pwd);
		
		if (loginInfo != null) {
			HttpSession session = request.getSession();	
			session.setAttribute("loginInfo", loginInfo);
			session.setMaxInactiveInterval(600);
			response.sendRedirect("index.jsp");
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script> alert('아이디와 암호를 확인하세요.'); history.back(); </script>");
		}
	}

}
