package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.MemberInfo;

@WebServlet("/notice_proc_del")
public class NoticeProcDelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public NoticeProcDelCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
    	
		int idx = Integer.parseInt(request.getParameter("idx"));
    	
    	ListSvc listSvc = new ListSvc();
    	int result = listSvc.NoticeDelete(idx);
    	
    	if (result == 1) {
    		response.sendRedirect("notice_list");
    	} else {
    		response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");			
			out.println("alert('글 삭제에 실패했습니다. \\n다시 시도하세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
    	}
	}
}
