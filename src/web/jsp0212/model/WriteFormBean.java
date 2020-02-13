package web.jsp0212.model;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import web.jsp0211.model.MemberDAO;
import web.jsp0211.model.MemberDTO;

public class WriteFormBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		
		
		//세션처리
		HttpSession s = req.getSession();
		
		boolean memCheck = false;
		String session = (String)s.getAttribute("memId");
		if(s.getAttribute("memId") != null) {
			memCheck = true;
		}
		

		int num = 0, ref = 1, re_step = 0, re_level = 0;
		// num(새글작성0, 답글 1이상), ref는 기본그룹 1
		
		// 답글일때 처리 : num, ref,re_step,re_level
		if(req.getParameter("num") != null){	// 답글일경우에만 num 파라미터 들고옴.
			// 답글버튼 눌러서 함께 넘어온 정보 위 초기값 무시하고 덮어쓰기
			num = Integer.parseInt(req.getParameter("num"));
			ref = Integer.parseInt(req.getParameter("ref"));
			re_step = Integer.parseInt(req.getParameter("re_step"));
			re_level = Integer.parseInt(req.getParameter("re_level"));
		}
		
		MemberDAO dao = MemberDAO.getInstance();
		MemberDTO member = dao.getMember(session);
		
		req.setAttribute("num", num);
		req.setAttribute("ref", ref);
		req.setAttribute("re_step", re_step);
		req.setAttribute("re_level", re_level);
		req.setAttribute("memCheck", memCheck);
		req.setAttribute("member", member);

		return "/WEB-INF/board_views/writeForm.jsp";
	}

}
