package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import java.util.ArrayList;

import dao.*;
import vo.*;

public class ProductViewSvc {	
	public PdtInfo getProductView(String piid) {
		PdtInfo pdtInfo = null;
		Connection conn = getConnection();
		ProductDao productDao = ProductDao.getInstance();
		productDao.setConnection(conn);
		
		pdtInfo = productDao.getProductView(piid);
		close(conn);
		
		return pdtInfo;
	}
	public int readUpdate(String piid) {
		int result = 0;
		Connection conn = getConnection();
		ProductDao productDao = ProductDao.getInstance();
		productDao.setConnection(conn);
		
		result = productDao.readUpdate(piid);
		if(result == 1)	commit(conn);
		else			rollback(conn);
		close(conn);
		
		return result;
	}
	
	public ArrayList<ReviewInfo> getReviewList(String piid) {
		ArrayList<ReviewInfo> reviewList = new ArrayList<ReviewInfo>();
		int result = 0;
		Connection conn = getConnection();
		ProductDao productDao = ProductDao.getInstance();
		productDao.setConnection(conn);
		
		reviewList = productDao.getReviewList(piid);
		close(conn);
		
		return reviewList;
	}
}
