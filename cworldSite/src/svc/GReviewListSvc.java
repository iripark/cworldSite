package svc;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class GReviewListSvc {
	public int getGreviewCount() {
		int rcnt = 0;
		Connection conn = getConnection();
		GReviewListDao gReviewListDao = GReviewListDao.getInstance();
		gReviewListDao.setConnection(conn);
		
		rcnt = gReviewListDao.getGreviewCount();
		close(conn);
		
		return rcnt;
	}

	public ArrayList<GReviewInfo> getReviewList(int cpage, int psize) {
		ArrayList<GReviewInfo> gReviewInfo = new ArrayList<GReviewInfo>();
		
		Connection conn = getConnection();
		GReviewListDao gReviewListDao = GReviewListDao.getInstance();
		gReviewListDao.setConnection(conn);
		
		gReviewInfo = gReviewListDao.getReviewList(cpage, psize);
		close(conn);
		
		return gReviewInfo;
	}

	public int GReviewListInsert(GReviewInfo gReviewInfo) {
		int idx = 0;
		
		Connection conn = getConnection();
		GReviewListDao gReviewListDao = GReviewListDao.getInstance();
		gReviewListDao.setConnection(conn);
		
		idx = gReviewListDao.GReviewListInsert(gReviewInfo);
		if(idx > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return idx;
	}

	public GReviewInfo getGReviewInfo(int idx) {
		GReviewInfo gReviewInfo = null;
		
		Connection conn = getConnection();
		GReviewListDao gReviewListDao = GReviewListDao.getInstance();
		gReviewListDao.setConnection(conn);
		
		gReviewInfo = gReviewListDao.getGReviewInfo(idx);
		close(conn);
		
		return gReviewInfo;
	}	
}
	