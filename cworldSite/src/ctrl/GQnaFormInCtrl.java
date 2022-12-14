package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import vo.MemberInfo;

@WebServlet("/g_qna_form_in")
public class GQnaFormInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public GQnaFormInCtrl() {	super();	}

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 작성할 수 있습니다.');");
			out.println("location.href='/cworldSite/login_form.jsp?url=g_qna_form_in'");
			out.println("</script>");
			out.close();
		}
    	RequestDispatcher dispatcher = request.getRequestDispatcher("bbs/g_qna_form_in.jsp");
    		dispatcher.forward(request, response);
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
}
