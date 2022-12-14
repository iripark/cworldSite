package svc;
import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;

public class LoginSvc {
// 로그인에 필요한 아이디와 암호를 받아와 비즈니스 로직을 처리(DB작업 제외)하는 클래스
	String uid;
	public MemberInfo getLoginMember(String uid, String pwd){
		Connection conn = getConnection();
		LoginDao loginDao = LoginDao.getInstance();
		loginDao.setConnection(conn);
		
		MemberInfo loginInfo = loginDao.getLoginMember(uid, pwd);
		close(conn);
		
		return loginInfo;
	}
	public int getLoginUpdate(String uid, String pwd){
		Connection conn = getConnection();
		LoginDao loginDao = LoginDao.getInstance();
		loginDao.setConnection(conn);
		int result = 0;
		result = loginDao.getLoginUpdate(uid, pwd);
		
		if(result == 1) {
			System.out.println("로그인 후 최종로그인일자 및 접속횟수 업데이트 성공!");
		} else {
			System.out.println("로그인 후 최종로그인일자 및 접속횟수 업데이트 실패!");
		}
		
		if (result == 1) 	commit(conn);
		else				rollback(conn);
		close(conn);
		
		return result;
	}
}
