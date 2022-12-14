package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MemberPointUpdateSvc {
	public int memPointUpdate(String miid, int point) {
		int result = 0;
		
		Connection conn = getConnection();
		MemberPointUpdateDao memberPointUpdateDao = MemberPointUpdateDao.getInstance();
		memberPointUpdateDao.setConnection(conn);
		result = memberPointUpdateDao.memPointUpdate(miid, point);
		if (result == 1) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}
}
