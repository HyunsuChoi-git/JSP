package web.jsp0211.model;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteFormBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		
		boolean check = false;
		HttpSession session = req.getSession();
		if(session.getAttribute("memId") != null) {
			check = true;
			
		}
		req.setAttribute("check", check);
		
		return "/WEB-INF/member_views/deleteForm.jsp";
	}

}
