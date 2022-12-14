package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;

@WebServlet("/notice_view")
public class NoticeViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public NoticeViewCtrl() { super(); }
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		ListSvc listSvc = new ListSvc();
		listSvc.readUpdate(idx);
		
		NoticeInfo noticeInfo = listSvc.getNoticeInfo(idx);
		
		if (noticeInfo != null) {
			request.setAttribute("noticeInfo", noticeInfo);
			RequestDispatcher dispatcher = request.getRequestDispatcher("bbs/notice_view.jsp");
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
