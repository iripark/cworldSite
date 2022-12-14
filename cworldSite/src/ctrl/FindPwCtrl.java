package ctrl;

import java.io.*;
import java.util.*;
import javax.mail.*;
import javax.servlet.*;
import javax.mail.internet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/find_pw")
public class FindPwCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public FindPwCtrl() {  super();  }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uid = request.getParameter("uid");
		String name = request.getParameter("name");
		String e1 = request.getParameter("e1");
		String e3 = request.getParameter("e3");
		
		String email = e1 + "@" + e3;
		String where = " where mi_id = '" + uid + "' and mi_name = '" + name + "'  and mi_mail = '" + email + "' ";
		FindPwSvc findPwSvc = new FindPwSvc();
		String pw = findPwSvc.getFindPw(where);
		
		request.setCharacterEncoding("utf-8");
		String sender = "cworld@gmail.com";
		String receiver = e1 + "@" + e3;
		String title = "C월드에서 확인 메일 보냅니다.";
		String content = "귀하의 C월드 계정 비밀번호는 '" + pw + "' 입니다.";

		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		try {
			Properties properties = System.getProperties();
			properties.put("mail.smtp.starttls.enable", "true");
			properties.put("mail.smtp.host", "smtp.naver.com");
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.port", "587");
			
			Authenticator auth = new NaverAuthentication();
			Session s = Session.getDefaultInstance(properties, auth);
			Message msg = new MimeMessage(s);
			Address senderAddr = new InternetAddress(sender);
			Address receiverAddr = new InternetAddress(receiver);
			
			msg.setHeader("content-type", "text/html; charset=utf-8");
			msg.setFrom(senderAddr);
			msg.addRecipient(Message.RecipientType.TO, receiverAddr);
			msg.setSubject(title);
			msg.setContent(content, "text/html; charset=utf-8");
			msg.setSentDate(new java.util.Date());
			
			Transport.send(msg);
			out.println("<h3>메일이 정상적으로 전송되었습니다.</h3>");

		} catch (Exception e) {
			e.printStackTrace();
		}
		RequestDispatcher dispatcher =  request.getRequestDispatcher("member/findPw_after.jsp");
    	dispatcher.forward(request, response);
	}
}
