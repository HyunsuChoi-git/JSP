package web.jsp0211.model;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		
		
		HttpSession session = req.getSession();
		session.invalidate();
		
		Cookie[] cs = req.getCookies();	
		if(cs != null){	// 쿠키가 있다면, 
			for(Cookie coo : cs){ 
				if(coo.getName().equals("autoId") || coo.getName().equals("autoPw") || coo.getName().equals("autoCh") ){	 
					coo.setMaxAge(0);
					resp.addCookie(coo);
				}
				
			}
		}
		
		return "/WEB-INF/member_views/logout.jsp";
	}

}
