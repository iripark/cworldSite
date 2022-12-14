package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import dao.*;

public class GQnaUpdateSvc {
	public int gqnaUpdate(String kind, String value, int idx) {
		int result = 0;
		
		Connection conn = getConnection();
		GQnaUpdateDao gQnaUpdateDao = GQnaUpdateDao.getInstance();
		gQnaUpdateDao.setConnection(conn);
		
		result = gQnaUpdateDao.gqnaUpdate(kind, value, idx);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);	
		return result;
	}
	
}
