package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class ProductProcUpSvc {
	public int pdtUpdate(ProductInfo pi, int ps_stock, String ps_opt) {
		int result = 0;
		Connection conn = getConnection();
		ProductDao productDao = ProductDao.getInstance();
		productDao.setConnection(conn);
		
		result = productDao.pdtUpdate(pi, ps_stock, ps_opt);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		return result;
	}
	
}
