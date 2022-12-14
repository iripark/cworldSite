package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/product_proc_up")
public class ProductProcUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ProductProcUp() { super(); }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		ProductInfo productInfo = new ProductInfo();
		productInfo.setPcb_id(request.getParameter("pcb_id"));
		productInfo.setPcs_id(request.getParameter("pcs_id"));
		productInfo.setPi_id(request.getParameter("pi_id"));
		productInfo.setPi_name(request.getParameter("pi_name"));
		String bestPro = request.getParameter("best");
		String newPro = request.getParameter("new");
		String hotPro = request.getParameter("hot");
		String salePro = request.getParameter("sale");
		if(bestPro == null) {	bestPro = "";	}
		if(newPro == null) {	newPro = "";	}
		if(hotPro == null) {	hotPro = "";	}
		if(salePro == null) {	salePro = "";	}
		productInfo.setPi_special(bestPro + newPro + hotPro + salePro);
		productInfo.setPi_cost(Integer.parseInt(request.getParameter("pi_cost")));
		productInfo.setPi_price(Integer.parseInt(request.getParameter("pi_price")));
		productInfo.setPi_dc(Integer.parseInt(request.getParameter("pi_dc")));
		productInfo.setPi_dcprice(Integer.parseInt(request.getParameter("pi_dcprice")));
		productInfo.setPi_dfee(Integer.parseInt(request.getParameter("pi_dfee")));
		productInfo.setPi_isview(request.getParameter("pi_isview"));
		
		
		if (request.getParameter("pi_img2") != null) {
			if (request.getParameter("pi_img2").equals("")) {
				productInfo.setPi_img2(request.getParameter("img2"));
			} else {
				productInfo.setPi_img2(request.getParameter("pi_img2"));
			}
		} else {
			productInfo.setPi_img2("");
		}
		if (request.getParameter("pi_img3") != null) {
			if (request.getParameter("pi_img3").equals("")) {
				productInfo.setPi_img3(request.getParameter("img3"));
			} else {
				productInfo.setPi_img3(request.getParameter("pi_img3"));
			}
		} else {
			productInfo.setPi_img2("");
		}
		if (request.getParameter("pi_img1") != null && request.getParameter("pi_img1").equals("")) {
			productInfo.setPi_img1(request.getParameter("img1"));
		} else {
			productInfo.setPi_img1(request.getParameter("pi_img1"));
		}
		if (request.getParameter("pi_desc") != null && request.getParameter("pi_desc").equals("")) {
			productInfo.setPi_desc(request.getParameter("desc"));
		} else {
			productInfo.setPi_desc(request.getParameter("pi_desc"));
		}
		
		
		int ps_stock = Integer.parseInt(request.getParameter("ps_stock"));
		String ps_opt = request.getParameter("ps_opt");
		
		ProductProcUpSvc productProcUpSvc = new ProductProcUpSvc();
		int result = productProcUpSvc.pdtUpdate(productInfo, ps_stock, ps_opt);
		
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if (result == 0) {
			out.println("<script> alert('상품수정에 실패했습니다. 다시 시도해 주세요.'); history.back(); </script>");
		} else if (result > 0){
			out.println("<script> alert('상품 수정이 완료되었습니다.'); location.replace('product_list'); </script>");			
		}
		out.close();
		
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
