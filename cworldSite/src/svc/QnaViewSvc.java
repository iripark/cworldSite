package svc;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class QnaViewSvc {
	public QnaInfo getQnaInfo(int idx) {
		QnaInfo qi = null;
		
		Connection conn = getConnection();
		QnaViewDao qnaViewDao = QnaViewDao.getInstance();
		qnaViewDao.setConnection(conn);
		
		qi = qnaViewDao.getQnaInfo(idx);
		close(conn);
		
		return qi;
	}
}
