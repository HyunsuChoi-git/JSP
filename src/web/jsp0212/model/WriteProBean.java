package web.jsp0212.model;

import java.io.IOException;
import java.rmi.ServerException;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class WriteProBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		
		
		//세션처리
		HttpSession session = req.getSession();
		
		boolean wriCheck = false;
		if(session.getAttribute("memId") != null) {
			wriCheck = true;
		}
		
		req.setCharacterEncoding("UTF-8");	
		
		try {
			//작성자, 제목, email, 내용, 비밀번호, num, ref, re_step, re_level
			BoardDTO article = new BoardDTO();
			article.setWriter(req.getParameter("writer"));
			article.setSubject(req.getParameter("subject"));
			article.setContent(req.getParameter("content"));
			article.setEmail(req.getParameter("email"));
			article.setPw(req.getParameter("pw"));
			article.setNum(Integer.parseInt(req.getParameter("num")));
			article.setRef(Integer.parseInt(req.getParameter("ref")));
			article.setRe_level(Integer.parseInt(req.getParameter("re_level")));
			article.setRe_step(Integer.parseInt(req.getParameter("re_step")));
	
			article.setReg(new Timestamp(System.currentTimeMillis()));
			article.setIp(req.getRemoteAddr());
			// DB 저장
			BoardDAO dao = BoardDAO.getInstance();
			dao.insertArticle(article);
		}catch(Exception e) {
			wriCheck = false;
		}
		
		req.setAttribute("wriCheck", wriCheck);
		
		return "/WEB-INF/board_views/writePro.jsp";
	}

}
