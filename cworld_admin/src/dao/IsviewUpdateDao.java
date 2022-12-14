package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class IsviewUpdateDao {
	private static IsviewUpdateDao isviewUpdateDao;	
	private Connection conn;			
	private IsviewUpdateDao() {}
	public static IsviewUpdateDao getInstance() {
		if (isviewUpdateDao == null) {
			isviewUpdateDao = new IsviewUpdateDao();
		}		
		return isviewUpdateDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int isviewUp(String isview, int ps_idx, String pi_id) {
		int result = 0;
		Statement stmt = null;
		try {
			String sql = "update t_product_stock set ps_isview = '" + isview + "' where pi_id = '" + pi_id + "' and ps_idx = " + ps_idx;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("IsviewUpdateDao 클래스의 isviewUp() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
}
