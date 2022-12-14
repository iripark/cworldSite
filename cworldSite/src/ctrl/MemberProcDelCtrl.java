package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/member_proc_del")
public class MemberProcDelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MemberProcDelCtrl() {  super();  }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uid = request.getParameter("uid");
		String pwd = request.getParameter("pwd");
		
		String sql = "update t_member_info set mi_status = 'c' where mi_id = '"
				+ uid + "' and mi_pw = '" + pwd + "' ";
		
		MemberProcDelSvc memberProcDelSvc = new MemberProcDelSvc();
		int result = memberProcDelSvc.memberLeave(sql);
		
		if (result > 0) {
		response.sendRedirect("/cworldSite/member/leave_after.jsp");
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script> alert('비밀번호 확인에 실패했습니다.'); history.back(); </script> ");
			out.close();
		}
	}
}
