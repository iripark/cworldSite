package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/g_qna_proc_in")
public class GQnaProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public GQnaProcInCtrl() { super(); }
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String gq_title = request.getParameter("gq_title").trim().replace("'","''").replace("<", "&lt;");
		String gq_content = request.getParameter("gq_content").trim().replace("'","''").replace("<", "&lt;");
		String p1 = request.getParameter("p1");
		String p2 = request.getParameter("p2");
		String p3 = request.getParameter("p3");
		String e1 = request.getParameter("e1");
		String e2 = request.getParameter("e2");
		String gq_gname = request.getParameter("gq_gname");
		String gq_phone =  p1 + "-" + p2 + "-" + p3;
		String email = e1 + "@" + e2;
		
		String gq_ef = email;
			
		
		GqnaInfo gqnaInfo = new GqnaInfo();	// 게시글 정보를 저장할 인스턴스
		gqnaInfo.setGq_title(gq_title);
		gqnaInfo.setGq_gname(gq_gname);
		gqnaInfo.setGq_content(gq_content);
		gqnaInfo.setGq_phone(gq_phone);
		gqnaInfo.setGq_ef(gq_ef);
		gqnaInfo.setGq_ip(request.getRemoteAddr());
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		// 등록할 때 필요한(t_free_list 테이블에 저장할) 데이터들을 모두 FreeList형 인스턴스 freeList에 저장
		String miid = loginInfo.getMi_id();
		gqnaInfo.setMi_id(miid);
		GQnaProcInSvc gQnaProcInSvc = new GQnaProcInSvc();
		int idx = gQnaProcInSvc.GqnaListInsert(gqnaInfo);
		// insert 쿼리를 실행하므로 insert도니 레코드 개수를 받아오는 것이 일반적이나,
		// 처리 후 해당 글 보기 화면으로 가야 하기 때문에 해당 글의 글번호를 받아옴
		
		if (idx > 0) {	// 정상적으로 글이 등록되엇으면
			response.sendRedirect("g_qna_view?cpage=1&idx=" + idx);
		} else {	// 글 등록시 문제가 발생했으면
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('글 등록에 실패했습니다. 다시 시도해 보세요.');");
			out.println("history.back()");
			out.println("</script>");
			
			
		}
	}
}

