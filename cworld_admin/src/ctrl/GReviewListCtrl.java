package ctrl;

import java.io.*;
import java.net.URLEncoder;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;
import java.util.*;

@WebServlet("/g_review_list")
public class GReviewListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public GReviewListCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, psize = 5, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
    	// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(상품) 개수, 페이지 개수, 시작 페이지 번호 등을 저장할 변수
    	if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));	
		}
    	String where = "";
    	String sch = request.getParameter("sch");	// 
    		
    	if (sch == null) {
    		sch = "";
    	}
    	if (sch != null && !sch.equals("")) {
    	// 검색조건 예시 :  &sch=vy,sasdfnkl:sdafjbasdf			게시여부, 작성자id-제목title-단체명gname-내용content-제목+내용tc
    		String[] arrSch = sch.split(",");
    		for (int i = 0; i < arrSch.length; i++) {
    			char c = arrSch[i].charAt(0);
    			if (c == 'v') {
    				where += " and gr_isview = '" + arrSch[i].substring(1) + "' ";
    			} else if (c == 's') {
    				String[] arrTmp = arrSch[i].substring(1).split(":");
    				if(arrTmp[0].equals("id")) {
    					where += " and mi_id like '%" + arrTmp[1] + "%' ";
    				} else if(arrTmp[0].equals("title")) {
    					where += " and gr_title like '%" + arrTmp[1] + "%' ";
    				} else if(arrTmp[0].equals("gname")) {
    					where += " and gq_gname like '%" + arrTmp[1] + "%' ";
    				} else if(arrTmp[0].equals("content")) {
    					where += " and gr_content like '%" + arrTmp[1] + "%' ";
    				} else if(arrTmp[0].equals("tc")) {
    					where += " and (gr_content like '%" + arrTmp[1] + "%' or gr_title like '%" + arrTmp[1] + "%')";
    				}
    			}
    		}
    	}
    	GReviewListSvc gReviewListSvc = new GReviewListSvc();
    	rcnt = gReviewListSvc.getGReviewCount(where);	// 검색된 상품의 총 개수로 전체 페이지수를 구할 때 사용
    	
    	ArrayList<GReviewInfo> gReviewList = gReviewListSvc.getGReviewList(cpage, psize, where); 

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
		request.setAttribute("gReviewList", gReviewList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("bbs/g_review_list.jsp");
		dispatcher.forward(request, response);
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
