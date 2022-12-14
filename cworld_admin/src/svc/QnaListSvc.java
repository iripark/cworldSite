package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class QnaListSvc {
	public int getQnaCount(String where) {
		int rcnt = 0;
		Connection conn = getConnection();
		QnaListDao qnaListDao = QnaListDao.getInstance();
		qnaListDao.setConnection(conn);
		
		rcnt = qnaListDao.getQnaCount(where);
		close(conn);

		return rcnt;
	}

	public ArrayList<QnaInfo> getQnaList(int cpage, int psize, String where) {
		ArrayList<QnaInfo> qnaLsit = new ArrayList<QnaInfo>();
		Connection conn = getConnection();
		QnaListDao qnaListDao = QnaListDao.getInstance();
		qnaListDao.setConnection(conn);
		
		qnaLsit = qnaListDao.getQnaList(cpage, psize, where);
		close(conn);
		return qnaLsit;
	}

}
