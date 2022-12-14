package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;


@WebServlet("/basic_del")
public class BasicDelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public BasicDelCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		String idxs = request.getParameter("idx");
		String where = "";
		if (idxs.indexOf(',') > 0) {
			String[] arrIdx = idxs.split(",");
			for (int i = 0; i < arrIdx.length; i++) {
				if(i == 0) {
					where += " and (ma_idx = " + arrIdx[i];
				} else {
					where += " or ma_idx = " + arrIdx[i];
				}
			}
			where += ")";
		} else {
			where += " and ma_idx = " + idxs;
		}
		
		
		
		BasicDelSvc basicDelSvc = new BasicDelSvc();
		int result = basicDelSvc.basicDel(miid, where);
		
		response.setContentType("text/html; charset=utf-8"); 
		PrintWriter out = response.getWriter();
		
		try {
			out.println(result);
		} catch (Exception e) {
			out.println(result);
			e.printStackTrace();
		}
	}

}
