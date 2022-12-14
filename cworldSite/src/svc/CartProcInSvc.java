package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;

public class CartProcInSvc {
	public int cartInsert(String miid, String piid, int psidx, int count, String sdate, String edate) {
		int result = 0;
		Connection conn = getConnection();
		CartDao cartDao = CartDao.getInstance();
		cartDao.setConnection(conn);
		
		result = cartDao.cartInsert(miid, piid, psidx, count, sdate, edate);
		if(result > 0) 	commit(conn);
		else				rollback(conn);
		close(conn);
		return result;
	}
	public int cartInsert(String miid, String piid, int psidx, int count) {
		int result = 0;
		Connection conn = getConnection();
		CartDao cartDao = CartDao.getInstance();
		cartDao.setConnection(conn);
		
		result = cartDao.cartInsert(miid, piid, psidx, count);
		if(result == 1) 	commit(conn);
		else				rollback(conn);
		close(conn);
		return result;
	}
}
