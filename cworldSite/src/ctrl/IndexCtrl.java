package ctrl;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/index")
public class IndexCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public IndexCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		IndexSvc indexSvc = new IndexSvc();
		String preSql = "select * from t_product_info where pi_isview = 'y' ";
		String where = " and (left(pi_id, 1) = 'R' or left(pi_id, 1) = 'P') ";
		String orderBy = " order by pi_date desc limit 0, 12";
		// 대여 날짜 최신순
		String sql = preSql + where + orderBy;
		ArrayList<PdtInfo> nrList = indexSvc.getIndexList(sql);
		// 대여 판매 큰순
		sql = preSql + where + "order by pi_srcnt desc limit 0, 12";
		ArrayList<PdtInfo> brList = indexSvc.getIndexList(sql);
		// 구매 날짜 최신순
		where = " and left(pi_id, 1) = 'S' ";
		sql = preSql + where + orderBy;
		ArrayList<PdtInfo> nbList = indexSvc.getIndexList(sql);
		// 구매 판매 큰순 
		sql = preSql + where + " order by pi_srcnt desc limit 0, 12";
		ArrayList<PdtInfo> bbList = indexSvc.getIndexList(sql);
		
		request.setAttribute("nrList", nrList);
		request.setAttribute("brList", brList);
		request.setAttribute("nbList", nbList);
		request.setAttribute("bbList", bbList);
		
		RequestDispatcher dispatcher =  request.getRequestDispatcher("/indexr.jsp");
    	dispatcher.forward(request, response);
	}
}
