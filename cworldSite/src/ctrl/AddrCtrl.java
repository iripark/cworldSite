package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;
import java.util.*;

@WebServlet("/addr_ctrl")
public class AddrCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AddrCtrl() { super(); }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		
		AddrSvc addrSvc = new AddrSvc();
		ArrayList<MemberAddr> addrList = new ArrayList<MemberAddr>();
		
		addrList = addrSvc.getAddr(miid);
		
		request.setAttribute("addrList", addrList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("member/addr_list.jsp");
		dispatcher.forward(request, response);
		
	}
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
