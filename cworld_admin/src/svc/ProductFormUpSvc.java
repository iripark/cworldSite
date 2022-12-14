package svc;

import static db.JdbcUtil.*;

import java.sql.*;
import dao.*;
import vo.*;

public class ProductFormUpSvc {
	public ProductInfo getPdtInfo(String pi_id, int ps_idx) {
		Connection conn = getConnection();
		ProductDao productDao = ProductDao.getInstance();
		productDao.setConnection(conn);
		
		ProductInfo pi =  productDao.getPdtInfo(pi_id, ps_idx);
		close(conn);
		
		return pi;
	}

}
