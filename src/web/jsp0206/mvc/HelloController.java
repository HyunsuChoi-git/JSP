package web.jsp0206.mvc;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class HelloController extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//서블릿은 바로 실행 불가능. 요청과 맞물려 연결해 줄 웹 주소도 만들어줘야 함.,
		//web.xml 에 작업해야함.
		System.out.println("hello !!! controller!!!");
		
		// # jsp 페이지에 데이터 넘기기
		request.setAttribute("num", 1111);
		request.setAttribute("name", "test");
		
		// # session으로 데이터 넘기기
		HttpSession session = request.getSession();      
				//request에서 세션을 꺼내어 HttpSession타입 변수에 담아주어야 한다.
		session.setAttribute("memId", "java");
		
		
		
		// 해당 JSP 페이지 연결
		RequestDispatcher rd = request.getRequestDispatcher("/jsp0206/hello.jsp");
		rd.forward(request, response);
		//<jsp:forward> 태그를 자바로 바꾼 형태와 비슷
		
	}
}
