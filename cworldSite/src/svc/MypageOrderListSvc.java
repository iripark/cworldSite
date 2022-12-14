package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class MypageOrderListSvc {

	public int getOrderListCount(String miid) {
		int rcnt = 0;
		
		Connection conn = getConnection();
		MypageOrderListDao mypageOrderListDao = MypageOrderListDao.getInstance();
		mypageOrderListDao.setConnection(conn);
		
		rcnt = mypageOrderListDao.getOrderListCount(miid);
		close(conn);
		
		return rcnt;
	}

	public ArrayList<MypageOrderInfo> getOrderList(String miid, int cpage, int psize) {
		ArrayList<MypageOrderInfo> ol = new ArrayList<MypageOrderInfo>();
		
		Connection conn = getConnection();
		MypageOrderListDao mypageOrderListDao = MypageOrderListDao.getInstance();
		mypageOrderListDao.setConnection(conn);
		
		ol = mypageOrderListDao.getOrderList(miid, cpage, psize);
		close(conn);
		
		return ol;
	}

}
