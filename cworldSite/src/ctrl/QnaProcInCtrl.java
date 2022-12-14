package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;
import java.util.*;

@WebServlet("/qna_proc_in")
@MultipartConfig(
		fileSizeThreshold = 0,
		location = "D:/yby/jsp/work/cworld_admin/WebContent/upload_qna"
	)
public class QnaProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public QnaProcInCtrl() { super(); }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
	
		Part part = request.getPart("ql_img1");	
		response.setContentType("text/html; charset=utf-8"); 	
		String contentDisposition = part.getHeader("content-disposition");
		// 예) form-data; name="file1"; filename="업로드할파일명.확장자"
		String uploadFileName = getUploadFileName(contentDisposition, miid);
		
		
		String ql_ip = request.getParameter("ip");
		String ql_ctgr = request.getParameter("ctgr");
		String ql_title = request.getParameter("title").trim().replace("'", "''").replace("<", "&lt;");
		String ql_content = request.getParameter("content").trim().replace("'", "''").replace("<", "&lt;");
		QnaInfo qi = new QnaInfo();
		qi.setMi_id(miid);
		qi.setQl_ctgr(ql_ctgr);
		qi.setQl_title(ql_title);
		qi.setQl_content(ql_content);
		if (uploadFileName.substring(uploadFileName.indexOf("_")).equals("_")) {
			qi.setQl_img1("");
		} else {
			part.write(uploadFileName);
			qi.setQl_img1(uploadFileName);
		}
		
		qi.setQl_ip(ql_ip);
		
		QnaProcInSvc qnaProcInSvc = new QnaProcInSvc();
		int idx = qnaProcInSvc.qnaInsert(qi);
		
		if (idx > 0) {	// 정상적으로 글이 등록되었으면
			response.sendRedirect("qna_view?cpage=1&idx=" + idx);
		} else {			// 글 등록시 문제가 발생 했으면
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('글 등록에 실패했습니다. 다시 시도해보세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
	
	}
	private String getUploadFileName(String contentDisposition, String name) {
		String uploadFileName = null;
		String[] contentSplitStr = contentDisposition.split(";");
		
		int fIdx = contentSplitStr[2].indexOf("\"");
		int sIdx = contentSplitStr[2].lastIndexOf("\"");
		String[] arrR = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
		Random rnd = new Random();
		
		uploadFileName = name + arrR[rnd.nextInt(26)] + "_" + contentSplitStr[2].substring(fIdx + 1, sIdx);
		
		return uploadFileName;
	}
	

}
