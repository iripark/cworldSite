package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class ProductIsReturnSvc {

	public int isReturnUpdate(int idx, String isRe, int cnt, int psidx) {
		int result = 0;
		Connection conn = getConnection();
		ProductDao productDao = ProductDao.getInstance();
		productDao.setConnection(conn);
		result = productDao.isReturnUpdate(idx, isRe, cnt, psidx);
		if (result == 1) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}
	
}
