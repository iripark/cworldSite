package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;
import java.util.*;

public class AddrSvc {
	public ArrayList<MemberAddr> getAddr(String miid) {
		ArrayList<MemberAddr> addrList = new ArrayList<MemberAddr>();
		
		Connection conn = getConnection();
		AddrDao addrDao = AddrDao.getInstance();
		addrDao.setConnection(conn);
		
		addrList = addrDao.getAddr(miid);
		close(conn);
		
		return addrList;
	}
}
