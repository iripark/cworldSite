package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/review_form_in")
public class ReviewFormInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ReviewFormInCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String oiid = request.getParameter("oi_id");
		String miid = request.getParameter("mi_id");
		String piid = request.getParameter("pi_id");
		int psidx = Integer.parseInt(request.getParameter("ps_idx"));
		String piname = request.getParameter("pi_name");
		String psopt = request.getParameter("ps_opt");
		if (psopt.equals("a")) {
			psopt = "빨강";
		} else if (psopt.equals("b")) {
			psopt = "파랑";
		} else if (psopt.equals("c")) {
			psopt = "검정";
		} else if (psopt.equals("d")) {
			psopt = "단일 옵션";
		} else {
			psopt = "대여";
		}
		
		
		String info = miid + ":" + oiid + ":" + piid + ":" + psidx + ":" + piname + " - " + psopt;
		request.setAttribute("info", info);
		RequestDispatcher dispatcher = request.getRequestDispatcher("member/review_form.jsp");
		dispatcher.forward(request, response);
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
