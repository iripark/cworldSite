package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class ProductProcInSvc {
	public int productInsert(ProductInfo productInfo, int ps_stock, String ps_opt) {
		Connection conn = getConnection();
		ProductProcInDao productProcInDao = ProductProcInDao.getInstance();
		productProcInDao.setConnection(conn);
		
		int result = productProcInDao.productInsert(productInfo, ps_stock, ps_opt);
		if (result == 1) {
			commit(conn);
		} else {
			rollback(conn);
			result = productProcInDao.productOptInsert(productInfo, ps_stock, ps_opt);
			if (result == 1) {
				commit(conn);
			} else {
				rollback(conn);
			}
		}
		close(conn);
		
		return result;
	}
}
