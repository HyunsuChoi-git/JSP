package web.jsp0211.model;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginProBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) 
			throws ServerException, IOException {
			
			//로그인 상태 확인
		
			boolean check = true;
			HttpSession session = req.getSession();
			if(session.getAttribute("memId") == null) {
				
				//정상적으로 loginForm에서 넘어왔을 때
				//로그인 처리
	
				req.setCharacterEncoding("UTF-8");
				
				//#1. 파라미터 받기
				String id = req.getParameter("id");
				String pw = req.getParameter("pw");
				String auto = req.getParameter("auto"); // 자동로그인 파리미터 받기
				
				//#2. 쿠키 있으면 꺼내주기
				Cookie[] cs = req.getCookies();
				if(cs != null){
					for(Cookie coo : cs){
						if(coo.getName().equals("autoId")) id = coo.getValue();
						if(coo.getName().equals("autoPw")) pw = coo.getValue();
						if(coo.getName().equals("autoCh")) auto = coo.getValue();
					}
				}
				
				//#3. 로그인 체크
				MemberDAO dao = MemberDAO.getInstance();
				check = dao.loginCheck(id, pw);
				
				if(check) { // id-pw 일치할때
					// 세션 만들기 : 로그인 성공으로 앞으로 로그인상태 유지 시켜줄 세션 만들어주기.
					session.setAttribute("memId", id);
					// 자동로그인 체크 하고 로그인버튼 눌렀을때 ---> 쿠키 생성
					if(auto != null){ // 자동로그인 체크했다면,
						// 쿠키 객체 생성
						Cookie c1 = new Cookie("autoId", id);
						Cookie c2 = new Cookie("autoPw", pw);
						Cookie c3 = new Cookie("autoCh", auto);
						// 쿠키들 유효기간 설정
						c1.setMaxAge(60*60*24);
						c2.setMaxAge(60*60*24);
						c3.setMaxAge(60*60*24);
						// 적용
						resp.addCookie(c1);
						resp.addCookie(c2);
						resp.addCookie(c3);
					}
				}
				
				//check가 true이면 로그인 처리 후 아니면 그냥 check 값 보내주기
				
			}
			req.setAttribute("check", check);
		
		return "/WEB-INF/member_views/loginPro.jsp";
	}

}
