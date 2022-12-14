package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MemberExitSvc {
	public int getExitCount() {
		int rcnt = 0;
		
		Connection conn = getConnection();
		MemberListDao memberListDao = MemberListDao.getInstance();
		memberListDao.setConnection(conn);
		rcnt = memberListDao.getExitCount();
		close(conn);
		
		return rcnt;
	}

	public ArrayList<MemberInfo> getExitList(int cpage, int psize) {
		ArrayList<MemberInfo> exitList = new ArrayList<MemberInfo>();
		
		Connection conn = getConnection();
		MemberListDao memberListDao = MemberListDao.getInstance();
		memberListDao.setConnection(conn);
		exitList = memberListDao.getExitList(cpage, psize);
		close(conn);
		
		return exitList;
	}
}
