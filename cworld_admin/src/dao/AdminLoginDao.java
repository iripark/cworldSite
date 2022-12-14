package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminLoginDao {
	private static AdminLoginDao adminLoginDao;
	private Connection conn;

	private AdminLoginDao() {
	}
	public static AdminLoginDao getInstance() {
		if (adminLoginDao == null) {
			adminLoginDao = new AdminLoginDao();
		} 

		return adminLoginDao;
	}

	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public AdminInfo getLoginAdmin(String uid, String pwd) {
		AdminInfo loginInfo = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select * from t_admin_info where ai_id = '" + uid + "' and ai_pw = '" + pwd + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				loginInfo = new AdminInfo();
				loginInfo.setAi_idx(rs.getInt("ai_idx"));
				loginInfo.setAi_id(rs.getString("ai_id"));
				loginInfo.setAi_pw(rs.getString("ai_pw"));
				loginInfo.setAi_name(rs.getString("ai_name"));
				loginInfo.setAi_isuse(rs.getString("ai_isuse"));
				loginInfo.setAi_date(rs.getString("ai_date"));
			}
				
		} catch(Exception e) {
			System.out.println("AdminLoginDao 클래스의 getLoginAdmin() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return loginInfo;
	}
}
