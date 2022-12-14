package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;


@WebServlet("/qna_view")
public class QnaViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public QnaViewCtrl() { super(); }
	
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	int idx = Integer.parseInt(request.getParameter("idx"));
    	int cpage = Integer.parseInt(request.getParameter("cpage"));
    	
    	QnaViewSvc qnaViewSvc = new QnaViewSvc();
    	QnaInfo qi = qnaViewSvc.getQnaInfo(idx);
    	
    	if (qi != null) {
			request.setAttribute("qi", qi);
			// request 객체에 freeInfo라는 이름의 속성을 freeList값을 가지게 하여 선언 및 생성
			RequestDispatcher dispatcher = request.getRequestDispatcher("member/qna_view.jsp");
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
