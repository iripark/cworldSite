package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/answer_qna")
public class AnswerQnaCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AnswerQnaCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String ql_answer = request.getParameter("ql_answer").trim().replace("'", "''").replace("<", "&lt;");
		String ql_ai_name = request.getParameter("aname");
		int idx = Integer.parseInt(request.getParameter("idx"));
		String sch = request.getParameter("sch");
		QnaInfo qi = new QnaInfo();
		qi.setQl_idx(idx);
		qi.setQl_ai_name(ql_ai_name);
		qi.setQl_answer(ql_answer);
		
		AnswerQnaSvc answerQnaSvc = new AnswerQnaSvc();
		int result = answerQnaSvc.answerQna(idx, ql_ai_name, ql_answer);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if (result == 1) {
			out.println("<script>");
			out.println("alert('답변 등록이 완료되었습니다.');");
			out.println("</script>");
			response.sendRedirect("qna_list?sch=" + sch);
		} else {
			out.println("<script>");
			out.println("alert('답변 등록을 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		out.close();			
	}
}
