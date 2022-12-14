package dao;

import static db.jdbcUtil.*;
import java.sql.*;

public class DupPwDao {
	private static DupPwDao dupPwDao;	
	private Connection conn;
	private DupPwDao() {}

	public static DupPwDao getInstance() {
		if (dupPwDao == null) dupPwDao = new DupPwDao();
		return dupPwDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int chkDupPw(String uid, String pwd) {
		Statement stmt = null;
		ResultSet rs = null;
		int result = 0;	
		try {
			stmt = conn.createStatement();
			String sql = "select count(*) from t_member_info where mi_id = '" + uid + "' and mi_pw = '" + pwd + "' ";
			rs = stmt.executeQuery(sql);
			rs.next();
			result = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("DupPwDao클래스의 chkDupPw() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}	
		return result;
	}
}
