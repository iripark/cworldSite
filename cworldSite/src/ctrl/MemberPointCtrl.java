package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;
import java.util.*;

@WebServlet("/member_point")
public class MemberPointCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MemberPointCtrl() { super(); }
   
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
    	// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(상품) 개수, 페이지 개수, 시작 페이지 번호 등을 저장할 변수
    	if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));	
		}
    	
		MemberPointSvc memberPointSvc = new MemberPointSvc();
		
		rcnt = memberPointSvc.getPointCount(miid);
		int totalPoint = memberPointSvc.getTotalPoint(miid);
		ArrayList<MemberPoint> pointList = new ArrayList<MemberPoint>();
		
		pointList = memberPointSvc.getPointList(miid, cpage, psize);
		pcnt = rcnt / psize;
    	if (rcnt % psize > 0) {
    		pcnt++;	// 전체 페이지 수
    	}
    	spage = (cpage - 1) / psize * psize + 1;	// 블록 시작 페이지 번호
    	PageInfo pageInfo = new PageInfo();
    	
    	pageInfo.setBsize(bsize);			pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt);				pageInfo.setPsize(psize);
		pageInfo.setRcnt(rcnt);				pageInfo.setSpage(spage);
		// 페이징 관련 정보들과 검색 및 정렬 정보들을 pageInfo 인스턴스에 저장
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("pointList", pointList);
		request.setAttribute("totalPoint", totalPoint);
		RequestDispatcher dispatcher = request.getRequestDispatcher("member/member_point.jsp");
		dispatcher.forward(request, response);
		
		
		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
