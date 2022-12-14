package svc;
import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;
import java.util.*;

public class IndexSvc {
	public ArrayList<PdtInfo> getIndexList(String sql){
		ArrayList<PdtInfo> pl = new ArrayList<PdtInfo>();
		Connection conn = getConnection();
		IndexDao indexDao = IndexDao.getInstance();
		indexDao.setConnection(conn);
		
		pl = indexDao.getIndexList(sql);
		close(conn);
		return pl;
	}
}
