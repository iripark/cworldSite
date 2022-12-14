package vo;

import javax.mail.*;

public class NaverAuthentication extends Authenticator {
	PasswordAuthentication passAuth;
	
	public NaverAuthentication() {
		passAuth = new PasswordAuthentication("1841pjs", "비밀번호");
	}
	public PasswordAuthentication getPasswordAuthentication() {
		return passAuth;
	}
}
