package web.jsp0212.controller;

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

import web.jsp0212.model.SuperBean;

public class BoardController extends HttpServlet {
	private Map beanMap = new HashMap();
	
	@Override
	public void init(ServletConfig con) throws ServletException {
		String path = (String)con.getInitParameter("propertiesConfig2");
		
		Properties p = null;
		InputStream is = null;
		try {
			is = new FileInputStream(path);
			p = new Properties();
			p.load(is);
			
			Iterator it = p.keySet().iterator();
			while(it.hasNext()) {
				String key = (String)it.next();
				String value = p.getProperty(key);
				
				Class c = Class.forName(value);
				Object obj = c.newInstance();
				
				beanMap.put(key, obj);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String uri = req.getRequestURI();
		Object obj = beanMap.get(uri);

		String view = "/WEB-INF/board_views/list.jsp";
		SuperBean sb = null;
		if(obj instanceof SuperBean) {
			
			sb = (SuperBean)obj;
			view = sb.actionBean(req, resp);
		}
		req.getRequestDispatcher(view).forward(req, resp);
		
	}

}
