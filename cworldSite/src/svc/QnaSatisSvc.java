package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;
import java.util.*;

public class QnaSatisSvc {
	public int satisUp(int idx, String satis) {
		int result = 0;
		
		Connection conn = getConnection();
		QnaSatisDao qnaSatisDao = QnaSatisDao.getInstance();
		qnaSatisDao.setConnection(conn);
		
		result = qnaSatisDao.satisUp(idx, satis);
		if (result == 1) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}
}
