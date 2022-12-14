package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MemberListSvc {
	public ArrayList<MemberInfo> getMemberList(int cpage, int psize, String where) {
		ArrayList<MemberInfo> memberList = new ArrayList<MemberInfo>();
		
		Connection conn = getConnection();
		MemberListDao memberListDao = MemberListDao.getInstance();
		memberListDao.setConnection(conn);
		memberList = memberListDao.getMemberList(cpage, psize, where);
		close(conn);
		
		return memberList;
	}

	public int getMemberCount(String where) {
		int rcnt = 0;
		
		Connection conn = getConnection();
		MemberListDao memberListDao = MemberListDao.getInstance();
		memberListDao.setConnection(conn);
		rcnt = memberListDao.getMemberCount(where);
		close(conn);
		
		return rcnt;
	}
}
