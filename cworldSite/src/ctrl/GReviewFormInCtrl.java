package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/g_review_form_ctrl")
public class GReviewFormInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L; 
    public GReviewFormInCtrl() { super(); }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String url = request.getParameter("idx").replace('$', '&');
    	int idx = Integer.parseInt(url.substring(0, url.indexOf('&')));
    	String gname = url.substring(url.lastIndexOf('=') + 1);

    	request.setAttribute("idx", idx);
    	request.setAttribute("gname", gname);
    	
    	RequestDispatcher dispatcher = request.getRequestDispatcher("bbs/g_review_form.jsp");
		dispatcher.forward(request, response);
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
