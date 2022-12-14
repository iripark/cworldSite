package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;

@WebServlet("/review_view")
public class ReviewViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ReviewViewCtrl() { super(); }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		ListSvc listSvc = new ListSvc();
		int result = listSvc.readUpdateReview(idx);
		// 사용자가 선택한 게시글의 조회수를 증가시키는 메소드 호출
		ReviewInfo ri = listSvc.getReviewInfo(idx);
		// 사용자가 선택한 게시글의 내용들을 FreeList형 인스턴스 freeList에 저장
		request.setAttribute("piid", request.getParameter("piid"));
		if (ri != null) {
			request.setAttribute("ri", ri);
			// request 객체에 freeInfo라는 이름의 속성을 freeList값을 가지게 하여 선언 및 생성
			RequestDispatcher dispatcher = request.getRequestDispatcher("bbs/review_view.jsp");
			dispatcher.forward(request, response);
			// Redirect 방식이 아닌 Dispatcher 방식으로 이동시킴
			// Dispatcher 방식으로 이동하므로 url이 변경되지 않고 기존의 request와 response객체를 이동한 파일에서도 자유롭게 사용할 수 있게 됨
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
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
