package svc;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class JjimListSvc {

	public ArrayList<PdtInfo> getJjimList(String miid) {
		ArrayList<PdtInfo> jl = new  ArrayList<PdtInfo>();
		
		Connection conn = getConnection();
		ListDao listDao = ListDao.getInstance();
		listDao.setConnection(conn);
		
		jl = listDao.getJjimList(miid);
		close(conn);
		
		return jl;
	}
}
