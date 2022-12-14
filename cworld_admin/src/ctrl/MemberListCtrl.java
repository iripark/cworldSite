package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import vo.*;
import svc.*;
import java.util.*;

@WebServlet("/member_list")
public class MemberListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MemberListCtrl() { super(); }
	
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		ArrayList<MemberInfo> memberList = new ArrayList<MemberInfo>();
		
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
    	// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(상품) 개수, 페이지 개수, 시작 페이지 번호 등을 저장할 변수
    	if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));	
		}
    	
    	String sch = request.getParameter("sch");	// 검색조건(특별상품여부 & 상품명) 특별상품 여부는 없음, 전체, best, new, sale, hot

    	if (sch == null) {
    		sch = "";
    	}
    	String where = " where 1 = 1 ";
    	if (sch != null && !sch.equals("")) {
    	// 검색조건 예시 :  &sch=sa,gm,a20,p1000:3000,d180,n홍길동,en,j2022-10-10:2022-10-20
    		String[] arrSch = sch.split(",");
    		for (int i = 0; i < arrSch.length; i++) {
    			char c = arrSch[i].charAt(0);
    			if (c == 's') {			// 상태
    				where += " and mi_status = '" + arrSch[i].substring(1) + "' "; 
    			} else if (c == 'g') {	// 성별
    				where += " and mi_gender = '" + arrSch[i].substring(1) + "' "; 
    			} else if (c == 'a') {	// 나이	
    				where += " and (left(now(), 4) - left(mi_birth, 4) + 1) >= " + arrSch[i].substring(1) + " "; 
    			} else if (c == 'p') {	// 보유포인트
    				String[] arrPoint = arrSch[i].substring(1).split(":");
    				if(arrPoint[0] != null && arrPoint[0].equals("")) {
    					where += " and mi_point >= '" + arrPoint[0] + "' "; 
    				}
    				if(arrPoint[1] != null && arrPoint[1].equals("")) {
    					where += " and mi_point <= '" + arrPoint[1] + "' "; 
    				}
    			} else if (c == 'd') {	// 최종로그인일자
    				where += " and datediff(left(mi_last, 10), now()) <= -" + arrSch[i].substring(1);
    			} else if (c == 'n') {	// 이름
    				where += " and mi_name like '%" + arrSch[i].substring(1) + "%' ";
    			} else if (c == 'e') {	// 광고수신여부
    				where += " and mi_adv = '" + arrSch[i].substring(1) + "' ";
    			} else if (c == 'j') {	// 가입일
    				// where += " and datediff(left(mi_join, 10), left(now(), 10)) <= 0 ";
    				
    				String sj = arrSch[i].substring(1, arrSch[i].indexOf(':'));
					if (sj != null && !sj.equals("")) {
						where += " and datediff(left(mi_join, 10), '" + sj + "') >= 0 ";
					}
					String ej = arrSch[i].substring(arrSch[i].indexOf(':') + 1);
					if (ej != null && !ej.equals("")) {
						where += " and datediff(left(mi_join, 10), '" + ej + "') <= 0 ";
					}
    			}
    		}
    	}
    	MemberListSvc memberListSvc = new MemberListSvc();
    	rcnt = memberListSvc.getMemberCount(where);
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
    	
		
		memberList = memberListSvc.getMemberList(cpage, psize, where);
		
			
		request.setAttribute("memberList", memberList);
		request.setAttribute("pageInfo", pageInfo);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("member/member_list.jsp");
		dispatcher.forward(request, response);
	}
    
   
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
