package svc;

import static db.jdbcUtil.*;
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

	public int getReviewCount(String where) {
		int rcnt = 0;
		
		Connection conn = getConnection();
		ListDao listDao = ListDao.getInstance();
		listDao.setConnection(conn);
		
		rcnt = listDao.getReviewCount(where);
		close(conn);
		
		return rcnt;
	}

	public ArrayList<ReviewInfo> getReviewList(String where, int cpage, int psize) {
		ArrayList<ReviewInfo> reviewList = new ArrayList<ReviewInfo>();
		
		Connection conn = getConnection();
		ListDao listDao = ListDao.getInstance();
		listDao.setConnection(conn);
		
		reviewList = listDao.getReviewList(where, cpage, psize);
		close(conn);
		
		return reviewList;
	}

	public int readUpdateReview(int idx) {
		int result = 0;
		
		Connection conn = getConnection();
		ListDao listDao = ListDao.getInstance();
		listDao.setConnection(conn);
		
		result = listDao.readUpdateReview(idx);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	public ReviewInfo getReviewInfo(int idx) {
		ReviewInfo ri = null;
		
		Connection conn = getConnection();
		ListDao listDao = ListDao.getInstance();
		listDao.setConnection(conn);
		
		ri = listDao.getReviewInfo(idx);
		close(conn);
		
		return ri;
	}

	public int getMyReviewCount(String miid) {
		int rcnt = 0;
		
		Connection conn = getConnection();
		ListDao listDao = ListDao.getInstance();
		listDao.setConnection(conn);
		
		rcnt = listDao.getMyReviewCount(miid);
		close(conn);
		
		return rcnt;
	}

	public ArrayList<ReviewInfo> getMyReviewList(String miid, int cpage, int psize) {
		ArrayList<ReviewInfo> reviewList = new ArrayList<ReviewInfo>();
		
		Connection conn = getConnection();
		ListDao listDao = ListDao.getInstance();
		listDao.setConnection(conn);
		
		reviewList = listDao.getMyReviewList(miid, cpage, psize);
		close(conn);
		
		return reviewList;		
	}
}
