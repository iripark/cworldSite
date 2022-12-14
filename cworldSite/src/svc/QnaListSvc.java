package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class QnaListSvc {

	public int getQnaListCount(String miid) {
		int rcnt = 0;
		
		Connection conn = getConnection();
		QnaListDao qnaListDao = QnaListDao.getInstance();
		qnaListDao.setConnection(conn);
		rcnt = qnaListDao.getQnaListCount(miid);
		close(conn);
		
		return rcnt;
	}

	public ArrayList<QnaInfo> getQnaList(String miid, int cpage, int psize) {
		ArrayList<QnaInfo> ql = new ArrayList<QnaInfo>();
		
		Connection conn = getConnection();
		QnaListDao qnaListDao = QnaListDao.getInstance();
		qnaListDao.setConnection(conn);
		ql = qnaListDao.getQnaList(miid, cpage, psize);
		close(conn);
		
		return ql;
	}

	
	
}
