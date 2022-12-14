package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;
import java.util.*;

public class MemberPointSvc {
	public ArrayList<MemberPoint> getPointList(String miid, int cpage, int psize) {
		ArrayList<MemberPoint> pointList = new ArrayList<MemberPoint>();
		
		Connection conn = getConnection();
		MemberPointDao memberPointDao = MemberPointDao.getInstance();
		memberPointDao.setConnection(conn);
		
		pointList = memberPointDao.getPointList(miid, cpage, psize);
		close(conn);
		
		return pointList;
	}

	public int getPointCount(String miid) {
		int rcnt = 0;
		
		Connection conn = getConnection();
		MemberPointDao memberPointDao = MemberPointDao.getInstance();
		memberPointDao.setConnection(conn);
		
		rcnt = memberPointDao.getPointCount(miid);
		close(conn);
		return rcnt;
	}

	public int getTotalPoint(String miid) {
		int total = 0;
		
		Connection conn = getConnection();
		MemberPointDao memberPointDao = MemberPointDao.getInstance();
		memberPointDao.setConnection(conn);
		
		total = memberPointDao.getTotalPoint(miid);
		close(conn);
		return total;
	}
}
