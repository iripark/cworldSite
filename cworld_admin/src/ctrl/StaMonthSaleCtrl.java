package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;

@WebServlet("/sta_month_sale")
public class StaMonthSaleCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public StaMonthSaleCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		StaHomeSvc staHomeSvc = new StaHomeSvc(); 
		String monthSale = staHomeSvc.getMonthSale();
		
		request.setAttribute("monthSale", monthSale);
		RequestDispatcher dispatcher = request.getRequestDispatcher("statistics/sta_month_sale.jsp");
		dispatcher.forward(request, response);
	}

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
