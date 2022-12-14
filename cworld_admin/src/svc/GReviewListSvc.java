package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class GReviewListSvc {

	public int getGReviewCount(String where) {
		int rcnt = 0;
		
		Connection conn = getConnection();
		GReviewListDao gReviewListDao = GReviewListDao.getInstance();
		gReviewListDao.setConnection(conn);
		
		rcnt = gReviewListDao.getGReviewCount(where);
		close(conn);

		return rcnt;
	}

	public ArrayList<GReviewInfo> getGReviewList(int cpage, int psize, String where) {
		ArrayList<GReviewInfo> gReviewList = new ArrayList<GReviewInfo>();
		
		Connection conn = getConnection();
		GReviewListDao gReviewListDao = GReviewListDao.getInstance();
		gReviewListDao.setConnection(conn);
		
		gReviewList = gReviewListDao.getGReviewList(cpage, psize, where);
		close(conn);
		
		return gReviewList;
	}

}
