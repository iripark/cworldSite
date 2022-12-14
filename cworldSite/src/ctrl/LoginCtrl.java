package ctrl;

import java.io.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import vo.*;
import svc.*;

@WebServlet("/login")
public class LoginCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public LoginCtrl() {   super();    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uid = request.getParameter("uid").trim().toLowerCase();
		String pwd = request.getParameter("pwd").trim();
		String url = request.getParameter("url").replace('$', '&');
		
		LoginSvc loginSvc = new LoginSvc();
		MemberInfo loginInfo = loginSvc.getLoginMember(uid, pwd);
		
		if (loginInfo != null) { // 로그인 성공
			loginSvc.getLoginUpdate(uid, pwd);
			HttpSession session = request.getSession();
			session.setAttribute("loginInfo", loginInfo);
			// 로그인한 회원의 정보를 담은 loginInfo 인스턴스를 세션의 속성으로 저장
			response.sendRedirect(url);
			
		} else {				 // 로그인 실패
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('아이디와 암호를 확인하세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}
}
