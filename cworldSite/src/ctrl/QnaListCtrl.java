package ctrl;

import java.io.*;
import java.net.URLEncoder;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;
import java.util.*;

@WebServlet("/qna_list")
public class QnaListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public QnaListCtrl() { super(); }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		ArrayList<QnaInfo> qnaList = new ArrayList<QnaInfo>(); 
		PageInfo pageInfo = new PageInfo();
		// 자유게시판 글 목록을 저장하기 위한 ArrayList로 안에 저장될 데이터는 FreeList형 인스턴스만 허용
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
		// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(게시글) 개수, 페이지 개수, 시작 페이지 번호 등을 저장할 변수
		if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));	
			// cpage 값이 있으면 받아서 int형으로 형변환 시킴(보안상의 이유와 산술연산을 해야 하기 때문)
		}
		
		QnaListSvc qnaListSvc = new QnaListSvc();
		rcnt = qnaListSvc.getQnaListCount(miid);
		// 검색된 게시글의 총 개수로 게시글 일련번호 출력과 전체 페이지수 계산을 위해 필요한 값
		
		qnaList = qnaListSvc.getQnaList(miid, cpage, psize);
		// 목록화면에서 보여줄 게시글 목록을 ArrayList형으로 받아옴 - 필요한 만큼만 받아오기 위해 cpage와 psize가 필요
		pageInfo.setBsize(bsize);			pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt);				pageInfo.setPsize(psize);
		pageInfo.setRcnt(rcnt);				pageInfo.setSpage(spage);
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("qnaList", qnaList);
		// request 객체에 freeInfo라는 이름의 속성을 freeList값을 가지게 하여 선언 및 생성
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("member/qna_list.jsp");
		dispatcher.forward(request, response);
	}
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
