package ctrl;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/review_proc_in")
@MultipartConfig(
		fileSizeThreshold = 0,
		location = "D:/yby/jsp/work/cworld_admin/WebContent/upload_review"
	)
public class ReviewProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ReviewProcInCtrl() { super(); }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String miid = request.getParameter("miid");
		
		
		Part part = request.getPart("rl_img");	
		response.setContentType("text/html; charset=utf-8"); 	
		String contentDisposition = part.getHeader("content-disposition");
		// 예) form-data; name="rl_img"; filename="업로드할파일명.확장자"
		String uploadFileName = getUploadFileName(contentDisposition, miid);
		
		
		ReviewInfo ri = new ReviewInfo();
		
		if (uploadFileName.substring(uploadFileName.indexOf("_")).equals("_")) {
			ri.setRl_img("");
		} else {
			part.write(uploadFileName);
			ri.setRl_img(uploadFileName);
		}
		
		String oi_id = request.getParameter("oiid");
		String pi_id = request.getParameter("piid");
		int ps_idx = Integer.parseInt(request.getParameter("psidx"));
		String rl_pname = request.getParameter("pname");
		String rl_title = request.getParameter("rl_title").trim().replace("'", "''").replace("<", "&lt;");
		String rl_content = request.getParameter("rl_content").trim().replace("'", "''").replace("<", "&lt;");
		double rl_score = Double.parseDouble(request.getParameter("rl_score"));
		String rl_ip = request.getParameter("ip");
		
		ri.setMi_id(miid);		ri.setRl_pname(rl_pname);
		ri.setOi_id(oi_id);		ri.setRl_title(rl_title);
		ri.setPi_id(pi_id);		ri.setRl_content(rl_content);
		ri.setPs_idx(ps_idx);	ri.setRl_score(rl_score);
		ri.setRl_ip(rl_ip);
		
		ReviewProcInSvc reviewProcInSvc = new ReviewProcInSvc();
		int idx = reviewProcInSvc.reviewInsert(ri);
		
		if (idx > 0) {	// 정상적으로 글이 등록되었으면
			response.sendRedirect("review_view?cpage=1&idx=" + idx + "&piid=" + pi_id);
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
