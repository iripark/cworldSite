package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;

@WebServlet("/memberStatusUpdate")
public class MemberStatusUpdateCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MemberStatusUpdateCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uid = request.getParameter("uid").substring(1);
		String where = " where ";
		String[] memUid = uid.split(",");
		for (int i = 0; i < memUid.length; i++) {
			if (i + 1 != memUid.length) {
				where += " mi_id = '" + memUid[i] + "' or ";
			} else {
				where += " mi_id = '" + memUid[i] + "' ";
			}
		}
		MemberStatusUpdateSvc memberStatusUpdateSvc = new MemberStatusUpdateSvc();
		int result = memberStatusUpdateSvc.memStatusUpdate(where);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
		out.close();
		
	}
}
