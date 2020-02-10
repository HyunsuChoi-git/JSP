package JSP.jsp0210.mvc;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberTestController extends HttpServlet{
	Map beanMap = new HashMap();
	
	@Override
	public void init(ServletConfig con) throws ServletException {
		String path = con.getInitParameter("propertiesTest");
		InputStream is = null;
		Properties p = null;
		
		try {
			is = new FileInputStream(path);
			p = new Properties();
			p.load(is);
			System.out.println(p);
			
			Iterator it = p.keySet().iterator();
			while(it.hasNext()) {
				String key = (String)it.next();
				String value = p.getProperty(key);
				
				Class c = Class.forName(value);
				Object obj = c.newInstance();
				System.out.println("obj="+obj);
				
				beanMap.put(key, obj);
				System.out.println(beanMap);
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		Object obj = beanMap.get(uri);
		
		
		System.out.println("uri="+uri);
		System.out.println("beanMap.get(uri)="+obj);
		
		String view = "/jsp0210/main.jsp";
		SuperBean sb = null;
		if(obj instanceof SuperBean) {
			sb = (SuperBean)obj;
			view = sb.actionBean(req, resp);
			System.out.println("view="+view);

		}
		
		req.getRequestDispatcher(view).forward(req, resp);
		
	}
	
}
