package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;

@WebServlet("/find_id")
public class FindIdCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public FindIdCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String by = request.getParameter("by");
		String name = request.getParameter("name");
		String e1 = request.getParameter("e1");
		String e3 = request.getParameter("e3");
		
		String p1 = request.getParameter("p1");
		String p2 = request.getParameter("p2");
		String p3 = request.getParameter("p3");
		String where = " where mi_name = '" + name + "' ";
		System.out.println(by);
		if (by.contentEquals("mail")) {
			String email = e1 + "@" + e3;
			where += " and mi_mail = '" + email + "' ";
		} else {
			String phone = p1 + "-" + p2 + "-" + p3;
			where += " and mi_phone = '" + phone + "' ";
		}
		FindIdSvc findIdSvc = new FindIdSvc();
		String miid = findIdSvc.getFindId(where);
		
		request.setAttribute("miid", miid);
		RequestDispatcher dispatcher =  request.getRequestDispatcher("member/findId_after.jsp");
    	dispatcher.forward(request, response);
	}
}
