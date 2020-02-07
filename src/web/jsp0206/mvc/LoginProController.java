package web.jsp0206.mvc;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginProController extends HttpServlet {
	
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String id = req.getParameter("id");
		String pw = req.getParameter("pw");
		
		//DB 연결해서 id,pw체크하는 로직 ...
		//MemberDAO dao = MemberDAO.getInstance();
		//int check = dao.usercheck(id, pw);
		int check = 1;
		
		//view 에게 로그인 체크 결과를 request로 저장해서 넘겨주기
		req.setAttribute("check", check);
		
		RequestDispatcher rd = req.getRequestDispatcher("jsp0206/loginPro.jsp");
		rd.forward(req, resp);
		
		
	}
	
}
