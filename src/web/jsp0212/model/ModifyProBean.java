package web.jsp0212.model;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ModifyProBean implements SuperBean {

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
			String pageNum = req.getParameter("pageNum");
			int num = Integer.parseInt(req.getParameter("num"));
		
			BoardDTO article = new BoardDTO();
			
			article.setPw(req.getParameter("pw"));
			article.setWriter(req.getParameter("writer"));
			article.setSubject(req.getParameter("subject"));
			article.setEmail(req.getParameter("email"));
			article.setContent(req.getParameter("content"));
			article.setNum(num);
			
			BoardDAO dao = BoardDAO.getInstance();
			int result = dao.updateArticle(article);
			
			req.setAttribute("result", result);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("num", num);
			
		}catch(Exception e) {
			wriCheck = false;
		}
		req.setAttribute("wriCheck", wriCheck);
		
		return "/WEB-INF/board_views/modifyPro.jsp";
	}

}
