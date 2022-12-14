package ctrl;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/member_order_list")
public class MemberOrderListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MemberOrderListCtrl() { super(); }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
    	// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(상품) 개수, 페이지 개수, 시작 페이지 번호 등을 저장할 변수
    	if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));	
		}
    	String sch = request.getParameter("sch");	// 

    	if (sch == null) {
    		sch = "";
    	}
    	String pcb = "";
    	String where = "";
    	if (sch != null && !sch.equals("")) {
    	// 검색조건 예시 : sch=n123,bR,sR02,p123,ma,ta	// 아이디u, 대분류(패키지, 대여, 판매)b, 소분류s, 상품명p, 결제방법m, 배송상태t
    		String[] arrSch = sch.split(",");
    		for (int i = 0; i < arrSch.length; i++) {
    			char c = arrSch[i].charAt(0);
    			if (c == 'b') {
    				where += " and pi_id like '%" + arrSch[i].substring(1) + "%' ";
    				pcb = arrSch[i].substring(1);
    			} else if (c == 's') {
    				where += " and pi_id like '%" + arrSch[i].substring(1) + "%' "; 
    			} else if (c == 'p') {
    				where += " and od_pname like '%" + arrSch[i].substring(1) + "%' "; 
    			} else if (c == 'n') {
    				where += " and mi_id like '%" + arrSch[i].substring(1) + "%' "; 
    			} else if (c == 'm') {
    				where += " and oi_payment = '" + arrSch[i].substring(1) + "' "; 
    			} else if (c == 't') {
    				where += " and oi_status = '" + arrSch[i].substring(1) + "' "; 
    			}
    		}
    	}
    	MemberOrderListSvc memberOrderListSvc = new MemberOrderListSvc();
    	rcnt = memberOrderListSvc.getOrderCount(where);	
    	
    	ArrayList<MemberOrderInfo> memberOrderList = memberOrderListSvc.getOrderList(cpage, psize, where); 
    	
    	ArrayList<PdtCtgrSmall> smallList = new ArrayList<PdtCtgrSmall>();
    	ProductListSvc productListSvc = new ProductListSvc();
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
		request.setAttribute("memberOrderList", memberOrderList);
		request.setAttribute("smallList", smallList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("member/member_order_list.jsp");
		dispatcher.forward(request, response);
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
}
