package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;
import java.util.*;

@WebServlet("/g_qna_list")
public class GQnaListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public GQnaListCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, psize = 5, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
    	// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(상품) 개수, 페이지 개수, 시작 페이지 번호 등을 저장할 변수
    	if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));	
		}
    	String sch = request.getParameter("sch");	// 

    	if (sch == null) {
    		sch = "";
    	}
    	String where = "";
    	if (sch != null && !sch.equals("")) {
    	// 검색조건 예시 :  &sch=itest,g2조,vy,ay,py			아이디, 단체명, 게시여부, 답변여부, 결제여부 
    		String[] arrSch = sch.split(",");
    		for (int i = 0; i < arrSch.length; i++) {
    			char c = arrSch[i].charAt(0);
    			if (c == 'i') {
    				where += " and mi_id like '%" + arrSch[i].substring(1) + "%' ";
    			} else if (c == 'g') {
    				where += " and gq_gname like '%" + arrSch[i].substring(1) + "%' ";
    			} else if (c == 'v') {
    				where += " and gq_isview = '" + arrSch[i].substring(1) + "' ";
    			} else if (c == 'a') {
    				where += " and gq_isreply = '" + arrSch[i].substring(1) + "' ";
    			} else if (c == 'p') {
    				where += " and gq_pay = '" + arrSch[i].substring(1) + "' ";
    			}
    		}
    	}
    	GQnaListSvc gQnaListSvc = new GQnaListSvc();
    	rcnt = gQnaListSvc.getGQnaCount(where);	// 검색된 상품의 총 개수로 전체 페이지수를 구할 때 사용
    	
    	ArrayList<GQnaInfo> gQnaList = gQnaListSvc.getGQnaList(cpage, psize, where); 

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
		request.setAttribute("gQnaList", gQnaList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("bbs/g_qna_list.jsp");
		dispatcher.forward(request, response);
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
}
