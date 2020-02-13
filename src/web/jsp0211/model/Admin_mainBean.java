package web.jsp0211.model;

import java.io.IOException;
import java.rmi.ServerException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Admin_mainBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		
		HttpSession session = req.getSession();
		
		boolean admCheck = false;
		if(session.getAttribute("memId").equals("admin")) {
			admCheck = true;
		}
		
		req.setAttribute("admCheck", admCheck);
		
		
		return "/WEB-INF/member_views/admin_main.jsp";
	}

}
