package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class StockUpdateDao {
	private static StockUpdateDao stockUpdateDao;	
	private Connection conn;			
	private StockUpdateDao() {}
	public static StockUpdateDao getInstance() {
		if (stockUpdateDao == null) {
			stockUpdateDao = new StockUpdateDao();
		}		
		return stockUpdateDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int stockUp(String ps_idx, String ps_stock) {
		int result = 0;
		Statement stmt = null;
		try {
			String sql = "update t_product_stock set ps_stock = ps_stock + " + ps_stock + " where ps_idx = " + ps_idx;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		}  catch(Exception e) {
			System.out.println("StockUpdateDao 클래스의 stockUp() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
}
