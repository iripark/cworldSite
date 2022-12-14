<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<% 
request.setCharacterEncoding("utf-8");
String driver = "com.mysql.cj.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/cworld?useUnicode=true&characterEncoding=UTF8&verifyServerCertificate=false&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

Connection conn = null;	
Statement stmt = null;
ResultSet rs = null;
String sql = "";
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	sql = "select * from t_product_info where left(pi_id, 1) = 'R' limit 0, 10";
	rs = stmt.executeQuery(sql);
	String result = "";
	if (rs.next()) {			
		do {
			result = rs.getString("pi_img1") + "," + rs.getString("pi_name") + "," + rs.getString("pi_id");
			out.println(result);
		} while(rs.next());
	} else {			
		out.println("검색된 회원이 없습니다.");
	}
} catch(Exception e) {
	out.println("DB연결에 문제가 생겼습니다.");
	e.printStackTrace();	
} finally {
	rs.close();
	stmt.close();
	conn.close();
}
%>