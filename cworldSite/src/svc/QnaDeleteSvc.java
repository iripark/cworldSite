package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class QnaDeleteSvc {
	public int qnaDelete(int idx) {
		int result = 0;
		
		Connection conn = getConnection();
		QnaDeleteDao qnaDeleteDao = QnaDeleteDao.getInstance();
		qnaDeleteDao.setConnection(conn);
		
		result = qnaDeleteDao.qnaDelete(idx);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}
}
