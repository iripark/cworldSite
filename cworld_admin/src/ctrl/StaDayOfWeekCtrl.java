package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;

@WebServlet("/sta_day_of_week")
public class StaDayOfWeekCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public StaDayOfWeekCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String sch = request.getParameter("sch");
		if (sch == null) {
    		sch = "";
    	}
    	String startDate = "";
    	String endDate = "";
    	if (sch != null && !sch.equals("")) {
    	// 검색조건 예시 :  &sch=s2022-10-10:2022-10-14
			String sd = sch.substring(1, sch.indexOf(':'));
			if (sd != null && !sd.equals("")) {
				startDate = sd;
			}
			String ed = sch.substring(sch.indexOf(':') + 1);
			if (ed != null && !ed.equals("")) {
				endDate = ed;
			}
    	}
		
		StaHomeSvc staHomeSvc = new StaHomeSvc(); 
		String dayOfWeek = staHomeSvc.getDayOfWeek(startDate, endDate);
				
		request.setAttribute("dayOfWeek", dayOfWeek);
		request.setAttribute("sch", sch);
		RequestDispatcher dispatcher = request.getRequestDispatcher("statistics/sta_day_of_week.jsp");
		dispatcher.forward(request, response);
	}

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
