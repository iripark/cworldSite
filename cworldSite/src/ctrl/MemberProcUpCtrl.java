package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;

@WebServlet("/member_proc_up")
public class MemberProcUpCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MemberProcUpCtrl() { super(); }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String newPwChk = request.getParameter("newPwChk");
		String sql = "update t_member_info set ";
		if (newPwChk.contentEquals("y")) {
		String mi_pw = request.getParameter("mi_pw");
		sql += " mi_pw = '" + mi_pw + "', ";
		}
		String p1 = request.getParameter("p1");
		String p2 = request.getParameter("p2");
		String p3 = request.getParameter("p3");
		String phone = p1 + "-" + p2 + "-" + p3; 
		String e1 = request.getParameter("e1");
		String e3 = request.getParameter("e3");
		String mail = e1 + "@" + e3;
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if(loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script> alert('로그인 정보가 존재하지 않습니다.');");
			out.println("location.replace('/cworldSite/login_form.jsp?url=cart_view'); ");
			out.println("</script>");
			out.close();
		}
		String miid = loginInfo.getMi_id();
		sql += " mi_phone = '" + phone + "', mi_mail = '" + mail + "' where mi_id = '" + miid + "' ";
		
		MemberProcUpSvc memberProcUpSvc = new MemberProcUpSvc();
		int result = memberProcUpSvc.getMemberUpdate(sql);
		
		response.sendRedirect("member/info_form.jsp");
	}
}
