package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/notice_proc_up")
public class NoticeProcUpCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public NoticeProcUpCtrl() { super(); }
  
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
		String isview = request.getParameter("isview");
		String ctgr = request.getParameter("ctgr");
		int idx = Integer.parseInt(request.getParameter("idx"));
		int cpage = Integer.parseInt(request.getParameter("cpage"));
		String nl_title = request.getParameter("nl_title");
		String nl_content = request.getParameter("nl_content");
		
		HttpSession session = request.getSession();
		AdminInfo loginInfo = (AdminInfo)session.getAttribute("loginInfo");
		int ai_idx = loginInfo.getAi_idx();
		
		NoticeInfo ni = new NoticeInfo();
		ni.setAi_idx(ai_idx);
		ni.setNl_content(nl_content);
		ni.setNl_ctgr(ctgr);
		ni.setNl_isview(isview);
		ni.setNl_title(nl_title);
		ni.setNl_idx(idx);
		ListSvc listSvc = new ListSvc();
		int result = listSvc.noticeUpdate(ni);
		
		if (result > 0) {
			response.sendRedirect("notice_view?idx=" + idx + "&cpage=" + cpage);
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('글 수정에 실패했습니다. 다시 시도해보세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
}
