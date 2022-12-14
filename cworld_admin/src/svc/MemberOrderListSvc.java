package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MemberOrderListSvc {
	public int getOrderCount(String where) {
		int rcnt = 0;
		
		Connection conn = getConnection();
		MemberOrderListDao memberOrderListDao = MemberOrderListDao.getInstance();
		memberOrderListDao.setConnection(conn);
		rcnt = memberOrderListDao.getOrderCount(where);
		close(conn);		
		
		return rcnt;
	}

	public ArrayList<MemberOrderInfo> getOrderList(int cpage, int psize, String where) {
		ArrayList<MemberOrderInfo> memberOrderList = new ArrayList<MemberOrderInfo>();
		
		Connection conn = getConnection();
		MemberOrderListDao memberOrderListDao = MemberOrderListDao.getInstance();
		memberOrderListDao.setConnection(conn);
		memberOrderList = memberOrderListDao.getOrderList(cpage, psize, where);
		close(conn);	
		
		return memberOrderList;
	}

}
