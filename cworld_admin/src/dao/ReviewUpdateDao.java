package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class ReviewUpdateDao {
	private static ReviewUpdateDao reviewUpdateDao;	
	private Connection conn;			
	private ReviewUpdateDao() {}
	public static ReviewUpdateDao getInstance() {
		if (reviewUpdateDao == null) {
			reviewUpdateDao = new ReviewUpdateDao();
		}		
		return reviewUpdateDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int reviewUpdate(int idx, String isview) {
		int result = 0;
		Statement stmt = null;
		try {
			String sql = "update t_review_list set rl_isview = '" + isview + "' where rl_idx = " + idx;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("ReviewUpdateDao 클래스의 reviewUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
				
		return result;
	}
	
}
