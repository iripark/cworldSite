package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;

public class GReviewViewSvc {

	public GReviewInfo getGReviewInfo(int idx) {
		GReviewInfo gri = null;
		
		Connection conn = getConnection();
		GReviewViewDao gReviewViewDao = GReviewViewDao.getInstance();
		gReviewViewDao.setConnection(conn);
		gri = gReviewViewDao.getGReviewInfo(idx);
		close(conn);
		
		return gri;
	}

}
