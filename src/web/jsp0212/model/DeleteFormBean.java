package web.jsp0212.model;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteFormBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		
		
		//세션처리
		
		boolean wriCheck = false;
		boolean admCheck = false;
		
		
		try {
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");
			
			req.setAttribute("num", num);
			req.setAttribute("pageNum", pageNum);
			
			wriCheck = true;
			
		}catch(Exception e) {
			wriCheck = false;
		}
		HttpSession session = req.getSession();
		if(session.getAttribute("memId").equals("admin")) { 
			admCheck = true;
		}
		
		req.setAttribute("wriCheck", wriCheck);
		req.setAttribute("admCheck", admCheck);
		
		return "/WEB-INF/board_views/deleteForm.jsp";
	}

}
