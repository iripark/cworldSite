package dao;

import static db.jdbcUtil.*;
import java.sql.*;
import java.util.*;
import vo.*;

public class IndexDao {
	private static IndexDao indexDao;	
	private Connection conn;
	private IndexDao() {}
	public static IndexDao getInstance() {
		if (indexDao == null) indexDao = new IndexDao();
		return indexDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public ArrayList<PdtInfo> getIndexList(String sql){
		ArrayList<PdtInfo> pl = new ArrayList<PdtInfo>();
		PdtInfo pi = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				pi = new PdtInfo();
				pi.setPi_id(rs.getString("pi_id"));
				pi.setPi_name(rs.getString("pi_name"));
				pi.setPi_dc(rs.getInt("pi_dc"));
				pi.setPi_price(rs.getInt("pi_price"));
				pi.setRealPrice(rs.getInt("pi_dcprice"));
				pi.setPi_special(rs.getString("pi_special"));
				pi.setPi_score(rs.getDouble("pi_score"));
				pi.setPi_img1(rs.getString("pi_img1"));
				pi.setPi_srcnt(rs.getInt("pi_srcnt"));
				pl.add(pi);
			}
		} catch(Exception e) {
			System.out.println("IndexDao클래스의 getIndexList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}
		return pl;
	}
}
