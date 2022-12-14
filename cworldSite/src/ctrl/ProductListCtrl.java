package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import svc.*;
import vo.*;
import java.util.*;

@WebServlet("/product_list")
public class ProductListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ProductListCtrl() { super(); }
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
		int cpage = 1, psize = 12, bsize = 9, rcnt = 0, pcnt = 0, spage = 0;
		// 현재 페이지 번호, 페이지 크기, 블록크기(페이징), 레코드(상품) 개수, 페이지지 개수, 시작페이지 정의
		if(request.getParameter("cpage") != null) 
			cpage = Integer.parseInt(request.getParameter("cpage"));
		
		// 검색 조건 where절 생성
		String pcb = request.getParameter("pcb");	// 대분류
		String pcs = request.getParameter("pcs");	// 소분류
		String sch = request.getParameter("sch");	// 검색조건(가격대 & 상품명 & 브랜드)
		String where ="" ;
		if (pcb != null && !pcb.equals(""))
			where += " and a.pcb_id = '" + pcb + "' ";
		if (pcs != null && !pcs.equals(""))
			where += " and a.pcs_id = '" + pcs + "' ";
		if (sch != null && !sch.equals("")) {
		// &sch=p10000~20000,ntest, bB1:B2:B3
			String[] arrSch = sch.split(",");
			for (int i = 0; i < arrSch.length; i++) {
				char c = arrSch[i].charAt(0);
				if(c == 'p') {	// 가격대 검색일 경우
					String sp = arrSch[i].substring(1, arrSch[i].indexOf('~')); 
					if(sp != null && !sp.contentEquals(""))
						where += " and pi_price >= '" + sp + "' ";
					
					String ep = arrSch[i].substring(arrSch[i].indexOf("~") + 1);
					if(ep != null && !ep.contentEquals(""))
						where += " and pi_price <= '" + ep + "' ";
				} else if (c == 'n') { // 상품명  검색일 경우
					where += " and pi_name like '%" + arrSch[i].substring(1) + "%' ";
				} else if (c == 'l') {
					String arrSpecial[] = arrSch[i].substring(1).split(":");
					where += " and (";
					for (int j = 0 ; j < arrSpecial.length ; j++) {
						where += (j==0 ? "": " or ") + "a.pi_special like '%" + arrSpecial[j] + "%' ";
					}
					where += ") ";
				}
			}
		}
		
		// 정렬조건 where절 생성
		String o = request.getParameter("o");		// 정렬조건
		if(o == null || o.contentEquals(""))	o = "a";
		String orderBy = "";
		switch (o) {
			case "a": orderBy = " order by a.pi_date desc";		break;	// 등록역순
			case "b": orderBy = " order by a.pi_srcnt desc";	break;	// 판매량순
			case "c": orderBy = " order by a.pi_dc desc";		break;	// 할인율순
			case "d": orderBy = " order by realPrice asc";		break;	// 가격낮은순
			case "e": orderBy = " order by realPrice desc";		break;	// 가격높은순
			case "f": orderBy = " order by a.pi_score desc";	break;	// 평점높은순
			case "g": orderBy = " order by a.pi_review desc";	break;	// 리뷰많은순
			case "h": orderBy = " order by a.pi_read desc";		break;	// 조회높은순
		}
		String v = request.getParameter("v");		// 보기방식
		if(v != null && v.equals("l")) { psize = 10; } // 보기방식이 목록형일 경우 페이지 크기를 10으로
		else { v = "g"; }
		
		ProductListSvc productListSvc = new ProductListSvc();
		rcnt = productListSvc.getProductCount(where);
		// 검색된 상품의 총 개수로 전체 페이지 수를 구할 때 사용
		
		ArrayList<PdtInfo> productList = productListSvc.getProductList(cpage, psize, where, orderBy);
		// 검색된 상품들 중 현재 페이지에서 보여줄 상품 목록을 받아옴
		ArrayList<PdtCtgrSmall> smallList = new ArrayList<PdtCtgrSmall>();
		if (pcb != null && !pcb.equals("")) { //검색조건 중 대분류가 있으면
			smallList = productListSvc.getSmallList(pcb);
			//대분류에 속하는 소분류 목록을 받아옴	
		}
		
		pcnt = rcnt / psize;	if(rcnt % psize > 0) pcnt++; // 전체 페이지 수
		spage = (cpage - 1 ) / psize * psize + 1;	//블록 시작 페이지 번호
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setBsize(bsize); 	pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt); 	pageInfo.setPsize(psize);
		pageInfo.setRcnt(rcnt); 	pageInfo.setSpage(spage);
		pageInfo.setSch(sch); 		pageInfo.setPcs(pcs);
		pageInfo.setPcb(pcb); 		pageInfo.setV(v);
		pageInfo.setO(o);
		// 페이징 관련 정보들과 검색 및 정렬 정보들을 pageInfo 인스턴스에 저장
	
		request.setAttribute("productList", productList);
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("smallList", smallList);
		RequestDispatcher dispatcher =  request.getRequestDispatcher("product/product_list.jsp");
    	dispatcher.forward(request, response); 
		
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
}
