package web.jsp0211.model;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Admin_deleteFormBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		
boolean admCheck = false;
		
		HttpSession session = req.getSession();
		if(session.getAttribute("memId").equals("admin")) { 
			admCheck = true;
			
			String id = req.getParameter("id");
			
			req.setAttribute("id", id);
		}
		
		req.setAttribute("admCheck", admCheck);
		
		
		return "/WEB-INF/member_views/admin_deleteForm.jsp";
	}

}
