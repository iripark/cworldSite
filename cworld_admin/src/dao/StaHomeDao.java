package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;

public class StaHomeDao {
	private static StaHomeDao staHomeDao;	
	private Connection conn;			
	private StaHomeDao() {}
	public static StaHomeDao getInstance() {
		if (staHomeDao == null) {
			staHomeDao = new StaHomeDao();
		}		
		return staHomeDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public String getAmount(String startDate, String endDate) {
		String amount = "";
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "";
			if (startDate.equals("") && endDate.equals("")) {
				sql = "select count(*), ctgr from v_order_amount where datediff(date(oi_date), date(now())) >= -30 and datediff(date(oi_date), date(now())) <= 0 group by ctgr order by ctgr";
			} else if (!startDate.equals("") && !endDate.equals("")) {
				sql = "select count(*), ctgr from v_order_amount where datediff(date(oi_date), '" + startDate + "') >= datediff('" + startDate + "', date(now())) and datediff(date(oi_date), '" + endDate + "') <= datediff('" + endDate + "', date(now())) group by ctgr order by ctgr";
			} else if (!startDate.equals("")) {
				sql = "select count(*), ctgr from v_order_amount where datediff(date(oi_date), '" + startDate + "') >= datediff('" + startDate + "', date(now())) and datediff(date(oi_date), date(now())) <= 0 group by ctgr order by ctgr";
			}
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				amount += "," + rs.getString(2) + ":" + rs.getInt(1);
			}
			amount = amount.substring(1);
		} catch(Exception e) {
			System.out.println("StaHomeDao 클래스의 getAmount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return amount;
	}
	public String getReview(String startDate, String endDate) {
		String review = "";
		Statement stmt = null;
		ResultSet rs = null;
		try {			
			String sql = "";
			if (startDate.equals("") && endDate.equals("")) {
				sql = "select count(*), left(a.pi_id, 1) ctgr from v_order_amount a, t_review_list b where a.oi_id = b.oi_id and datediff(date(oi_date), date(now())) >= -30 and datediff(date(oi_date), date(now())) <= 0 and datediff(date(rl_date), date(now())) >= -30 and datediff(date(rl_date), date(now())) <= 0 group by ctgr order by ctgr";
			} else if (!startDate.equals("") && !endDate.equals("")) {
				sql = "select count(*), left(a.pi_id, 1) ctgr from v_order_amount a, t_review_list b where a.oi_id = b.oi_id and datediff(date(oi_date), '" + startDate + "') >= datediff('" + startDate + "', date(now())) and datediff(date(oi_date), '" + endDate + "') <= datediff('" + endDate + "', date(now())) and datediff(date(rl_date), '" + startDate + "') >= datediff('" + startDate + "', date(now())) and datediff(date(rl_date), '" + endDate + "') <= datediff('" + endDate + "', date(now())) group by ctgr order by ctgr";
			} else if (!startDate.equals("")) {
				sql = "select count(*), left(a.pi_id, 1) ctgr from v_order_amount a, t_review_list b where a.oi_id = b.oi_id and datediff(date(oi_date), '" + startDate + "') >= datediff('" + startDate + "', date(now())) and datediff(date(oi_date), date(now())) <= 0 and datediff(date(rl_date), '" + startDate + "') >= datediff('" + startDate + "', date(now())) and datediff(date(rl_date), date(now())) <= 0 group by ctgr order by ctgr";
			}
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				review += "," + rs.getString(2) + ":" + rs.getInt(1);
			}
			review = review.substring(1);
		} catch(Exception e) {
			System.out.println("StaHomeDao 클래스의 getReview() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return review;
	}	
	public String getDayOfWeek(String startDate, String endDate) {
		String dayOfWeek = "";
		Statement stmt = null;
		ResultSet rs = null;		
		try {
			String sql = "";
			if (startDate.equals("") && endDate.equals("")) {
				sql = "select dayofweek(date(oi_date)) day, sum(price) price, sum(realCost) cost from v_day_rs where datediff(date(oi_date), date(now())) >= -30 and datediff(date(oi_date), date(now())) <= 0 group by day order by day";
			} else if (!startDate.equals("") && !endDate.equals("")) {
				sql = "select dayofweek(date(oi_date)) day, sum(price) price, sum(realCost) cost from v_day_rs where datediff(date(oi_date), '" + startDate + "') >= datediff('" + startDate + "', date(now())) and datediff(date(oi_date), '" + endDate + "') <= datediff('" + endDate + "', date(now())) group by day order by day";
			} else if (!startDate.equals("")) {
				sql = "select dayofweek(date(oi_date)) day, sum(price) price, sum(realCost) cost from v_day_rs where datediff(date(oi_date), '" + startDate + "') >= datediff('" + startDate + "', date(now())) and datediff(date(oi_date), date(now())) <= 0 group by day order by day";
			}			
			stmt = conn.createStatement();		// 1:일 ~ 7:토
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				dayOfWeek += "," + rs.getString(1) + ":" + rs.getInt(2) + ":" + rs.getInt(3);
			}
			dayOfWeek = dayOfWeek.substring(1);
		} catch(Exception e) {
			System.out.println("StaHomeDao 클래스의 getDayOfWeek() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return dayOfWeek;
	}
	public String getMonthSale() {
		String monthSale = "";
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select y, m, left(pi_id, 1) ctgr, sum(price - realCost) benefit from v_day_rs where y = left(now(), 4) group by y, m, ctgr";
			stmt = conn.createStatement();		
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				monthSale += "," + rs.getString("m") + ":" + rs.getString("ctgr") + ":" + rs.getInt("benefit");
			}
			monthSale = monthSale.substring(1);
		} catch(Exception e) {
			System.out.println("StaHomeDao 클래스의 getMonthSale() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return monthSale;
	}
	public String getMemberCount() {
		String memCnt = "";
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_member_info union all " + 
					" select count(*) from t_member_info where mi_status = 'a' union all " + 
					" select count(*) from t_member_info where mi_status = 'b' union all " + 
					" select count(*) from t_member_info where mi_status = 'c'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				memCnt += "," + rs.getInt(1);
			}
			memCnt = memCnt.substring(1);
		} catch(Exception e) {
			System.out.println("StaHomeDao 클래스의 getMemberCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return memCnt;
	}
	public String getAnswerQnaCount() {
		String qnaCnt = "";
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_qna_list union all select count(*) from t_qna_list where ql_isanswer = 'y' union all select count(*) from t_qna_list where ql_isanswer = 'n'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				qnaCnt += "," + rs.getInt(1);
			}
			qnaCnt = qnaCnt.substring(1);
		} catch(Exception e) {
			System.out.println("StaHomeDao 클래스의 getAnswerQnaCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return qnaCnt;
	}	// 
	public String getAnswerGroupQnaCount() {
		String gQnaCnt = "";
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_group_qna union all select count(*) from t_group_qna where gq_isreply = 'y' union all select count(*) from t_group_qna where gq_isreply = 'n'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				gQnaCnt += "," + rs.getInt(1);
			}
			gQnaCnt = gQnaCnt.substring(1);
		} catch(Exception e) {
			System.out.println("StaHomeDao 클래스의 getAnswerGroupQnaCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return gQnaCnt;
	}
	public String getStockStatusCount() {
		String stockCnt = "";
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_product_stock where ps_stock > 50 union all select count(*) from t_product_stock where ps_stock <= 50 and ps_stock > 0 union all select count(*) from t_product_stock where ps_stock <= 0";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				stockCnt += "," + rs.getInt(1);
			}
			stockCnt = stockCnt.substring(1);
		} catch(Exception e) {
			System.out.println("StaHomeDao 클래스의 getStockStatusCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return stockCnt;
	}
	public String getRentStatusCount() {
		String rentCnt = "";
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select * from v_rent_status";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				rentCnt += "," + rs.getInt(1);
			}
			rentCnt = rentCnt.substring(1);
		} catch(Exception e) {
			System.out.println("StaHomeDao 클래스의 getRentStatusCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return rentCnt;
	}
	public String getCtgrSalesSum() {
		String ctgrSaleSum = "";
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select ifnull(sum(ord_price * ord_cnt), 0) from t_order_rent_detail where left(pi_id, 1) = 'P' union all select ifnull(sum(ord_price * ord_cnt), 0) from t_order_rent_detail where left(pi_id, 1) = 'R' union all select ifnull(sum(osd_price * osd_cnt), 0) from t_order_sale_detail";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				ctgrSaleSum += "," + rs.getInt(1);
			}
			ctgrSaleSum = ctgrSaleSum.substring(1);
		} catch(Exception e) {
			System.out.println("StaHomeDao 클래스의 getRentStatusCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return ctgrSaleSum;
	}
}
