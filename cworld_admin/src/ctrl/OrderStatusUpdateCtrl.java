package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import java.util.*;

@WebServlet("/orderStatusUpdate")
public class OrderStatusUpdateCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public OrderStatusUpdateCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String oiid = request.getParameter("oi_id");
		String status = request.getParameter("status");
		
		OrderStatusUpdateSvc orderStatusUpdateSvc = new OrderStatusUpdateSvc();
		int result = orderStatusUpdateSvc.statusUpdate(oiid, status);
		
		if (status.equals("c")) {
			String[] arrRnd = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
			Random rnd = new Random();
			String invoice = "";
			for(int i = 0; i < 15; i++) {
				invoice += arrRnd[rnd.nextInt(62)];
			}
			orderStatusUpdateSvc.invoiceUpdate(oiid, invoice);
		}
		System.out.println(result);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
		out.close();
		
	}

}
