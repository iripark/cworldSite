package svc;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class ReviewProcInSvc {
	public int reviewInsert(ReviewInfo ri) {
		int idx = 0;
		
		Connection conn = getConnection();
		ReviewProcInDao reviewProcInDao = ReviewProcInDao.getInstance();
		reviewProcInDao.setConnection(conn);
		
		idx = reviewProcInDao.reviewInsert(ri);
		if(idx > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);		
		return idx;
	}

}
