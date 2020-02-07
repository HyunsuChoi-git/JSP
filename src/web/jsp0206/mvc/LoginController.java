package web.jsp0206.mvc;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginController extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		RequestDispatcher rd = req.getRequestDispatcher("/jsp0206/loginForm.jsp");
		rd.forward(req, resp);
		
		//loginform컨트롤러는 로직처리할 필요가 없기때문에 view페이지를 찾아서 보여주기만 함
	}
	
}
