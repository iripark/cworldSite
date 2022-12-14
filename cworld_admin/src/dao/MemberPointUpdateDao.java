package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;
import dao.*;

public class MemberPointUpdateDao {
	private static MemberPointUpdateDao memberPointUpdateDao;	
	private Connection conn;			
	private MemberPointUpdateDao() {}
	public static MemberPointUpdateDao getInstance() {
		if (memberPointUpdateDao == null) {
			memberPointUpdateDao = new MemberPointUpdateDao();
		}		
		return memberPointUpdateDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int memPointUpdate(String miid, int point) {
		int result = 0;
		Statement stmt = null;
		
		try {
			String sql = "update t_member_info set mi_point = " + point + " where mi_id = '" + miid + "'";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("MemberPointUpdateDao 클래스의 memPointUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		
		return result;
	}
	
}
