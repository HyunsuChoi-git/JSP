package web.jsp0206.mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainController extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//모든 요청이 이곳으로 들어오니, uri를 분석하여 요청에 따라 맞는 처리를 하고 요천에 맞는 jsp페이지를 forward 시키자.
		
		
		// #1. uri 분석
		
		String uri = request.getRequestURI();
		System.out.println("uri =====> " + uri);
		
		// #2. 각 uri 요청에 따른 처리
		
		String view = "";
		
		if(uri.equals("/web/login.git")) {
			view = "/jsp0206/loginForm.jsp";
		}else if(uri.equals("/web/loginPro.git")) {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			//DB 연결 처리...
			int check = 1; 
			request.setAttribute("check", check);
			view = "/jsp0206/loginPro.jsp";
		}
		
		
		// #3. 페이지 포워드
		
		request.getRequestDispatcher(view).forward(request, response);;
		
		
		
	}
	
}
