package svc;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class GqnaListSvc {
	public int getGqnaCount() {
		int rcnt = 0;
		Connection conn = getConnection();
		GQnaListDao gQnaListDao = GQnaListDao.getInstance();
		gQnaListDao.setConnection(conn);
		
		rcnt = gQnaListDao.getGqnaCount();
		close(conn);
		
		return rcnt;
	}

	public ArrayList<GqnaInfo> getGqnaList(int cpage, int psize) {
		ArrayList<GqnaInfo> gqnaInfo = new ArrayList<GqnaInfo>();
		
		Connection conn = getConnection();
		GQnaListDao gQnaListDao = GQnaListDao.getInstance();
		gQnaListDao.setConnection(conn);
		
		gqnaInfo = gQnaListDao.getGqnaList(cpage, psize);
		close(conn);
		
		return gqnaInfo;
	}

	public int GqnaListInsert(GqnaInfo gqnaInfo) {
		int idx = 0;
		
		Connection conn = getConnection();
		GQnaListDao gQnaListDao = GQnaListDao.getInstance();
		gQnaListDao.setConnection(conn);
		
		idx = gQnaListDao.GqnaListInsert(gqnaInfo);
		if(idx > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return idx;
	}

	public GqnaInfo getGqnaInfo(int idx) {
		GqnaInfo gqnaInfo = null;
		
		Connection conn = getConnection();
		GQnaListDao gQnaListDao = GQnaListDao.getInstance();
		gQnaListDao.setConnection(conn);
		
		gqnaInfo = gQnaListDao.getGqnaInfo(idx);
		close(conn);
		
		return gqnaInfo;
	}

	public int getMyGqnaCount(String miid) {
		int rcnt = 0;
		Connection conn = getConnection();
		GQnaListDao gQnaListDao = GQnaListDao.getInstance();
		gQnaListDao.setConnection(conn);
		
		rcnt = gQnaListDao.getMyGqnaCount(miid);
		close(conn);
		
		return rcnt;
	}

	public ArrayList<GqnaInfo> getMyGqnaList(String miid, int cpage, int psize) {
		ArrayList<GqnaInfo> gqnaInfo = new ArrayList<GqnaInfo>();
		
		Connection conn = getConnection();
		GQnaListDao gQnaListDao = GQnaListDao.getInstance();
		gQnaListDao.setConnection(conn);
		
		gqnaInfo = gQnaListDao.getMyGqnaList(miid, cpage, psize);
		close(conn);
		
		return gqnaInfo;
	}

	public String getWriter(int idx) {
		String writer = "";
		Connection conn = getConnection();
		GQnaListDao gQnaListDao = GQnaListDao.getInstance();
		gQnaListDao.setConnection(conn);
		writer = gQnaListDao.getWriter(idx);
		
		return writer;
	}	
}

