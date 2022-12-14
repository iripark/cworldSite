package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;

@WebServlet("/member_page")
public class MemberInfoCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MemberInfoCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	HttpSession session = request.getSession();
    	MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
    	String miid = loginInfo.getMi_id();
    	
    	SimpleInfoSvc simpleInfoSvc = new SimpleInfoSvc();
    	String simpleOrder = simpleInfoSvc.getSimple(miid);
    	int mipoint = simpleInfoSvc.getPoint(miid);
    	
    	request.setAttribute("simpleOrder", simpleOrder);
    	request.setAttribute("mipoint", mipoint);
    	RequestDispatcher dispatcher = request.getRequestDispatcher("member/member_mypage.jsp");
		dispatcher.forward(request, response);
    	
	}
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
