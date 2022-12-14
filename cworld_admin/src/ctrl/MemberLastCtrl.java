package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import java.util.*;
import vo.*;

@WebServlet("/member_last")
public class MemberLastCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MemberLastCtrl() { super(); }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	ArrayList<MemberInfo> memberList = new ArrayList<MemberInfo>();
		
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
    	// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(상품) 개수, 페이지 개수, 시작 페이지 번호 등을 저장할 변수
    	if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));	
		}
    	
    	
    	MemberLastSvc memberLastSvc = new MemberLastSvc();
    	rcnt = memberLastSvc.getLastCount();
    	String memLast = "";
    	if (rcnt > 0) {
    		memLast = memberLastSvc.getMemberLast();
    	}
    	pcnt = rcnt / psize;
    	if (rcnt % psize > 0) {
    		pcnt++;	// 전체 페이지 수
    	}
    	spage = (cpage - 1) / psize * psize + 1;	// 블록 시작 페이지 번호
    	PageInfo pageInfo = new PageInfo();
    	pageInfo.setBsize(bsize);			pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt);				pageInfo.setPsize(psize);
		pageInfo.setRcnt(rcnt);				pageInfo.setSpage(spage);	
    	
		
		memberList = memberLastSvc.getLastList(cpage, psize);
		
			
		request.setAttribute("memberList", memberList);
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("memLast", memLast);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("member/member_last.jsp");
		dispatcher.forward(request, response);
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
