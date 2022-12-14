package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;
import java.util.*;

@WebServlet("/product_list")
public class ProductListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ProductListCtrl() { super(); }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, psize = 5, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
    	// ���� ������ ��ȣ, ������ ũ��, ���� ũ��, ���ڵ�(��ǰ) ����, ������ ����, ���� ������ ��ȣ ���� ������ ����
    	if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));	
		}
    	String sch = request.getParameter("sch");	// �˻�����(Ư����ǰ���� & ��ǰ��) Ư����ǰ ���δ� ����, ��ü, best, new, sale, hot

    	if (sch == null) {
    		sch = "";
    	}
    	String pcb = "";
    	String where = "";
    	if (sch != null && !sch.equals("")) {
    	// �˻����� ���� :  &sch=ntest,sa:b:c:d,cR01101,h100
    		String[] arrSch = sch.split(",");
    		for (int i = 0; i < arrSch.length; i++) {
    			char c = arrSch[i].charAt(0);
    			if (c == 's') {
    				String[] arrS = arrSch[i].substring(1).split(":");
    				where += " and (";
    				for (int j = 0; j < arrS.length; j++) {
    					if (j == 0) {
							where += " a.pi_special like '%" + arrS[j] + "%' "; 
    					} else {
    						where += " or a.pi_special like '%" + arrS[j] + "%' "; 
    					}
    				}
    				where += ") ";   
    			} else if (c == 'n') {
    				where += " and a.pi_name like '%" + arrSch[i].substring(1) + "%' "; 
    			} else if (c == 'b') {
    				where += " and a.pcb_id like '%" + arrSch[i].substring(1) + "%' ";
    				pcb = arrSch[i].substring(1);
    			} else if (c == 'h') {
    				where += " and b.ps_stock <= '" + arrSch[i].substring(1) + "' ";
    			} else if (c == 'm') {
    				where += " and a.pcs_id like '%" + arrSch[i].substring(1) + "%' "; 
    			} else if (c == 'i') {
    				where += " and a.pi_isview like '%" + arrSch[i].substring(1) + "%' "; 
    			} 
    		}
    	}
    	ProductListSvc productListSvc = new ProductListSvc();
    	rcnt = productListSvc.getProductCount(where);	// �˻��� ��ǰ�� �� ������ ��ü ���������� ���� �� ���
    	
    	ArrayList<ProductInfo> productList = productListSvc.getProductList(cpage, psize, where); 
    	// �˻��� ��ǰ�� �� ���� ���������� ������ ��ǰ ����� �޾ƿ�
    	ArrayList<PdtCtgrSmall> smallList = new ArrayList<PdtCtgrSmall>();
    	if (pcb != null && !pcb.equals("")) {	// �˻� ������ ��з��� ������
    		smallList = productListSvc.getSmallList(pcb);
    	}	// ��з��� ���ϴ� �Һз� ����� �޾ƿ�
    	
    	
    	// ��ǰ �˻��� �������� ����ϱ� ���� �귣�� ����� �޾ƿ�
    	pcnt = rcnt / psize;
    	if (rcnt % psize > 0) {
    		pcnt++;	// ��ü ������ ��
    	}
    	spage = (cpage - 1) / psize * psize + 1;	// ���� ���� ������ ��ȣ
    	PageInfo pageInfo = new PageInfo();
    	pageInfo.setBsize(bsize);			pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt);				pageInfo.setPsize(psize);
		pageInfo.setRcnt(rcnt);				pageInfo.setSpage(spage);
		pageInfo.setSch(sch);				
		// ����¡ ���� ������� �˻� �� ���� �������� pageInfo �ν��Ͻ��� ����
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("productList", productList);
		request.setAttribute("smallList", smallList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("product/product_list.jsp");
		dispatcher.forward(request, response);
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);		
	}
}