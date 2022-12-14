package ctrl;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;

@WebServlet("/g_qna_view")
public class GQnaViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public GQnaViewCtrl() { super(); }
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	int idx = Integer.parseInt(request.getParameter("idx"));

    	
    	HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = "";
		if (loginInfo != null) {
			miid = loginInfo.getMi_id();
		}
		
		
		GqnaListSvc gqnaListSvc = new GqnaListSvc();
		String writer = gqnaListSvc.getWriter(idx);
		if (loginInfo == null || !writer.equals(miid)) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('글 작성자만 볼 수 있습니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
		}
		
		
		GqnaInfo gqnaInfo = gqnaListSvc.getGqnaInfo(idx);
		
		if (gqnaInfo != null) {
			request.setAttribute("gqnaInfo", gqnaInfo);
			RequestDispatcher dispatcher = request.getRequestDispatcher("bbs/g_qna_view.jsp");
			dispatcher.forward(request, response);			
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어왔습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}
}
