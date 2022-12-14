package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import dao.*;

public class IsviewUpdateSvc {
	public int isviewUp(String isview, int ps_idx, String pi_id) {
		int result = 0;
		Connection conn = getConnection();
		IsviewUpdateDao isviewUpdateDao = IsviewUpdateDao.getInstance();
		isviewUpdateDao.setConnection(conn);
		result = isviewUpdateDao.isviewUp(isview, ps_idx, pi_id);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);		
		
		return result;
	}
}
