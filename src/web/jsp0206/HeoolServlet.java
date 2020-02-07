package web.jsp0206;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/HeoolServlet")
public class HeoolServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public HeoolServlet() {
        super();
    }
    
    @Override    //실제 구동시점인 메소드
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	//int y = 200;
    	//System.out.println(y);
    	
    	PrintWriter pw = response.getWriter();
    	pw.println("<html>");
    	pw.println("<body>");
    	pw.println("<h2>Hellosevlet!!!</h2>");
    	pw.println("</body>");
    	pw.println("</html>");
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get 요청을 받았을 때 처리해야할 로직 작성
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//post 요청을 받았을 때 처리해야할 로직 작성
		doGet(request, response);
	}

}
