package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;
import java.util.*;


@WebServlet("/jjim_list")
public class JjimListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public JjimListCtrl() {  super(); }

	protected void doprocess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		ArrayList<PdtInfo> jjimList = null;
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if (loginInfo != null) {
			String miid = loginInfo.getMi_id();
			JjimListSvc jjimListSvc= new JjimListSvc();
			jjimList = jjimListSvc.getJjimList(miid);
		} else {				 // 로그인 실패
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('아이디와 암호를 확인하세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		request.setAttribute("jjimList", jjimList);
		RequestDispatcher dispatcher =  request.getRequestDispatcher("member/jjim_list.jsp");
    	dispatcher.forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doprocess(request, response);
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doprocess(request, response);
	}
}
