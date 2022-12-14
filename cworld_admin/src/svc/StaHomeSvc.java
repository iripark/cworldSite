package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import dao.*;

public class StaHomeSvc {

	public String getAmount(String startDate, String endDate) {
		String amount = "";
		
		Connection conn = getConnection();
		StaHomeDao staHomeDao = StaHomeDao.getInstance();
		staHomeDao.setConnection(conn);
		amount = staHomeDao.getAmount(startDate, endDate);
		close(conn);
		
		return amount;
	}

	public String getReview(String startDate, String endDate) {
		String review = "";
		
		Connection conn = getConnection();
		StaHomeDao staHomeDao = StaHomeDao.getInstance();
		staHomeDao.setConnection(conn);
		review = staHomeDao.getReview(startDate, endDate);
		close(conn);
		
		return review;
	}

	public String getDayOfWeek(String startDate, String endDate) {
		String dayOfWeek = "";
			
		Connection conn = getConnection();
		StaHomeDao staHomeDao = StaHomeDao.getInstance();
		staHomeDao.setConnection(conn);
		dayOfWeek = staHomeDao.getDayOfWeek(startDate, endDate);
		close(conn);
		
		return dayOfWeek;
	}

	public String getMonthSale() {
		String monthSale = "";
			
		Connection conn = getConnection();
		StaHomeDao staHomeDao = StaHomeDao.getInstance();
		staHomeDao.setConnection(conn);
		monthSale = staHomeDao.getMonthSale();
		close(conn);
		
		return monthSale;
	}

	public String getMemberCount() {
		String memCnt = "";
		
		Connection conn = getConnection();
		StaHomeDao staHomeDao = StaHomeDao.getInstance();
		staHomeDao.setConnection(conn);
		memCnt = staHomeDao.getMemberCount();
		close(conn);
		
		return memCnt;
	}

	public String getAnswerQnaCount() {
		String qnaCnt = "";
		
		Connection conn = getConnection();
		StaHomeDao staHomeDao = StaHomeDao.getInstance();
		staHomeDao.setConnection(conn);
		
		qnaCnt = staHomeDao.getAnswerQnaCount();
		close(conn);
		
		return qnaCnt;
	}

	public String getAnswerGroupQnaCount() {
		String gQnaCnt = "";
		
		Connection conn = getConnection();
		StaHomeDao staHomeDao = StaHomeDao.getInstance();
		staHomeDao.setConnection(conn);
		
		gQnaCnt = staHomeDao.getAnswerGroupQnaCount();
		close(conn);
		
		return gQnaCnt;
	}

	public String getStockStatusCount() {
		String stockCnt = "";
		
		Connection conn = getConnection();
		StaHomeDao staHomeDao = StaHomeDao.getInstance();
		staHomeDao.setConnection(conn);
		
		stockCnt = staHomeDao.getStockStatusCount();
		close(conn);
		
		return stockCnt;
	}

	public String getRentStatusCount() {
		String rentCnt = "";
		
		Connection conn = getConnection();
		StaHomeDao staHomeDao = StaHomeDao.getInstance();
		staHomeDao.setConnection(conn);
		
		rentCnt = staHomeDao.getRentStatusCount();
		close(conn);
		
		return rentCnt;
	}

	public String getCtgrSalesSum() {
		String ctgrSaleSum = "";
		
		Connection conn = getConnection();
		StaHomeDao staHomeDao = StaHomeDao.getInstance();
		staHomeDao.setConnection(conn);
		
		ctgrSaleSum = staHomeDao.getCtgrSalesSum();
		close(conn);
		
		return ctgrSaleSum;
	}
	
	

}
