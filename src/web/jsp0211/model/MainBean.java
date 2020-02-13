package web.jsp0211.model;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MainBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) 
			throws ServerException, IOException {
		
		// 로그인 상태 확인
		int check = -1;
		String admin = null;
		
		HttpSession session = req.getSession();
		// 세션X, 쿠키X => check = -1
		// 세션X, 쿠키O => check = 0
		// 세션O,      => check = 1
		
		if(session.getAttribute("memId") == null){  
			String id = null, pw = null, auto = null;	
			Cookie[] cs = req.getCookies();		
			if(cs != null){								
				for(Cookie coo : cs){					
					if(coo.getName().equals("autoId")) id = coo.getValue(); 
					if(coo.getName().equals("autoPw")) pw = coo.getValue();
					if(coo.getName().equals("autoCh")) auto = coo.getValue();
				}
			}
			if(auto != null && id != null && pw != null){
				check = 0;
			}
		
		}else {
			check = 1;
		}
		if(session.getAttribute("memId") != null && session.getAttribute("memId").equals("admin")) {
			admin = "admin";
			req.setAttribute("admin", admin);
		}
		
		req.setAttribute("check", check);
		
		return "/WEB-INF/member_views/main.jsp";
	}	

}
