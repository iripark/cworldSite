package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;

public class MemberStatusUpdateDao {
	private static MemberStatusUpdateDao memberStatusUpdateDao;	
	private Connection conn;			
	private MemberStatusUpdateDao() {}
	public static MemberStatusUpdateDao getInstance() {
		if (memberStatusUpdateDao == null) {
			memberStatusUpdateDao = new MemberStatusUpdateDao();
		}		
		return memberStatusUpdateDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int memStatusUpdate(String where) {
		int result = 0;
		Statement stmt = null;
		try {
			String sql = "update t_member_info set mi_status = 'b' " + where;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("MemberStatusUpdateDao 클래스의 memStatusUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
}
