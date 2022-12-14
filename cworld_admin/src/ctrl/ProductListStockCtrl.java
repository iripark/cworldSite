package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;
import java.util.*;

@WebServlet("/product_list_stock")
public class ProductListStockCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ProductListStockCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	int cpage = 1, psize = 5, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
    	// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(상품) 개수, 페이지 개수, 시작 페이지 번호 등을 저장할 변수
    	if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));	
		}
    	String sch = request.getParameter("sch");	// 검색조건(특별상품여부 & 상품명) 특별상품 여부는 없음, 전체, best, new, sale, hot

    	if (sch == null) {
    		sch = "";
    	}
    	String pcb = "";
    	String where = "";
    	if (sch != null && !sch.equals("")) {
    	// 검색조건 예시 :  &sch=bR,mR01,ntest,sa,vy		s = a : 전체 b : 품절  c : 부족 d : 여유
    		String[] arrSch = sch.split(",");
    		for (int i = 0; i < arrSch.length; i++) {
    			char c = arrSch[i].charAt(0);
    			if (c == 's') {
    				String stock = arrSch[i].substring(1);
    				if (stock.equals("a")) {
    					where += "";
    				} else if (stock.equals("b")) {
    					where += " and b.ps_stock = 0 ";
    				} else if (stock.equals("c")) {
    					where += " and b.ps_stock <= 50 ";
    				} else if (stock.equals("d")) {
    					where += " and b.ps_stock > 50 ";
    				} 
    			} else if (c == 'n') {
    				where += " and a.pi_name like '%" + arrSch[i].substring(1) + "%' "; 
    			} else if (c == 'b') {
    				where += " and a.pcb_id like '%" + arrSch[i].substring(1) + "%' ";
    				pcb = arrSch[i].substring(1);
    			} else if (c == 'm') {
    				where += " and a.pcs_id like '%" + arrSch[i].substring(1) + "%' "; 
    			} else if (c == 'v') {
    				where += " and a.pi_isview like '%" + arrSch[i].substring(1) + "%' "; 
    			} 
    		}
    	}
    	ProductListSvc productListSvc = new ProductListSvc();
    	rcnt = productListSvc.getProductCount(where);	// 검색된 상품의 총 개수로 전체 페이지수를 구할 때 사용
    	
    	ArrayList<ProductInfo> productList = productListSvc.getProductList(cpage, psize, where); 
    	// 검색된 상품들 중 현재 페이지에서 보여줄 상품 목록을 받아옴
    	ArrayList<PdtCtgrSmall> smallList = new ArrayList<PdtCtgrSmall>();
    	if (pcb != null && !pcb.equals("")) {	// 검색 조건중 대분류가 있으면
    		smallList = productListSvc.getSmallList(pcb);
    	}	// 대분류에 속하는 소분류 목록을 받아옴
    	
    	
    	// 상품 검색시 조건으로 사용하기 위한 브랜드 목록을 받아옴
    	pcnt = rcnt / psize;
    	if (rcnt % psize > 0) {
    		pcnt++;	// 전체 페이지 수
    	}
    	spage = (cpage - 1) / psize * psize + 1;	// 블록 시작 페이지 번호
    	PageInfo pageInfo = new PageInfo();
    	pageInfo.setBsize(bsize);			pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt);				pageInfo.setPsize(psize);
		pageInfo.setRcnt(rcnt);				pageInfo.setSpage(spage);
		pageInfo.setSch(sch);				
		// 페이징 관련 정보들과 검색 및 정렬 정보들을 pageInfo 인스턴스에 저장
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("productList", productList);
		request.setAttribute("smallList", smallList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("product/product_list_stock.jsp");
		dispatcher.forward(request, response);
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
