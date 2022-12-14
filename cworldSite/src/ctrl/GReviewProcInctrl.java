package ctrl;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/g_review_proc_in")
@MultipartConfig(
		fileSizeThreshold = 0,
		location = "D:/yby/jsp/work/cworld_admin/WebContent/upload_g_review"
	)
public class GReviewProcInctrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public GReviewProcInctrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	
    	String miid = request.getParameter("miid");
		
		
		Part part = request.getPart("gr_img");	
		response.setContentType("text/html; charset=utf-8"); 	
		String contentDisposition = part.getHeader("content-disposition");
		// 예) form-data; name="gr_img"; filename="업로드할파일명.확장자"
		String uploadFileName = getUploadFileName(contentDisposition, miid);
		
		GReviewInfo gri = new GReviewInfo();
		
		if (uploadFileName.substring(uploadFileName.indexOf("_")).equals("_")) {
			gri.setGr_img("");
		} else {
			part.write(uploadFileName);
			gri.setGr_img(uploadFileName);
		}
		
		int gq_idx = Integer.parseInt(request.getParameter("idx"));
		String gname = request.getParameter("gname");
		String gr_title = request.getParameter("gr_title").trim().replace("'", "''").replace("<", "&lt;");
		String gr_content = request.getParameter("gr_content").trim().replace("'", "''").replace("<", "&lt;");
		String gr_ip = request.getParameter("ip");
		
		gri.setGq_gname(gname);
		gri.setGq_idx(gq_idx);
		gri.setGr_content(gr_content);
		gri.setGr_title(gr_title);
		gri.setMi_id(miid);
		gri.setGr_ip(gr_ip);
		
		
		GReviewProcInSvc gReviewProcInSvc = new GReviewProcInSvc();
		int idx = gReviewProcInSvc.gReviewInsert(gri);
		
		if (idx > 0) {	// 정상적으로 글이 등록되었으면
			response.sendRedirect("/cworldSite/g_review_view?cpage=1&idx=" + idx);
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
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
	private String getUploadFileName(String contentDisposition, String name) {
		String uploadFileName = null;
		String[] contentSplitStr = contentDisposition.split(";");
		
		int fIdx = contentSplitStr[2].indexOf("\"");
		int sIdx = contentSplitStr[2].lastIndexOf("\"");
		String[] arrR = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
		Random rnd = new Random();
		
		uploadFileName = name + arrR[rnd.nextInt(26)] + "_"  + contentSplitStr[2].substring(fIdx + 1, sIdx);
		
		return uploadFileName;
	}

}
