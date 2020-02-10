package JSP.jsp0210.mvc;

import java.io.IOException;
import java.rmi.ServerException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;


public class LoginProBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {

		//로그인 처리 로직....
		//DB 연결하여 id, pw 맞는 지 확인하고 결과 리턴 
		
		
		//인코딩 처리
		req.setCharacterEncoding("UTF-8");
		
		//파라미터 꺼내기
		String id = req.getParameter("id");
		String pw = req.getParameter("pw");
		
		//DB 로그인 체크
		M0101DAO dao = M0101DAO.getInstance();
		boolean check = dao.login(id,pw);
		
		//로그인 성공
		if(check) {
			HttpSession session = req.getSession();
			session.setAttribute("memId", id);
		}
		
		//로그인 X
		req.setAttribute("check", check);
		
		
		return "/jsp0210/loginPro.jsp";
	}
	

	
	
}
