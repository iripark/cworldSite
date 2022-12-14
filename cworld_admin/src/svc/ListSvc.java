package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class ListSvc {
	public int getNoticeCount() {
		int rcnt = 0;
		Connection conn = getConnection();
		ListDao listDao = ListDao.getInstance();
		listDao.setConnection(conn);
		
		rcnt = listDao.getNoticeCount();
		close(conn);
		
		return rcnt;
	}

	public ArrayList<NoticeInfo> getNoticeList(int cpage, int psize) {
		ArrayList<NoticeInfo> noticeList = new ArrayList<NoticeInfo>();
		
		Connection conn = getConnection();
		ListDao listDao = ListDao.getInstance();
		listDao.setConnection(conn);
		
		noticeList = listDao.getNoticeList(cpage, psize);
		close(conn);
		
		return noticeList;
	}

	public int noticeInsert(NoticeInfo noticeInfo) {
		int idx = 0;
		
		Connection conn = getConnection();
		ListDao listDao = ListDao.getInstance();
		listDao.setConnection(conn);
		
		idx = listDao.noticeInsert(noticeInfo);
		if(idx > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return idx;
	}

	public int readUpdate(int idx) {
		int result = 0;
		
		Connection conn = getConnection();
		ListDao listDao = ListDao.getInstance();
		listDao.setConnection(conn);
		
		result = listDao.readUpdate(idx);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	public NoticeInfo getNoticeInfo(int idx) {
		NoticeInfo noticeInfo = null;
		
		Connection conn = getConnection();
		ListDao listDao = ListDao.getInstance();
		listDao.setConnection(conn);
		
		noticeInfo = listDao.getNoticeInfo(idx);
		close(conn);
		
		return noticeInfo;
	}

	public int isviewUpdate(int idx, String isview) {
		int result = 0;
		
		Connection conn = getConnection();
		ListDao listDao = ListDao.getInstance();
		listDao.setConnection(conn);
		
		result = listDao.isviewUpdate(idx, isview);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	public int NoticeDelete(int idx) {
		int result = 0;
		
		Connection conn = getConnection();
		ListDao listDao = ListDao.getInstance();
		listDao.setConnection(conn);
		
		result = listDao.NoticeDelete(idx);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	public int noticeUpdate(NoticeInfo ni) {
		int result = 0;
		
		Connection conn = getConnection();
		ListDao listDao = ListDao.getInstance();
		listDao.setConnection(conn);
		
		result = listDao.noticeUpdate(ni);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		
		close(conn);
		return result;
	}
}
