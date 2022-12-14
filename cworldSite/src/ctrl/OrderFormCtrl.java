package ctrl;

import java.io.*;
import java.text.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;
import java.util.*;


@WebServlet("/order_form")
public class OrderFormCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public OrderFormCtrl() {    super();   }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String kind = request.getParameter("kind");
		// 장바구니를 통한 구매(c)인지 바로구매(d)인지 여부를 판단할 데이터
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		String sql = "";
		if (kind.contentEquals("c")) { // 장바구니를 통한 구매(c)일 경우
			 sql = "select a.*, b.pi_name, b.pi_dfee, b.pi_price, b.pi_dc, b.pi_img1, " + 
					" b.pi_price*(100-b.pi_dc)/100 realPrice, c.ps_opt, left(d.ocr_sdate, 10) sdate, " 
					+ " left(d.ocr_edate, 10) edate, d.ocr_period, a.oc_cnt cnt, a.oc_idx " + 
					" from t_order_cart a " + 
					" left join t_product_info b on b.pi_id = a.pi_id " + 
					" left join t_product_stock c on a.ps_idx = c.ps_idx and a.pi_id = c.pi_id " + 
					" left join t_order_cart_rent d on d.oc_idx = a.oc_idx " + 
					"where b.pi_isview = 'y' and c.ps_isview = 'y' and a.mi_id = '" + miid + "' and (";
					String[] arrOcidx = request.getParameterValues("ocidxs");
					for (int i = 1 ; i < arrOcidx.length ; i++ ) {
						sql += (i == 1 ? "":" or ") + " a.oc_idx = " + arrOcidx[i];
					}
					sql += ") order by b.pi_id, a.ps_idx";
			
		} else {	// 바로구매(d)일 경우
			String piid = request.getParameter("piid");
			String opt = request.getParameter("ps_opt");
			int cnt = Integer.parseInt(request.getParameter("cnt"));
			String sd = "0", ed = "0";
			long difftmp = 0;
			if (piid.charAt(0) != 'S') {
				String period = request.getParameter("period");
				System.out.println("period : " + period);
				String arr[] = period.split(" ~ ");
				sd = arr[0];
				ed = arr[1];
				System.out.println("sd : " + sd);
				System.out.println("ed : " + ed);
				try {
					DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					 /* Date타입으로 변경 */
					Date d1 = format.parse(sd);
					Date d2 = format.parse(ed);
					difftmp = (d2.getTime() - d1.getTime()) / (24*60*60*1000); // 일자수
				} catch (ParseException e) {
					e.printStackTrace();
				}				 
			} 
			String diff = difftmp + "";
			sql = "select a.pi_id, a.pi_img1, a.pi_name, b.ps_idx, b.ps_opt, "
					+ " a.pi_price, a.pi_dc, a.pi_dfee, a.pi_price*(100-a.pi_dc)/100 realPrice, " 
					+ cnt + " cnt, '" + sd + "' sdate, '" + ed + "' edate, " + diff + " ocr_period "
					+ " from t_product_info a, t_product_stock b "
					+ " where a.pi_id = b.pi_id and a.pi_isview = 'y' and b.ps_isview = 'y' "
					+ " and a.pi_id = '" + piid + "' and b.ps_idx = " + opt;
			
		}
		
		OrderFormSvc orderFormSvc = new OrderFormSvc();
		ArrayList<OrderCart> buyList = orderFormSvc.getBuyList(kind, sql);
		// 구매할 상품 목록을 ArrayList로 받아옴
		ArrayList<MemberAddr> addrList = orderFormSvc.getAddrList(miid);
		// 현재 로그인한 회원의 주소 목록을 ArrayList로 받아옴
		SimpleInfoSvc simpleInfoSvc = new SimpleInfoSvc();
    	int mipoint = simpleInfoSvc.getPoint(miid);
		
		
		request.setAttribute("buyList", buyList);
		request.setAttribute("addrList", addrList);
		request.setAttribute("mipoint", mipoint);
		RequestDispatcher dispatcher =  request.getRequestDispatcher("order/order_form.jsp");
    	dispatcher.forward(request, response); 
	}
}
