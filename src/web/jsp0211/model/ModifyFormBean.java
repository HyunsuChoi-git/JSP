package web.jsp0211.model;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ModifyFormBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		
		
		boolean check = false;
		HttpSession session = req.getSession();
		if(session.getAttribute("memId") != null) { 
			check = true;
			// 로그인 된 상태에서 실행 == session에 memId 존재
			// DB에 접속해서 회원의 정보를 모두 긁어와 화면에 뿌려주기
			// session에 저장된 사용자의 id 꺼내기
			String id = (String)session.getAttribute("memId");
		
			MemberDAO dao = MemberDAO.getInstance();
			MemberDTO member = dao.getMember(id);
			
			req.setAttribute("member", member);
		}
		
		req.setAttribute("check", check);
		
		return "/WEB-INF/member_views/modifyForm.jsp";
	}

}
