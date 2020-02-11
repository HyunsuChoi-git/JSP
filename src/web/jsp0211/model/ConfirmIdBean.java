package web.jsp0211.model;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ConfirmIdBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		

			// 로그아웃 상태만 접근 가능하게 
			boolean checkS = false;
			boolean check = false;
			HttpSession session = req.getSession();
			if(session.getAttribute("memId") == null) { 
				checkS = true;
				req.setCharacterEncoding("UTF-8");
			
				// 주소뒤에 붙혀온 파라미터 받기
				String id = req.getParameter("id");
				// DB 연결해서 입력받아 넘어온 id가 DB에 이미 존재하는지 확인
				MemberDAO dao = MemberDAO.getInstance();
				check = dao.confirmId(id);
				// check == true : DB에 이미 id가 존재한다. 
				// check == false : DB에 존재하지 않는 id (새로 가입하는 사용자가 사용가능한 id)
					
				req.setAttribute("id", id);
			}	
			req.setAttribute("check", check);
			req.setAttribute("checkS", checkS);
			System.out.println(check);
		
		return "/WEB-INF/member_views/confirmId.jsp";
	}

}
