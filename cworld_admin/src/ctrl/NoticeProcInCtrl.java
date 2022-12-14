package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;

@WebServlet("/notice_proc_in")
public class NoticeProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;  
    public NoticeProcInCtrl() { super(); }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		AdminInfo loginInfo = (AdminInfo)session.getAttribute("loginInfo");
		
		String nl_title = request.getParameter("nl_title").trim().replace("'", "''").replace("<", "&lt;");
		String nl_content = request.getParameter("nl_content").trim().replace("'", "''").replace("<", "&lt;");
		String nl_ctgr = request.getParameter("ctgr");
		String nl_isview = request.getParameter("isview");
		
		NoticeInfo noticeInfo = new NoticeInfo();	
		noticeInfo.setNl_title(nl_title);
		noticeInfo.setNl_content(nl_content);
		noticeInfo.setNl_ctgr(nl_ctgr);
		noticeInfo.setNl_isview(nl_isview);
		noticeInfo.setAi_idx(loginInfo.getAi_idx());
		
		ListSvc ListSvc = new ListSvc();
		
		
		int idx = ListSvc.noticeInsert(noticeInfo);
		// insert 쿼리를 실행하므로 insert 된 레코드 개수를 받아오는 것이 일반적이나, 처리 후 해당 글 보기화면으로 가야 하기 떄문에 해당 글의 글번호를 받아옴
		
		if (idx > 0) {	// 정상적으로 글이 등록되었으면
			response.sendRedirect("notice_view?cpage=1&idx=" + idx);
		} else {			// 글 등록시 문제가 발생 했으면
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('글 등록에 실패했습니다. 다시 시도해보세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}

}
