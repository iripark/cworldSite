package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MemberLastSvc {
	public int getLastCount() {
		int rcnt = 0;
		
		Connection conn = getConnection();
		MemberListDao memberListDao = MemberListDao.getInstance();
		memberListDao.setConnection(conn);
		rcnt = memberListDao.getLastCount();
		close(conn);
		
		return rcnt;
	}

	public ArrayList<MemberInfo> getLastList(int cpage, int psize) {
		ArrayList<MemberInfo> mi = new ArrayList<MemberInfo>();
		
		Connection conn = getConnection();
		MemberListDao memberListDao = MemberListDao.getInstance();
		memberListDao.setConnection(conn);
		mi = memberListDao.getLastList(cpage, psize);
		close(conn);
		
		return mi;
	}

	public String getMemberLast() {
		String memLast = "";
		
		Connection conn = getConnection();
		MemberListDao memberListDao = MemberListDao.getInstance();
		memberListDao.setConnection(conn);
		
		memLast = memberListDao.getMemberLast();
		close(conn);
		return memLast;
	}
}
