package web.jsp0207.mvc;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class TestController extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//1. request 속성 추가
		
		request.setAttribute("num", 99);
		request.setAttribute("id", "java");
		
		//2. reqeust null 값 보내기
		request.setAttribute("data", null);
		
		//3. 문자형숫자 보내서 숫자 연산 확인
		request.setAttribute("age", "20");
		
		//4. session 값 보내기
		HttpSession session = request.getSession();
		session.setAttribute("num", 777);
		session.setAttribute("memId", "jsp");
		
		//5. 배열 보내기
		int [] arr = {10,20,30,40,50};
		request.setAttribute("arr", arr);
			
		//6. ArrayList 보내기
		ArrayList list = new ArrayList();
		list.add("피카츄");
		list.add("라이츄");
		list.add("파이리");
		list.add("꼬북칩");
		request.setAttribute("list", list);
		
		//7. TestVO     //클래스만들어서 클래스 보내보기
		TestVO vo = new TestVO();
		vo.setId("hera");
		vo.setName("헤라");
		vo.setAge(30);
		request.setAttribute("vo", vo);
		
		request.getRequestDispatcher("/jsp0207/test.jsp").forward(request, response);
		
		
		
		
		
	}
	
}
