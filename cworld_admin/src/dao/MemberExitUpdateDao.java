package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;
import dao.*;

public class MemberExitUpdateDao {
	private static MemberExitUpdateDao memberExitUpdateDao;	
	private Connection conn;			
	private MemberExitUpdateDao() {}
	public static MemberExitUpdateDao getInstance() {
		if (memberExitUpdateDao == null) {
			memberExitUpdateDao = new MemberExitUpdateDao();
		}		
		return memberExitUpdateDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int memberExit(String miid) {
		int result = 0;
		Statement stmt = null;
		
		try {
			String sql = "update t_member_info set mi_status = 'c' where mi_id = '" + miid + "'";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("MemberExitUpdateDao 클래스의 memberExit() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result;
	}
	
}
