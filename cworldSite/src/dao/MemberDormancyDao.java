package dao;

import static db.jdbcUtil.close;

import java.sql.Connection;
import java.sql.Statement;

public class MemberDormancyDao {
	private static MemberDormancyDao memberDormancyDao;	
	private Connection conn;
	private MemberDormancyDao() {}

	public static MemberDormancyDao getInstance() {
		if (memberDormancyDao == null) memberDormancyDao = new MemberDormancyDao();
		return memberDormancyDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int updateMemberStatus(String sql){
		Statement stmt = null;
		int result = 0;	
		try {
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("MemberDormancyDao클래스의 updateMemberStatus() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}	
		
		
		return result;
	}
}
