package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import dao.*;

public class StockUpdateSvc {
	public int stockUp(String ps_idx, String ps_stock) {
		int result = 0;
		
		Connection conn = getConnection();
		StockUpdateDao stockUpdateDao = StockUpdateDao.getInstance();
		stockUpdateDao.setConnection(conn);
		result = stockUpdateDao.stockUp(ps_idx, ps_stock);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);		
		
		return result;
	}
	
}
