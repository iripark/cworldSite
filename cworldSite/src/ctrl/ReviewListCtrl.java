package ctrl;

import java.io.*;
import java.net.URLEncoder;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;
import java.util.*;

@WebServlet("/review_list")
public class ReviewListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ReviewListCtrl() { super(); }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
    	// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(상품) 개수, 페이지 개수, 시작 페이지 번호 등을 저장할 변수
    	if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));	
		}
    	
    	String schtype = request.getParameter("schtype");	// 제목, 내용, 작성자, 제목+내용
		String keyword = request.getParameter("keyword");	// 검색어		
		String where = " where rl_isview = 'y' ";		// 검색 조건이 있을 경우 where 절을 저장할 변수
		if (schtype == null || keyword == null) {
			schtype = "";
			keyword = "";
		} else if (!schtype.equals("") && !keyword.equals("")) {	// 검색조건과 검색어가 있을 경우
			URLEncoder.encode(keyword, "UTF-8");
			// 쿼리스트링으로 주고 받는 검색어가 한글일 경우 IE에서 간혹 문제가 발생할 수 있으므로 유니코드로 변환시킴
			if (schtype.equals("tc")) {	// 검색 조건이 '제목+내용'일 경우
				where += " and rl_title like '%" + keyword + "%' or rl_content like '%" + keyword + "%' ";
			} else if(schtype.equals("writer")) {
				where += " and mi_id like '%" + keyword + "%' ";
			} else {
				where += " and rl_" + schtype + " like '%" + keyword + "%' ";
			}			
		}
		
    	ListSvc listSvc = new ListSvc();
    	rcnt = listSvc.getReviewCount(where);	
    	
    	ArrayList<ReviewInfo> reviewList = listSvc.getReviewList(where, cpage, psize); 
    	
    	pcnt = rcnt / psize;
    	if (rcnt % psize > 0) {
    		pcnt++;	// 전체 페이지 수
    	}
    	spage = (cpage - 1) / psize * psize + 1;	// 블록 시작 페이지 번호
    	PageInfo pageInfo = new PageInfo();
    	
    	pageInfo.setBsize(bsize);			pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt);				pageInfo.setPsize(psize);
		pageInfo.setRcnt(rcnt);				pageInfo.setSpage(spage);			
		pageInfo.setSchtype(schtype);		pageInfo.setKeyword(keyword);
		// 페이징 관련 정보들과 검색 및 정렬 정보들을 pageInfo 인스턴스에 저장
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("reviewList", reviewList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("bbs/review_list.jsp");
		dispatcher.forward(request, response);
	}
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
