package dao;


import static db.jdbcUtil.*;
import java.sql.*;
import vo.*;

public class MemberProcUpDao {
	private static MemberProcUpDao memberProcUpDao;	
	private Connection conn;
	private MemberProcUpDao() {}

	public static MemberProcUpDao getInstance() {
		if (memberProcUpDao == null) memberProcUpDao = new MemberProcUpDao();
		return memberProcUpDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public int getMemberUpdate(String sql) {
		int result = 0;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("MemberProcUpDao클래스의 getMemberUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
}
