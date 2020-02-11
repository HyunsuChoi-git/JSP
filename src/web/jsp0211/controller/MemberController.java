package web.jsp0211.controller;

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

import web.jsp0211.model.SuperBean;

public class MemberController extends HttpServlet {
	Map beans = new HashMap();
	
	@Override
	public void init(ServletConfig con) throws ServletException {
		String path = con.getInitParameter("propertiesConfig");
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
				
				beans.put(key, obj);
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String uri = req.getRequestURI();
		Object obj = beans.get(uri);
		String view = "/WEB-INF/member_views/main.jsp";
		System.out.println(obj);
		SuperBean sb = null;
		if(obj instanceof SuperBean) {
			sb = (SuperBean)obj;
			view = sb.actionBean(req, resp);
		}
		
		req.getRequestDispatcher(view).forward(req, resp);
		
	}
}
