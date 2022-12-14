package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class OrderStatusUpdateDao {
	private static OrderStatusUpdateDao orderStatusUpdateDao;	
	private Connection conn;			
	private OrderStatusUpdateDao() {}
	public static OrderStatusUpdateDao getInstance() {
		if (orderStatusUpdateDao == null) {
			orderStatusUpdateDao = new OrderStatusUpdateDao();
		}		
		return orderStatusUpdateDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int statusUpdate(String oiid, String status) {
		int result = 0;
		Statement stmt = null;
		
		try {
			String sql = "update t_order_info set oi_status = '" + status + "' where oi_id = '" + oiid + "'";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("OrderStatusUpdateDao 클래스의 statusUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	public int invoiceUpdate(String oiid, String invoice) {
		int result = 0;
		Statement stmt = null;
		
		try {
			String sql = "update t_order_info set oi_invoice = '" + invoice + "' where oi_id = '" + oiid + "'";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("OrderStatusUpdateDao 클래스의 invoiceUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
}
