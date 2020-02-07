package web.jsp0206.mvc;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelloController2 extends HttpServlet{
	
	//GenericServlet의 init() 오버라이딩
	@Override
	public void init(ServletConfig config) throws ServletException {
		//생성자처럼 한번 실행된다. 생성자라고 생각할 것.
		System.out.println("init!!!");
	}
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//요청할 때 마다 계속 실행된다.
		System.out.println("service!!!");
		
	}
}
