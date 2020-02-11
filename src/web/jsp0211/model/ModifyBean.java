package web.jsp0211.model;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ModifyBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		
		
		// 로그인된 상태만 접근 가능하게..
		// 로그인 안된상태로 접근하면 loginForm으로 이동하게
		boolean check = false;
		HttpSession session = req.getSession();
		if(session.getAttribute("memId") != null) {  
			check = true;
		}
		
		req.setAttribute("check", check);
		return "/WEB-INF/member_views/modify.jsp";
	}

}
