package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class MypageRentListSvc {
	public int getRentListCount(String miid) {
		int rcnt = 0;
		
		Connection conn = getConnection();
		MypageRentListDao mypageRentListDao = MypageRentListDao.getInstance();
		mypageRentListDao.setConnection(conn);
		
		rcnt = mypageRentListDao.getRentListCount(miid);
		close(conn);
		
		return rcnt;
	}

	public ArrayList<MypageRentInfo> getRentList(String miid, int cpage, int psize) {
		ArrayList<MypageRentInfo> mrl = new ArrayList<MypageRentInfo>();
		
		Connection conn = getConnection();
		MypageRentListDao mypageRentListDao = MypageRentListDao.getInstance();
		mypageRentListDao.setConnection(conn);
		
		mrl = mypageRentListDao.getRentList(miid, cpage, psize);
		close(conn);
		
		return mrl;
	}
}
