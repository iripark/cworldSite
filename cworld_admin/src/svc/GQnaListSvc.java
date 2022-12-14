package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class GQnaListSvc {
	public int getGQnaCount(String where) {
		int rcnt = 0;
		
		Connection conn = getConnection();
		GQnaListDao gQnaListDao = GQnaListDao.getInstance();
		gQnaListDao.setConnection(conn);
		
		rcnt = gQnaListDao.getGQnaCount(where);
		close(conn);

		return rcnt;
	}

	public ArrayList<GQnaInfo> getGQnaList(int cpage, int psize, String where) {
		ArrayList<GQnaInfo> gQnaList = new ArrayList<GQnaInfo>();
		Connection conn = getConnection();
		GQnaListDao gQnaListDao = GQnaListDao.getInstance();
		gQnaListDao.setConnection(conn);
		
		gQnaList = gQnaListDao.getGQnaList(cpage, psize, where);
		close(conn);
		
		return gQnaList;
	}

}
