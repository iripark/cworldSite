package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class ReviewListSvc {
	public int getReviewCount(String where) {
		int rcnt = 0;
		
		Connection conn = getConnection();
		ReviewListDao reviewListDao = ReviewListDao.getInstance();
		reviewListDao.setConnection(conn);
		
		rcnt = reviewListDao.getReviewCount(where);
		close(conn);

		return rcnt;
	}

	public ArrayList<ReviewInfo> getReviewList(int cpage, int psize, String where) {
		ArrayList<ReviewInfo> rl = new ArrayList<ReviewInfo>();
		
		Connection conn = getConnection();
		ReviewListDao reviewListDao = ReviewListDao.getInstance();
		reviewListDao.setConnection(conn);
		
		rl = reviewListDao.getReviewList(cpage, psize, where);
		close(conn);
		return rl;
	}
}
