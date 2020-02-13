package web.jsp0212.model;

import java.io.IOException;
import java.rmi.ServerException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ContentBean implements SuperBean {

	@Override
	public String actionBean(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
		
		
		

		int num = Integer.parseInt(req.getParameter("num"));
		String pageNum = req.getParameter("pageNum");	
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
		
		BoardDAO dao = BoardDAO.getInstance();
		BoardDTO article = dao.getArticle(num);

		
		//세션, 글쓴이 체크
		HttpSession session = req.getSession();
		
		boolean memCheck = false;
		boolean wriCheck = false;
		if(session.getAttribute("memId") != null) {
			memCheck = true;
			if(session.getAttribute("memId").equals(article.getWriter())) {
				wriCheck = true;
			}
		}
		
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("num", num);
		req.setAttribute("sdf", sdf);
		req.setAttribute("article", article);
		req.setAttribute("memCheck", memCheck);
		req.setAttribute("wriCheck", wriCheck);
		
		return "/WEB-INF/board_views/content.jsp";
	}

}
