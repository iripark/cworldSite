package dao;

import static db.jdbcUtil.close;

import java.sql.Connection;
import java.sql.Statement;

public class MemberProcDelDao {
	private static MemberProcDelDao memberProcDelDao;	
	private Connection conn;
	private MemberProcDelDao() {}

	public static MemberProcDelDao getInstance() {
		if (memberProcDelDao == null) memberProcDelDao = new MemberProcDelDao();
		return memberProcDelDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int memberLeave(String sql) {
		int result = 0;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("MemberProcUpDao클래스의 memberLeave() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
}
