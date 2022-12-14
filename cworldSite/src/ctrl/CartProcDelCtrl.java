package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/cart_proc_del")
public class CartProcDelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public CartProcDelCtrl() {  super();  }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String ocidx = request.getParameter("ocidx");
		// 삭제할 상품의 장바구니 인덱스 번호(들)
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if(loginInfo == null) {
			System.out.println("로그인이 필요합니다.");
		}
		String miid = loginInfo.getMi_id();
		String where = " where mi_id = '" + miid + "' ";
		response.setContentType("text/html; charset=utf-8");
		
		if(ocidx.indexOf(',') > 0){
			String[] arrOcidx = ocidx.split(",");
			for (int i = 0; i < arrOcidx.length ; i++) {
				where += (i==0? " and (" : " or ") + " oc_idx = " + arrOcidx[i];
			}
			where += ")";
		} else {
			where += " and oc_idx = " + ocidx;
		}
		PrintWriter out = response.getWriter();
		
		CartProcDelSvc cartProcDelSvc = new CartProcDelSvc();
		int result = cartProcDelSvc.cartDel(where);
		out.println(result);
	}
}
