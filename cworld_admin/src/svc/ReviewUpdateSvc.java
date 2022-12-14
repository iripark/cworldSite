package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import dao.*;

public class ReviewUpdateSvc {

	public int reviewUpdate(int idx, String isview) {
		int result = 0;
		
		Connection conn = getConnection();
		ReviewUpdateDao reviewUpdateDao = ReviewUpdateDao.getInstance();
		reviewUpdateDao.setConnection(conn);
		result = reviewUpdateDao.reviewUpdate(idx, isview);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

}
