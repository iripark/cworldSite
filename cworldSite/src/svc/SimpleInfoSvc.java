package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import java.util.*;
import dao.*;
import vo.*;

public class SimpleInfoSvc {
	public String getSimple(String miid) {
		String simpleOrder = "";
		Connection conn = getConnection();
		SimpleInfoDao simpleInfoDao = SimpleInfoDao.getInstance();
		simpleInfoDao.setConnection(conn);
		
		simpleOrder = simpleInfoDao.getSimple(miid);
		close(conn);
		
		return simpleOrder;
	}

	public int getPoint(String miid) {
		int mipoint = 0;
		Connection conn = getConnection();
		SimpleInfoDao simpleInfoDao = SimpleInfoDao.getInstance();
		simpleInfoDao.setConnection(conn);
		
		mipoint = simpleInfoDao.getPoint(miid);
		close(conn);
		return mipoint;
	}
}
